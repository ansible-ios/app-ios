import Foundation
import IosappCore
import SwiftSignalKit
import IosappUIPreferences

private struct RecentlyVisitedLinkItemId {
    public let rawValue: EngineMemoryBuffer
    
    var value: String {
        return String(data: self.rawValue.makeData(), encoding: .utf8) ?? ""
    }
    
    init(_ rawValue: EngineMemoryBuffer) {
        self.rawValue = rawValue
    }
    
    init?(_ value: String) {
        if let data = value.data(using: .utf8) {
            self.rawValue = EngineMemoryBuffer(data: data)
        } else {
            return nil
        }
    }
}

public final class RecentVisitedLinkItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case webPage
    }
    
    public let webPage: IosappMediaWebpage
    
    public init(webPage: IosappMediaWebpage) {
        self.webPage = webPage
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let webPageData = try container.decodeIfPresent(Data.self, forKey: .webPage) {
            self.webPage = EnginePostboxDecoder(buffer: EngineMemoryBuffer(data: webPageData)).decodeRootObject() as! IosappMediaWebpage
        } else {
            fatalError()
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let encoder = EnginePostboxEncoder()
        encoder.encodeRootObject(self.webPage)
        let webPageData = encoder.makeData()
        try container.encode(webPageData, forKey: .webPage)
    }
}

func addRecentlyVisitedLink(engine: IosappEngine, webPage: IosappMediaWebpage) -> Signal<Never, NoError> {
    if let url = webPage.content.url, let itemId = RecentlyVisitedLinkItemId(url) {
        return engine.orderedLists.addOrMoveToFirstPosition(collectionId: ApplicationSpecificOrderedItemListCollectionId.browserRecentlyVisited, id: itemId.rawValue, item: RecentVisitedLinkItem(webPage: webPage), removeTailIfCountExceeds: 10)
    } else {
        return .complete()
    }
}

func removeRecentlyVisitedLink(engine: IosappEngine, url: String) -> Signal<Never, NoError> {
    if let itemId = RecentlyVisitedLinkItemId(url) {
        return engine.orderedLists.removeItem(collectionId: ApplicationSpecificOrderedItemListCollectionId.browserRecentlyVisited, id: itemId.rawValue)
    } else {
        return .complete()
    }
}

func clearRecentlyVisitedLinks(engine: IosappEngine) -> Signal<Never, NoError> {
    return engine.orderedLists.clear(collectionId: ApplicationSpecificOrderedItemListCollectionId.browserRecentlyVisited)
}

func recentlyVisitedLinks(engine: IosappEngine) -> Signal<[IosappMediaWebpage], NoError> {
    return engine.data.subscribe(IosappEngine.EngineData.Item.OrderedLists.ListItems(collectionId: ApplicationSpecificOrderedItemListCollectionId.browserRecentlyVisited))
    |> map { items -> [IosappMediaWebpage] in
        var result: [IosappMediaWebpage] = []
        for item in items {
            if let link = item.contents.get(RecentVisitedLinkItem.self) {
                result.append(link.webPage)
            }
        }
        return result
    }
}
