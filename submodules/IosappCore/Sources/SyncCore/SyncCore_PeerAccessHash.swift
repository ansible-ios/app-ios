import Foundation
import FlatBuffers
import FlatSerialization

public enum IosappPeerAccessHash: Hashable {
    case personal(Int64)
    case genericPublic(Int64)
    
    public var value: Int64 {
        switch self {
        case let .personal(personal):
            return personal
        case let .genericPublic(genericPublic):
            return genericPublic
        }
    }
    
    public init(flatBuffersObject: IosappCore_IosappPeerAccessHash) throws {
        switch flatBuffersObject.valueType {
        case .iosapppeeraccesshashPersonal:
            guard let personal = flatBuffersObject.value(type: IosappCore_IosappPeerAccessHash_Personal.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            self = .personal(personal.accessHash)
        case .iosapppeeraccesshashGenericpublic:
            guard let genericPublic = flatBuffersObject.value(type: IosappCore_IosappPeerAccessHash_GenericPublic.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            self = .genericPublic(genericPublic.accessHash)
        case .none_:
            throw FlatBuffersError.missingRequiredField()
        }
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let valueType: IosappCore_IosappPeerAccessHash_Value
        let valueOffset: Offset
        
        switch self {
        case let .personal(accessHash):
            valueType = .iosapppeeraccesshashPersonal
            let start = IosappCore_IosappPeerAccessHash_Personal.startIosappPeerAccessHash_Personal(&builder)
            IosappCore_IosappPeerAccessHash_Personal.add(accessHash: accessHash, &builder)
            valueOffset = IosappCore_IosappPeerAccessHash_Personal.endIosappPeerAccessHash_Personal(&builder, start: start)
        case let .genericPublic(accessHash):
            valueType = .iosapppeeraccesshashGenericpublic
            let start = IosappCore_IosappPeerAccessHash_GenericPublic.startIosappPeerAccessHash_GenericPublic(&builder)
            IosappCore_IosappPeerAccessHash_GenericPublic.add(accessHash: accessHash, &builder)
            valueOffset = IosappCore_IosappPeerAccessHash_GenericPublic.endIosappPeerAccessHash_GenericPublic(&builder, start: start)
        }
        
        let start = IosappCore_IosappPeerAccessHash.startIosappPeerAccessHash(&builder)
        IosappCore_IosappPeerAccessHash.add(valueType: valueType, &builder)
        IosappCore_IosappPeerAccessHash.add(value: valueOffset, &builder)
        return IosappCore_IosappPeerAccessHash.endIosappPeerAccessHash(&builder, start: start)
    }
}
