import Postbox
import FlatBuffers
import FlatSerialization

public enum IosappGroupRole: Equatable, PostboxCoding {
    case creator(rank: String?)
    case admin(IosappChatAdminRights, rank: String?)
    case member
    
    public init(decoder: PostboxDecoder) {
        switch decoder.decodeInt32ForKey("_v", orElse: 0) {
            case 0:
                self = .creator(rank: decoder.decodeOptionalStringForKey("rank"))
            case 1:
                self = .admin(decoder.decodeObjectForKey("r", decoder: { IosappChatAdminRights(decoder: $0) }) as! IosappChatAdminRights, rank: decoder.decodeOptionalStringForKey("rank"))
            case 2:
                self = .member
            default:
                assertionFailure()
                self = .member
        }
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        switch self {
            case let .creator(rank):
                encoder.encodeInt32(0, forKey: "_v")
                if let rank = rank {
                    encoder.encodeString(rank, forKey: "rank")
                } else {
                    encoder.encodeNil(forKey: "rank")
                }
            case let .admin(rights, rank):
                encoder.encodeInt32(1, forKey: "_v")
                encoder.encodeObject(rights, forKey: "r")
                if let rank = rank {
                    encoder.encodeString(rank, forKey: "rank")
                } else {
                    encoder.encodeNil(forKey: "rank")
                }
            case .member:
                encoder.encodeInt32(2, forKey: "_v")
        }
    }
    
