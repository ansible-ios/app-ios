import Foundation

public struct ImageRepresentationWithReference: Equatable {
    public let representation: IosappMediaImageRepresentation
    public let reference: MediaResourceReference
    
    public init(representation: IosappMediaImageRepresentation, reference: MediaResourceReference) {
        self.representation = representation
        self.reference = reference
    }
}


public struct VideoRepresentationWithReference: Equatable {
    public let representation: IosappMediaImage.VideoRepresentation
    public let reference: MediaResourceReference
    
    public init(representation: IosappMediaImage.VideoRepresentation, reference: MediaResourceReference) {
        self.representation = representation
        self.reference = reference
    }
}
