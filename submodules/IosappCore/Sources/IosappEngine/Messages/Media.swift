import Postbox

/// A media class defined outside IosappCore (an app-side pseudo-media such as a link-preview
/// placeholder). Conforming to this protocol is what lets `EngineMedia` wrap it, as `.custom`;
/// any other unknown `Media` class still traps in `EngineMedia.init(_:)`.
public protocol EngineCustomMedia: Media {
}

public enum EngineMedia: Equatable {
    public typealias Id = MediaId

    case image(IosappMediaImage)
    case file(IosappMediaFile)
    case geo(IosappMediaMap)
    case contact(IosappMediaContact)
    case action(IosappMediaAction)
    case dice(IosappMediaDice)
    case expiredContent(IosappMediaExpiredContent)
    case game(IosappMediaGame)
    case invoice(IosappMediaInvoice)
    case poll(IosappMediaPoll)
    case unsupported(IosappMediaUnsupported)
    case webFile(IosappMediaWebFile)
    case webpage(IosappMediaWebpage)
    case story(IosappMediaStory)
    case giveaway(IosappMediaGiveaway)
    case giveawayResults(IosappMediaGiveawayResults)
    case paidContent(IosappMediaPaidContent)
    case todo(IosappMediaTodo)
    case liveStream(IosappMediaLiveStream)
    case widget(IosappMediaWidget)
    case custom(EngineCustomMedia)

    public static func ==(lhs: EngineMedia, rhs: EngineMedia) -> Bool {
        switch lhs {
        case let .image(lhsValue):
            if case let .image(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .file(lhsValue):
            if case let .file(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .geo(lhsValue):
            if case let .geo(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .contact(lhsValue):
            if case let .contact(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .action(lhsValue):
            if case let .action(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .dice(lhsValue):
            if case let .dice(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .expiredContent(lhsValue):
            if case let .expiredContent(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .game(lhsValue):
            if case let .game(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .invoice(lhsValue):
            if case let .invoice(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .poll(lhsValue):
            if case let .poll(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .unsupported(lhsValue):
            if case let .unsupported(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .webFile(lhsValue):
            if case let .webFile(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .webpage(lhsValue):
            if case let .webpage(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .story(lhsValue):
            if case let .story(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .giveaway(lhsValue):
            if case let .giveaway(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .giveawayResults(lhsValue):
            if case let .giveawayResults(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .paidContent(lhsValue):
            if case let .paidContent(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .todo(lhsValue):
            if case let .todo(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .liveStream(lhsValue):
            if case let .liveStream(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .widget(lhsValue):
            if case let .widget(rhsValue) = rhs {
                return lhsValue == rhsValue
            } else {
                return false
            }
        case let .custom(lhsValue):
            if case let .custom(rhsValue) = rhs {
                return lhsValue.isEqual(to: rhsValue)
            } else {
                return false
            }
        }
    }
}

public extension EngineMedia {
    var id: Id? {
        switch self {
        case let .image(image):
            return image.id
        case let .file(file):
            return file.id
        case let .geo(geo):
            return geo.id
        case let .contact(contact):
            return contact.id
        case let .action(action):
            return action.id
        case let .dice(dice):
            return dice.id
        case let .expiredContent(expiredContent):
            return expiredContent.id
        case let .game(game):
            return game.id
        case let .invoice(invoice):
            return invoice.id
        case let .poll(poll):
            return poll.id
        case let .unsupported(unsupported):
            return unsupported.id
        case let .webFile(webFile):
            return webFile.id
        case let .webpage(webpage):
            return webpage.id
        case let .story(story):
            return story.id
        case let .giveaway(giveaway):
            return giveaway.id
        case let .giveawayResults(giveawayResults):
            return giveawayResults.id
        case let .paidContent(paidContent):
            return paidContent.id
        case .todo:
            return nil
        case .liveStream:
            return nil
        case .widget:
            return nil
        case let .custom(custom):
            return custom.id
        }
    }
}

public extension EngineMedia {
    init(_ media: Media) {
        switch media {
        case let image as IosappMediaImage:
            self = .image(image)
        case let file as IosappMediaFile:
            self = .file(file)
        case let geo as IosappMediaMap:
            self = .geo(geo)
        case let contact as IosappMediaContact:
            self = .contact(contact)
        case let action as IosappMediaAction:
            self = .action(action)
        case let dice as IosappMediaDice:
            self = .dice(dice)
        case let expiredContent as IosappMediaExpiredContent:
            self = .expiredContent(expiredContent)
        case let game as IosappMediaGame:
            self = .game(game)
        case let invoice as IosappMediaInvoice:
            self = .invoice(invoice)
        case let poll as IosappMediaPoll:
            self = .poll(poll)
        case let unsupported as IosappMediaUnsupported:
            self = .unsupported(unsupported)
        case let webFile as IosappMediaWebFile:
            self = .webFile(webFile)
        case let webpage as IosappMediaWebpage:
            self = .webpage(webpage)
        case let story as IosappMediaStory:
            self = .story(story)
        case let giveaway as IosappMediaGiveaway:
            self = .giveaway(giveaway)
        case let giveawayResults as IosappMediaGiveawayResults:
            self = .giveawayResults(giveawayResults)
        case let paidContent as IosappMediaPaidContent:
            self = .paidContent(paidContent)
        case let todo as IosappMediaTodo:
            self = .todo(todo)
        case let liveStream as IosappMediaLiveStream:
            self = .liveStream(liveStream)
        case let widget as IosappMediaWidget:
            self = .widget(widget)
        case let custom as EngineCustomMedia:
            self = .custom(custom)
        default:
            preconditionFailure()
        }
    }

    func _asMedia() -> Media {
        switch self {
        case let .image(image):
            return image
        case let .file(file):
            return file
        case let .geo(geo):
            return geo
        case let .contact(contact):
            return contact
        case let .action(action):
            return action
        case let .dice(dice):
            return dice
        case let .expiredContent(expiredContent):
            return expiredContent
        case let .game(game):
            return game
        case let .invoice(invoice):
            return invoice
        case let .poll(poll):
            return poll
        case let .unsupported(unsupported):
            return unsupported
        case let .webFile(webFile):
            return webFile
        case let .webpage(webpage):
            return webpage
        case let .story(story):
            return story
        case let .giveaway(giveaway):
            return giveaway
        case let .giveawayResults(giveawayResults):
            return giveawayResults
        case let .paidContent(paidContent):
            return paidContent
        case let .todo(todo):
            return todo
        case let .liveStream(liveStream):
            return liveStream
        case let .widget(widget):
            return widget
        case let .custom(custom):
            return custom
        }
    }
}