    public init(flatBuffersObject: IosappCore_IosappGroupRole) throws {
        switch flatBuffersObject.valueType {
        case .iosappgrouproleCreator:
            guard let creator = flatBuffersObject.value(type: IosappCore_IosappGroupRole_Creator.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            self = .creator(rank: creator.rank)
        case .iosappgrouproleAdmin:
            guard let admin = flatBuffersObject.value(type: IosappCore_IosappGroupRole_Admin.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            self = .admin(try IosappChatAdminRights(flatBuffersObject: admin.rights), rank: admin.rank)
        case .iosappgrouproleMember:
            self = .member
        case .none_:
            throw FlatBuffersError.missingRequiredField()
        }
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let valueOffset: Offset
        let valueType: IosappCore_IosappGroupRole_Value
        
        switch self {
        case let .creator(rank):
            let rankOffset = rank.map { builder.create(string: $0) }
            let start = IosappCore_IosappGroupRole_Creator.startIosappGroupRole_Creator(&builder)
            if let rankOffset {
                IosappCore_IosappGroupRole_Creator.add(rank: rankOffset, &builder)
            }
            valueOffset = IosappCore_IosappGroupRole_Creator.endIosappGroupRole_Creator(&builder, start: start)
            valueType = .iosappgrouproleCreator
        case let .admin(rights, rank):
            let rankOffset = rank.map { builder.create(string: $0) }
            let rightsOffset = rights.encodeToFlatBuffers(builder: &builder)
            
            let start = IosappCore_IosappGroupRole_Admin.startIosappGroupRole_Admin(&builder)
            IosappCore_IosappGroupRole_Admin.add(rights: rightsOffset, &builder)
            if let rankOffset {
                IosappCore_IosappGroupRole_Admin.add(rank: rankOffset, &builder)
            }
            valueOffset = IosappCore_IosappGroupRole_Admin.endIosappGroupRole_Admin(&builder, start: start)
            valueType = .iosappgrouproleAdmin
        case .member:
            let start = IosappCore_IosappGroupRole_Member.startIosappGroupRole_Member(&builder)
            valueOffset = IosappCore_IosappGroupRole_Member.endIosappGroupRole_Member(&builder, start: start)
            valueType = .iosappgrouproleMember
        }
        
        let start = IosappCore_IosappGroupRole.startIosappGroupRole(&builder)
        IosappCore_IosappGroupRole.add(value: valueOffset, &builder)
        IosappCore_IosappGroupRole.add(valueType: valueType, &builder)
        return IosappCore_IosappGroupRole.endIosappGroupRole(&builder, start: start)
    }
}

public enum IosappGroupMembership: Int32 {
    case Member
    case Left
    case Removed
}

public struct IosappGroupFlags: OptionSet {
    public var rawValue: Int32
    
    public init() {
        self.rawValue = 0
    }
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let deactivated = IosappGroupFlags(rawValue: 1 << 1)
    public static let hasVoiceChat = IosappGroupFlags(rawValue: 1 << 2)
    public static let hasActiveVoiceChat = IosappGroupFlags(rawValue: 1 << 3)
    public static let copyProtectionEnabled = IosappGroupFlags(rawValue: 1 << 4)
    public static let customRanksEnabled = IosappGroupFlags(rawValue: 1 << 5)
}

public struct IosappGroupToChannelMigrationReference: Equatable {
    public let peerId: PeerId
    public let accessHash: Int64
    
    public init(peerId: PeerId, accessHash: Int64) {
        self.peerId = peerId
        self.accessHash = accessHash
    }
    
    public init(flatBuffersObject: IosappCore_IosappGroupToChannelMigrationReference) throws {
        self.peerId = PeerId(flatBuffersObject.peerId)
        self.accessHash = flatBuffersObject.accessHash
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let start = IosappCore_IosappGroupToChannelMigrationReference.startIosappGroupToChannelMigrationReference(&builder)
        IosappCore_IosappGroupToChannelMigrationReference.add(peerId: self.peerId.toInt64(), &builder)
        IosappCore_IosappGroupToChannelMigrationReference.add(accessHash: self.accessHash, &builder)
        return IosappCore_IosappGroupToChannelMigrationReference.endIosappGroupToChannelMigrationReference(&builder, start: start)
    }
}

public final class IosappGroup: Peer, Equatable {
    public let id: PeerId
    public let title: String
    public let photo: [IosappMediaImageRepresentation]
    public let participantCount: Int
    public let role: IosappGroupRole
    public let membership: IosappGroupMembership
    public let flags: IosappGroupFlags
    public let defaultBannedRights: IosappChatBannedRights?
    public let migrationReference: IosappGroupToChannelMigrationReference?
    public let creationDate: Int32
    public let version: Int
    
    public var indexName: PeerIndexNameRepresentation {
        return .title(title: self.title, addressNames: [])
    }
    
    public var associatedMediaIds: [MediaId]? { return nil }
    
    public let associatedPeerId: PeerId? = nil
    public let notificationSettingsPeerId: PeerId? = nil
    
    public var timeoutAttribute: UInt32? { return nil }
    
    public init(id: PeerId, title: String, photo: [IosappMediaImageRepresentation], participantCount: Int, role: IosappGroupRole, membership: IosappGroupMembership, flags: IosappGroupFlags, defaultBannedRights: IosappChatBannedRights?, migrationReference: IosappGroupToChannelMigrationReference?, creationDate: Int32, version: Int) {
        self.id = id
        self.title = title
        self.photo = photo
        self.participantCount = participantCount
        self.role = role
        self.membership = membership
        self.flags = flags
        self.defaultBannedRights = defaultBannedRights
        self.migrationReference = migrationReference
        self.creationDate = creationDate
        self.version = version
    }
    
    public init(decoder: PostboxDecoder) {
        self.id = PeerId(decoder.decodeInt64ForKey("i", orElse: 0))
        self.title = decoder.decodeStringForKey("t", orElse: "")
        self.photo = decoder.decodeObjectArrayForKey("ph")
        self.participantCount = Int(decoder.decodeInt32ForKey("pc", orElse: 0))
        if let role = decoder.decodeObjectForKey("rv", decoder: { IosappGroupRole(decoder: $0) }) as? IosappGroupRole {
            self.role = role
        } else if let roleValue = decoder.decodeOptionalInt32ForKey("r"), roleValue == 0 {
            self.role = .creator(rank: nil)
        } else {
            self.role = .member
        }
        self.membership = IosappGroupMembership(rawValue: decoder.decodeInt32ForKey("m", orElse: 0))!
        self.flags = IosappGroupFlags(rawValue: decoder.decodeInt32ForKey("f", orElse: 0))
        self.defaultBannedRights = decoder.decodeObjectForKey("dbr", decoder: { IosappChatBannedRights(decoder: $0) }) as? IosappChatBannedRights
        let migrationPeerId: Int64? = decoder.decodeOptionalInt64ForKey("mr.i")
        let migrationAccessHash: Int64? = decoder.decodeOptionalInt64ForKey("mr.a")
        if let migrationPeerId = migrationPeerId, let migrationAccessHash = migrationAccessHash {
            self.migrationReference = IosappGroupToChannelMigrationReference(peerId: PeerId(migrationPeerId), accessHash: migrationAccessHash)
        } else {
            self.migrationReference = nil
        }
        self.creationDate = decoder.decodeInt32ForKey("d", orElse: 0)
        self.version = Int(decoder.decodeInt32ForKey("v", orElse: 0))
        
        #if DEBUG && false
        var builder = FlatBufferBuilder(initialSize: 1024)
        let offset = self.encodeToFlatBuffers(builder: &builder)
        builder.finish(offset: offset)
        let serializedData = builder.data
        var byteBuffer = ByteBuffer(data: serializedData)
        let deserializedValue = FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappGroup
        let parsedValue = try! IosappGroup(flatBuffersObject: deserializedValue)
        assert(self == parsedValue)
        #endif
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt64(self.id.toInt64(), forKey: "i")
        encoder.encodeString(self.title, forKey: "t")
        encoder.encodeObjectArray(self.photo, forKey: "ph")
        encoder.encodeInt32(Int32(self.participantCount), forKey: "pc")
        encoder.encodeObject(self.role, forKey: "rv")
        encoder.encodeInt32(self.membership.rawValue, forKey: "m")
        encoder.encodeInt32(self.flags.rawValue, forKey: "f")
        if let defaultBannedRights = self.defaultBannedRights {
            encoder.encodeObject(defaultBannedRights, forKey: "dbr")
        } else {
            encoder.encodeNil(forKey: "dbr")
        }
        if let migrationReference = self.migrationReference {
            encoder.encodeInt64(migrationReference.peerId.toInt64(), forKey: "mr.i")
            encoder.encodeInt64(migrationReference.accessHash, forKey: "mr.a")
        } else {
            encoder.encodeNil(forKey: "mr.i")
            encoder.encodeNil(forKey: "mr.a")
        }
        encoder.encodeInt32(self.creationDate, forKey: "d")
        encoder.encodeInt32(Int32(self.version), forKey: "v")
    }

    public init(flatBuffersObject: IosappCore_IosappGroup) throws {
        self.id = PeerId(flatBuffersObject.id)
        self.title = flatBuffersObject.title
        self.photo = try (0 ..< flatBuffersObject.photoCount).map { try IosappMediaImageRepresentation(flatBuffersObject: flatBuffersObject.photo(at: $0)!) }
        self.participantCount = Int(flatBuffersObject.participantCount)
        
        guard let role = flatBuffersObject.role else {
            throw FlatBuffersError.missingRequiredField()
        }
        self.role = try IosappGroupRole(flatBuffersObject: role)
        
        self.membership = IosappGroupMembership(rawValue: flatBuffersObject.membership)!
        self.flags = IosappGroupFlags(rawValue: flatBuffersObject.flags)
        self.defaultBannedRights = try flatBuffersObject.defaultBannedRights.flatMap { try IosappChatBannedRights(flatBuffersObject: $0) }
        
        if let migrationReference = flatBuffersObject.migrationReference {
            self.migrationReference = try IosappGroupToChannelMigrationReference(flatBuffersObject: migrationReference)
        } else {
            self.migrationReference = nil
        }
        
        self.creationDate = flatBuffersObject.creationDate
        self.version = Int(flatBuffersObject.version)
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let titleOffset = builder.create(string: self.title)
        
        let photoOffsets = self.photo.map { $0.encodeToFlatBuffers(builder: &builder) }
        let photoOffset = builder.createVector(ofOffsets: photoOffsets, len: photoOffsets.count)
        
        let roleOffset = self.role.encodeToFlatBuffers(builder: &builder)
        let defaultBannedRightsOffset = self.defaultBannedRights?.encodeToFlatBuffers(builder: &builder)
        
        let migrationReferenceOffset = self.migrationReference?.encodeToFlatBuffers(builder: &builder)
        
        let start = IosappCore_IosappGroup.startIosappGroup(&builder)
        
        IosappCore_IosappGroup.add(id: self.id.asFlatBuffersObject(), &builder)
        IosappCore_IosappGroup.add(title: titleOffset, &builder)
        IosappCore_IosappGroup.addVectorOf(photo: photoOffset, &builder)
        IosappCore_IosappGroup.add(participantCount: Int32(self.participantCount), &builder)
        IosappCore_IosappGroup.add(role: roleOffset, &builder)
        IosappCore_IosappGroup.add(membership: self.membership.rawValue, &builder)
        IosappCore_IosappGroup.add(flags: self.flags.rawValue, &builder)
        
        if let defaultBannedRightsOffset {
            IosappCore_IosappGroup.add(defaultBannedRights: defaultBannedRightsOffset, &builder)
        }
        if let migrationReferenceOffset {
            IosappCore_IosappGroup.add(migrationReference: migrationReferenceOffset, &builder)
        }
        
        IosappCore_IosappGroup.add(creationDate: self.creationDate, &builder)
        IosappCore_IosappGroup.add(version: Int32(self.version), &builder)
        
        return IosappCore_IosappGroup.endIosappGroup(&builder, start: start)
    }
    
    public func isEqual(_ other: Peer) -> Bool {
        if let other = other as? IosappGroup {
            return self == other
        } else {
            return false
        }
    }

    public static func ==(lhs: IosappGroup, rhs: IosappGroup) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        if lhs.title != rhs.title {
            return false
        }
        if lhs.photo != rhs.photo {
            return false
        }
        if lhs.membership != rhs.membership {
            return false
        }
        if lhs.version != rhs.version {
            return false
        }
        if lhs.participantCount != rhs.participantCount {
            return false
        }
        if lhs.role != rhs.role {
            return false
        }
        if lhs.defaultBannedRights != rhs.defaultBannedRights {
            return false
        }
        if lhs.migrationReference != rhs.migrationReference {
            return false
        }
        if lhs.creationDate != rhs.creationDate {
            return false
        }
        if lhs.flags != rhs.flags {
            return false
        }
        return true
    }

    public func updateFlags(flags: IosappGroupFlags, version: Int) -> IosappGroup {
        return IosappGroup(id: self.id, title: self.title, photo: self.photo, participantCount: self.participantCount, role: self.role, membership: self.membership, flags: flags, defaultBannedRights: self.defaultBannedRights, migrationReference: self.migrationReference, creationDate: self.creationDate, version: version)
    }
    
    public func updateDefaultBannedRights(_ defaultBannedRights: IosappChatBannedRights?, version: Int) -> IosappGroup {
        return IosappGroup(id: self.id, title: self.title, photo: self.photo, participantCount: self.participantCount, role: self.role, membership: self.membership, flags: self.flags, defaultBannedRights: defaultBannedRights, migrationReference: self.migrationReference, creationDate: self.creationDate, version: version)
    }
    
    public func updateParticipantCount(_ participantCount: Int) -> IosappGroup {
        return IosappGroup(id: self.id, title: self.title, photo: self.photo, participantCount: participantCount, role: self.role, membership: self.membership, flags: self.flags, defaultBannedRights: self.defaultBannedRights, migrationReference: self.migrationReference, creationDate: self.creationDate, version: version)
    }
}
