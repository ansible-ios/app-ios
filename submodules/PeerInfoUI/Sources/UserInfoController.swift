import Foundation
import UIKit
import AsyncDisplayKit
import Display
import SwiftSignalKit
import IosappCore
import LegacyComponents
import IosappPresentationData
import ItemListUI
import PresentationDataUtils
import AccountContext
import TextFormat
import OverlayStatusController
import IosappStringFormatting
import AccountContext
import AlertUI
import PresentationDataUtils
import IosappNotices
import GalleryUI
import ItemListAvatarAndNameInfoItem
import PeerAvatarGalleryUI
import NotificationMuteSettingsUI
import NotificationSoundSelectionUI
import Markdown
import LocalizedPeerData
import PhoneNumberFormat
import IosappIntents

private func getUserPeer(engine: IosappEngine, peerId: EnginePeer.Id) -> Signal<(EnginePeer?, EnginePeer.StatusSettings?), NoError> {
    return engine.data.get(IosappEngine.EngineData.Item.Peer.Peer(id: peerId))
    |> mapToSignal { peer -> Signal<EnginePeer?, NoError> in
        if case let .secretChat(secretChat) = peer {
            return engine.data.get(IosappEngine.EngineData.Item.Peer.Peer(id: secretChat.regularPeerId))
        } else {
            return .single(peer)
        }
    }
    |> mapToSignal { peer -> Signal<(EnginePeer?, EnginePeer.StatusSettings?), NoError> in
        guard let peer = peer else {
            return .single((nil, nil))
        }
        return engine.data.get(IosappEngine.EngineData.Item.Peer.StatusSettings(id: peer.id))
        |> map { statusSettings -> (EnginePeer?, EnginePeer.StatusSettings?) in
            return (peer, statusSettings)
        }
    }
}

public func openAddPersonContactImpl(context: AccountContext, updatedPresentationData: (initial: PresentationData, signal: Signal<PresentationData, NoError>)? = nil, peerId: EnginePeer.Id, pushController: @escaping (ViewController) -> Void, present: @escaping (ViewController, Any?) -> Void, completion: @escaping () -> Void = {}) {
    let _ = (getUserPeer(engine: context.engine, peerId: peerId)
    |> deliverOnMainQueue).start(next: { peer, statusSettings in
        guard let peer, case let .user(user) = peer else {
            return
        }
        
        var shareViaException = false
        if let statusSettings = statusSettings {
            shareViaException = statusSettings.contains(.addExceptionWhenAddingContact)
        }

        let controller = context.sharedContext.makeNewContactScreen(
            context: context,
            peer: peer,
            firstName: nil,
            lastName: nil,
            phoneNumber: user.phone,
            shareViaException: shareViaException,
            completion: { peer, _, _ in
                if let peer {
                    completion()
                    
                    let presentationData = context.sharedContext.currentPresentationData.with { $0 }
                    present(OverlayStatusController(theme: presentationData.theme, type: .genericSuccess(presentationData.strings.AddContact_StatusSuccess(peer.compactDisplayTitle).string, true)), nil)
                }
            }
        )
        pushController(controller)
    })
}
