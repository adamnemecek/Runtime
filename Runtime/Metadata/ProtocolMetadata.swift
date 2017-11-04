//
//  ProtocolMetadata.swift
//  Runtime
//
//  Created by Wes Wickwire on 11/4/17.
//  Copyright © 2017 Wes Wickwire. All rights reserved.
//

import Foundation



struct ProtocolMetadata: MetadataType {
    
    var type: Any.Type
    var metadata: UnsafeMutablePointer<ProtocolMetadataLayout>
    var base: UnsafeMutablePointer<Int>
    var protocolDescriptor: UnsafeMutablePointer<ProtocolDescriptor>
    
    init(type: Any.Type) {
        self.type = type
        base = metadataPointer(type: type)
        metadata = base.advanced(by: -1).raw.assumingMemoryBound(to: ProtocolMetadataLayout.self)
        protocolDescriptor = metadata.pointee.protocolDescriptorVector
    }
    
    mutating func mangledName() -> String {
        return String(cString: protocolDescriptor.pointee.mangledName)
    }
}
