import XCTest
import Postbox
@testable import IosappCore

/// Every channel post is stored with `threadId = 1`, so a history fill of a plain channel used to ask
/// the server for forum topic 1 on every fill (nothing came back, so nothing was stored, so it asked
/// again). Thread infos exist only for forums and monoforums.
final class ForumThreadResolutionGuardTests: XCTestCase {
    private func channel(flags: IosappChannelFlags, info: IosappChannelInfo) -> IosappChannel {
        return IosappChannel(
            id: PeerId(namespace: Namespaces.Peer.CloudChannel, id: PeerId.Id._internalFromInt64Value(100)),
            accessHash: nil,
            title: "c",
            username: nil,
            photo: [],
            creationDate: 0,
            version: 0,
            participationStatus: .left,
            info: info,
            flags: flags,
            restrictionInfo: nil,
            adminRights: nil,
            bannedRights: nil,
            defaultBannedRights: nil,
            usernames: [],
            storiesHidden: nil,
            nameColor: nil,
            backgroundEmojiId: nil,
            profileColor: nil,
            profileBackgroundEmojiId: nil,
            emojiStatus: nil,
            approximateBoostLevel: nil,
            subscriptionUntilDate: nil,
            verificationIconFileId: nil,
            sendPaidMessageStars: nil,
            linkedMonoforumId: nil
        )
    }

    func testPlainChannelHasNoThreads() {
        XCTAssertFalse(peerCanHaveForumThreads(self.channel(flags: [], info: .broadcast(IosappChannelBroadcastInfo(flags: [])))))
        XCTAssertFalse(peerCanHaveForumThreads(self.channel(flags: [], info: .group(IosappChannelGroupInfo(flags: [])))))
    }

    func testForumAndMonoforumKeepTheirThreads() {
        XCTAssertTrue(peerCanHaveForumThreads(self.channel(flags: [.isForum], info: .group(IosappChannelGroupInfo(flags: [])))))
        XCTAssertTrue(peerCanHaveForumThreads(self.channel(flags: [.isMonoforum], info: .group(IosappChannelGroupInfo(flags: [])))))
    }

    func testUnknownPeerHasNoThreads() {
        XCTAssertFalse(peerCanHaveForumThreads(nil))
    }
}
