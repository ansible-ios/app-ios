import XCTest
import IosappCore
@testable import TextFormat

final class MentionDateMarkersTests: XCTestCase {
    func testMentionRoundTrip() {
        let peerId = EnginePeer.Id(12345)
        let url = mentionMarkdownURL(peerId: peerId)
        XCTAssertEqual(url, "as://user?id=12345&v=2")
        XCTAssertEqual(url.flatMap { parseMentionPeerId(fromURL: $0) }, peerId)
    }

    func testMentionCarriesTheRawUserId() {
        // Iosapp's own `tg://user?id=` link carries the raw user id, which a packed PeerId differs from for
        // every id of 2^32 and above: a pasted external link must name the same user.
        let peerId = EnginePeer.Id(namespace: Namespaces.Peer.CloudUser, id: EnginePeer.Id.Id._internalFromInt64Value((1 << 33) + 5))
        let url = mentionMarkdownURL(peerId: peerId)
        XCTAssertEqual(url, "as://user?id=8589934597&v=2")
        XCTAssertEqual(parseMentionPeerId(fromURL: "tg://user?id=8589934597"), peerId)
    }

    func testOnlyAUserHasAMentionMarker() {
        let channelId = EnginePeer.Id(namespace: Namespaces.Peer.CloudChannel, id: EnginePeer.Id.Id._internalFromInt64Value(777))
        XCTAssertNil(mentionMarkdownURL(peerId: channelId))
        XCTAssertNil(parseMentionPeerId(fromURL: "tg://user?id=0"))
        XCTAssertNil(parseMentionPeerId(fromURL: "tg://user?id=-5"))
        XCTAssertNil(parseMentionPeerId(fromURL: "tg://user?id=72057594037927936"))
        XCTAssertNil(mentionMarkdownURL(peerId: EnginePeer.Id(namespace: Namespaces.Peer.CloudUser, id: EnginePeer.Id.Id._internalFromInt64Value(0))))
    }

    func testOwnedLegacyPackedMentionSurvivesUpdate() {
        let peerId = EnginePeer.Id(namespace: Namespaces.Peer.CloudUser, id: EnginePeer.Id.Id._internalFromInt64Value((1 << 33) + 5))
        let oldMarker = "as://user?id=\(peerId.toInt64())"
        XCTAssertEqual(parseMentionPeerId(fromURL: oldMarker), peerId)
        XCTAssertEqual(mentionMarkdownURL(peerId: peerId), "as://user?id=8589934597&v=2")
        XCTAssertEqual(mentionMarkdownURL(peerId: peerId).flatMap { parseMentionPeerId(fromURL: $0) }, peerId)
    }

    func testOwnedMarkerRejectsInvalidPackedValuesBeforePeerConstruction() {
        for value in ["-1", "9223372036854775807", "36028797018963968", "4294967297", "1&v=3", "1&v=2&v=2"] {
            XCTAssertNil(parseMentionPeerId(fromURL: "as://user?id=\(value)"), value)
        }
        XCTAssertNil(parseMentionPeerId(fromURL: "as://user?id=0&v=2"))
        XCTAssertNil(parseMentionPeerId(fromURL: "as://user?id=4503599627370496&v=2"))
    }

    func testMentionParseRejectsNonMatching() {
        XCTAssertNil(parseMentionPeerId(fromURL: "https://example.com"))
        XCTAssertNil(parseMentionPeerId(fromURL: "as://username?id=1"))
        XCTAssertNil(parseMentionPeerId(fromURL: "as://user?id=abc"))
        XCTAssertNil(parseMentionPeerId(fromURL: "as://user?id="))
        // Swift's Int64 init tolerates a leading '+'; self-generated URLs never contain one, but lock the behavior.
        XCTAssertNotNil(parseMentionPeerId(fromURL: "as://user?id=+1"))
    }

    func testDateRoundTrip() {
        XCTAssertEqual(dateMarkdownURL(timestamp: 1700000000), "as://timestamp?t=1700000000")
        XCTAssertEqual(parseDate(fromURL: "as://timestamp?t=1700000000"), 1700000000)
    }

    func testDateParseRejectsNonMatching() {
        XCTAssertNil(parseDate(fromURL: "as://user?id=1"))
        XCTAssertNil(parseDate(fromURL: "as://timestamp?t="))
        XCTAssertNil(parseDate(fromURL: "as://timestamp?t=notanumber"))
    }

    func testClassifyPrecedence() {
        guard case let .mention(p) = classifyChatLink("as://user?id=42") else { return XCTFail("expected mention") }
        XCTAssertEqual(p, EnginePeer.Id(42))
        guard case let .date(t) = classifyChatLink("as://timestamp?t=99") else { return XCTFail("expected date") }
        XCTAssertEqual(t, 99)
        guard case let .url(u) = classifyChatLink("https://example.com") else { return XCTFail("expected url") }
        XCTAssertEqual(u, "https://example.com")
    }

    func testClassifyNearMissesFallToUrl() {
        guard case .url = classifyChatLink("as://username?id=1") else { return XCTFail("as://username must be url") }
        guard case .url = classifyChatLink("as://user?id=abc") else { return XCTFail("non-numeric id must be url") }
        guard case .url = classifyChatLink("as://timestamp?t=") else { return XCTFail("empty timestamp must be url") }
    }

    func testCodecBoundaryValues() {
        // A negative timestamp parses cleanly (no sign special-casing); a user id of zero is no user.
        XCTAssertNil(parseMentionPeerId(fromURL: "tg://user?id=0"))
        XCTAssertEqual(parseDate(fromURL: "as://timestamp?t=-1"), -1)
    }
}
