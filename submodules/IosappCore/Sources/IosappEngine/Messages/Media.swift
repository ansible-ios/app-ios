import Postbox

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
        }
    }
}
