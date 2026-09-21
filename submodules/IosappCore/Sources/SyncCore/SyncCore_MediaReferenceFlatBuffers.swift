import Postbox
import FlatBuffers
import FlatSerialization

public extension PeerId {
    init(flatBuffersObject: IosappCore_PeerId) {
        self.init(namespace: PeerId.Namespace._internalFromInt32Value(flatBuffersObject.namespace), id: PeerId.Id._internalFromInt64Value(flatBuffersObject.id))
    }
}

public extension MessageId {
    init(flatBuffersObject: IosappCore_MessageId) {
        self.init(peerId: PeerId(flatBuffersObject: flatBuffersObject.peerId), namespace: flatBuffersObject.namespace, id: flatBuffersObject.id)
    }
}

public extension MessageReference {
    init(flatBuffersObject: IosappCore_MessageReference) throws {
        self.init(content: .message(
            peer: try PeerReference(flatBuffersObject: flatBuffersObject.peer),
            author: try flatBuffersObject.author.flatMap { try PeerReference(flatBuffersObject: $0) },
            id: MessageId(flatBuffersObject: flatBuffersObject.messageId),
            timestamp: flatBuffersObject.timestamp,
            incoming: flatBuffersObject.incoming,
            secret: flatBuffersObject.secret,
            threadId: flatBuffersObject.threadId == Int64.min ? nil : flatBuffersObject.threadId)
        )
    }
    
    func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset? {
        switch self.content {
        case let .message(peer, author, id, timestamp, incoming, secret, threadId):
            let peerOffset = peer.encodeToFlatBuffers(builder: &builder)
            let authorOffset = author.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
            
            let start = IosappCore_MessageReference.startMessageReference(&builder)
            
            IosappCore_MessageReference.add(peer: peerOffset, &builder)
            if let authorOffset {
                IosappCore_MessageReference.add(author: authorOffset, &builder)
            }
            IosappCore_MessageReference.add(messageId: IosappCore_MessageId(peerId: IosappCore_PeerId(namespace: id.peerId.namespace._internalGetInt32Value(), id: id.peerId.id._internalGetInt64Value()), namespace: id.namespace, id: id.id), &builder)
            IosappCore_MessageReference.add(timestamp: timestamp, &builder)
            IosappCore_MessageReference.add(incoming: incoming, &builder)
            IosappCore_MessageReference.add(secret: secret, &builder)
            IosappCore_MessageReference.add(threadId: threadId ?? Int64.min, &builder)
            
            return IosappCore_MessageReference.endMessageReference(&builder, start: start)
        case .none:
            return nil
        }
    }
}

public extension WebpageReference {
    init(flatBuffersObject: IosappCore_WebpageReference) throws {
        self.init(content: .webPage(id: flatBuffersObject.webpageId, url: flatBuffersObject.url))
    }
    
    func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset? {
        switch self.content {
        case let .webPage(id, url):
            let urlOffset = builder.create(string: url)
            
            let start = IosappCore_WebpageReference.startWebpageReference(&builder)
            
            IosappCore_WebpageReference.add(webpageId: id, &builder)
            IosappCore_WebpageReference.add(url: urlOffset, &builder)
            
            return IosappCore_WebpageReference.endWebpageReference(&builder, start: start)
        case .none:
            return nil
        }
    }
}

public extension PartialMediaReference {
    init?(flatBuffersObject: IosappCore_PartialMediaReference) throws {
        switch flatBuffersObject.valueType {
        case .partialmediareferenceMessage:
            guard let value = flatBuffersObject.value(type: IosappCore_PartialMediaReference_Message.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            if let message = value.message {
                self = .message(message: try MessageReference(flatBuffersObject: message))
            } else {
                self = .message(message: MessageReference(content: .none))
            }
        case .partialmediareferenceWebpage:
            guard let value = flatBuffersObject.value(type: IosappCore_PartialMediaReference_WebPage.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            if let webPage = value.webPage {
                self = .webPage(webPage: try WebpageReference(flatBuffersObject: webPage))
            } else {
                self = .webPage(webPage: WebpageReference(content: .none))
            }
        case .partialmediareferenceStickerpack:
            guard let value = flatBuffersObject.value(type: IosappCore_PartialMediaReference_StickerPack.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            self = .stickerPack(stickerPack: try StickerPackReference(flatBuffersObject: value.stickerPack))
        case .partialmediareferenceSavedgif:
            self = .savedGif
        case .partialmediareferenceSavedsticker:
            self = .savedSticker
        case .partialmediareferenceRecentsticker:
            self = .recentSticker
        case .partialmediareferenceSavedmusic:
            guard let value = flatBuffersObject.value(type: IosappCore_PartialMediaReference_SavedMusic.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            if let peer = value.peer {
                self = .savedMusic(peer: try PeerReference(flatBuffersObject: peer))
            } else {
                return nil
            }
        case .none_:
            throw FlatBuffersError.missingRequiredField()
        }
    }
    
    func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let valueType: IosappCore_PartialMediaReference_Value
        let valueOffset: Offset
        switch self {
        case let .message(message):
            let messageOffset = message.encodeToFlatBuffers(builder: &builder)
            let start = IosappCore_PartialMediaReference_Message.startPartialMediaReference_Message(&builder)
            if let messageOffset {
                IosappCore_PartialMediaReference_Message.add(message: messageOffset, &builder)
            }
            valueType = .partialmediareferenceMessage
            valueOffset = IosappCore_PartialMediaReference_Message.endPartialMediaReference_Message(&builder, start: start)
        case let .webPage(webPage):
            let webpageOffset = webPage.encodeToFlatBuffers(builder: &builder)
            let start = IosappCore_PartialMediaReference_WebPage.startPartialMediaReference_WebPage(&builder)
            if let webpageOffset {
                IosappCore_PartialMediaReference_WebPage.add(webPage: webpageOffset, &builder)
            }
            valueType = .partialmediareferenceWebpage
            valueOffset = IosappCore_PartialMediaReference_WebPage.endPartialMediaReference_WebPage(&builder, start: start)
        case let .stickerPack(stickerPack):
            let stickerPackOffset = stickerPack.encodeToFlatBuffers(builder: &builder)
            let start = IosappCore_PartialMediaReference_StickerPack.startPartialMediaReference_StickerPack(&builder)
            IosappCore_PartialMediaReference_StickerPack.add(stickerPack: stickerPackOffset, &builder)
            valueType = .partialmediareferenceStickerpack
            valueOffset = IosappCore_PartialMediaReference_StickerPack.endPartialMediaReference_StickerPack(&builder, start: start)
        case .savedGif:
            let start = IosappCore_PartialMediaReference_SavedGif.startPartialMediaReference_SavedGif(&builder)
            valueType = .partialmediareferenceSavedgif
            valueOffset = IosappCore_PartialMediaReference_SavedGif.endPartialMediaReference_SavedGif(&builder, start: start)
        case .savedSticker:
            let start = IosappCore_PartialMediaReference_SavedSticker.startPartialMediaReference_SavedSticker(&builder)
            valueType = .partialmediareferenceSavedsticker
            valueOffset = IosappCore_PartialMediaReference_SavedSticker.endPartialMediaReference_SavedSticker(&builder, start: start)
        case .recentSticker:
            let start = IosappCore_PartialMediaReference_RecentSticker.startPartialMediaReference_RecentSticker(&builder)
            valueType = .partialmediareferenceRecentsticker
            valueOffset = IosappCore_PartialMediaReference_RecentSticker.endPartialMediaReference_RecentSticker(&builder, start: start)
        case let .savedMusic(peer):
            let peerOffset = peer.encodeToFlatBuffers(builder: &builder)
            let start = IosappCore_PartialMediaReference_SavedMusic.startPartialMediaReference_SavedMusic(&builder)
            IosappCore_PartialMediaReference_SavedMusic.add(peer: peerOffset, &builder)
            valueType = .partialmediareferenceSavedmusic
            valueOffset = IosappCore_PartialMediaReference_SavedMusic.endPartialMediaReference_SavedMusic(&builder, start: start)
        }
        
        return IosappCore_PartialMediaReference.createPartialMediaReference(&builder, valueType: valueType, valueOffset: valueOffset)
    }
}
