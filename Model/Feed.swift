//
//  Feed.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import OptionallyDecodable

// MARK: - Post
struct Feed: Codable {
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let items: [ResultItem]
    let lastID: Int
    let lastSortingValue: Double
    let excludeIDS: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case items
        case lastID = "lastId"
        case lastSortingValue
        case excludeIDS = "excludeIds"
    }
}

// MARK: - ResultItem
struct ResultItem: Codable {
    @OptionallyDecodable var type: ItemType?
    let data: ItemData
}

// MARK: - ItemData
struct ItemData: Codable {
    @OptionallyDecodable var news: [News]?
    let lastID, id, type: Int?
    let author: NewsAuthor?
    let subsiteID: Int?
    @OptionallyDecodable var subsite: NewsAuthor?
    let title: String?
    let date: Int?
    let blocks: [PurpleBlock]?
    @OptionallyDecodable var warningFromEditor: JSONNull?
    let counters: Counters?
    @OptionallyDecodable var commentsSeenCount: JSONNull?
    let dateFavorite, hitsCount: Int?
    let isCommentsEnabled, isLikesEnabled, isFavorited, isRepost: Bool?
    let likes: Likes?
    let isPinned, canEdit: Bool?
    @OptionallyDecodable var repost: JSONNull?
    @OptionallyDecodable var repostID: JSONNull?
    @OptionallyDecodable var repostData: JSONNull?
    let isRepostedByMe: Bool?
    let stackedRepostsAuthors: [JSONAny]?
    let subscribedToTreads, isShowThanks, isStillUpdating, isFilledByEditors: Bool?
    let isEditorial, isPromoted: Bool?
    let recommendedType: String?
    let isAudioAvailable: Bool?
    let audioURL: String?
    let commentEditor: CommentEditor?
    @OptionallyDecodable var coAuthor: JSONNull?
    let isBlur, isPublished, isDisabledAd: Bool?

    enum CodingKeys: String, CodingKey {
        case news
        case lastID = "lastId"
        case id, type, author
        case subsiteID = "subsiteId"
        case subsite, title, date, blocks, warningFromEditor, counters, commentsSeenCount, dateFavorite, hitsCount, isCommentsEnabled, isLikesEnabled, isFavorited, isRepost, likes, isPinned, canEdit, repost
        case repostID = "repostId"
        case repostData, isRepostedByMe, stackedRepostsAuthors, subscribedToTreads, isShowThanks, isStillUpdating, isFilledByEditors, isEditorial, isPromoted, recommendedType, isAudioAvailable
        case audioURL = "audioUrl"
        case commentEditor, coAuthor, isBlur, isPublished, isDisabledAd
    }
}

// MARK: - NewsAuthor
struct NewsAuthor: Codable {
    let id: Int
    @OptionallyDecodable var uri: URI?
    let type: Int
    @OptionallyDecodable var subtype: Subtype?
    let name: String
    let description: String
    let avatar: Avatar
    let cover: Avatar?
    @OptionallyDecodable var badge: Badge?
    let badgeID: String?
    let isSubscribed, isVerified, isPlus, isPro: Bool
    let isUnverifiedBlogForCompanyWithoutPro, isOnline, isMuted, isUnsubscribable: Bool
    let isAvailableForMessenger, isFrozen, isRemovedByUserRequest: Bool
    let lastModificationDate: Int

    enum CodingKeys: String, CodingKey {
        case id, uri, type, subtype, name, description, avatar, cover, badge
        case badgeID = "badgeId"
        case isSubscribed, isVerified, isPlus, isPro, isUnverifiedBlogForCompanyWithoutPro, isOnline, isMuted, isUnsubscribable, isAvailableForMessenger, isFrozen, isRemovedByUserRequest, lastModificationDate
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    @OptionallyDecodable var type: AvatarType?
    let data: AvatarData
}

// MARK: - AvatarData
struct AvatarData: Codable {
    let uuid: String
    let width, height, size: Int
    @OptionallyDecodable var type: PurpleType?
    let color: String
    @OptionallyDecodable var hash: Hash?
    let externalService: [JSONAny]
    let duration: Double?
    let base64Preview: String?

    enum CodingKeys: String, CodingKey {
        case uuid, width, height, size, type, color, hash
        case externalService = "external_service"
        case duration
        case base64Preview = "base64preview"
    }
}

enum Hash: String, Codable {
    case empty = ""
    case the1C1Cbcb4C0E8Cccc = "1c1cbcb4c0e8cccc"
    case the20303838F0F03000 = "20303838f0f03000"
    case the2C6C0E1627192531 = "2c6c0e1627192531"
    case the3830207870E8Eaca = "3830207870e8eaca"
    case the40Cad7C6Ce8Ea5E4 = "40cad7c6ce8ea5e4"
    case the736968C8C8Dc5C57 = "736968c8c8dc5c57"
}

enum PurpleType: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
    case webp = "webp"
}

enum AvatarType: String, Codable {
    case image = "image"
}

enum Badge: String, Codable {
    case plus = "plus"
}

enum Subtype: String, Codable {
    case community = "community"
    case personalBlog = "personal_blog"
}

enum URI: String, Codable {
    case anime = "/anime"
    case cinema = "/cinema"
    case craft = "/craft"
    case empty = ""
    case flood = "/flood"
    case games = "/games"
    case photo = "/photo"
    case pixelart = "pixelart"
    case playstation = "playstation"
    case read = "/read"
}

// MARK: - PurpleBlock
struct PurpleBlock: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: PurpleData
    let cover, hidden: Bool
    let anchor: String
}

// MARK: - PurpleData
struct PurpleData: Codable {
    @OptionallyDecodable var text: String?
    @OptionallyDecodable var textTruncated: String?
    @OptionallyDecodable var items: ItemsUnion?
    @OptionallyDecodable var type: FluffyType?
    @OptionallyDecodable var osnovaEmbed: PurpleOsnovaEmbed?
    @OptionallyDecodable var style: Style?
    let uid, hash, tmpHash, title: String?
    let isPublic: Bool?
    let dateCreated: Int?
    let subline1, subline2: String?
    @OptionallyDecodable var textSize: TextSize?
    @OptionallyDecodable var image: Avatar?
    let video: Video?
    let description: String?
    let audio: Audio?

    enum CodingKeys: String, CodingKey {
        case text
        case textTruncated = "text_truncated"
        case items, type, osnovaEmbed, style, uid, hash
        case tmpHash = "tmp_hash"
        case title
        case isPublic = "is_public"
        case dateCreated = "date_created"
        case subline1, subline2
        case textSize = "text_size"
        case image, video, description, audio
    }
}

// MARK: - Audio
struct Audio: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: AudioData
}

// MARK: - AudioData
struct AudioData: Codable {
    let uuid, filename: String
    let size: Int
    let audioInfo: AudioInfo

    enum CodingKeys: String, CodingKey {
        case uuid, filename, size
        case audioInfo = "audio_info"
    }
}

// MARK: - AudioInfo
struct AudioInfo: Codable {
    let bitrate: Int
    let duration: Double
    let channel: String
    let framesCount: Int
    let format: String
    let listensCount: Int

    enum CodingKeys: String, CodingKey {
        case bitrate, duration, channel, framesCount, format
        case listensCount = "listens_count"
    }
}

enum AudioType: String, Codable {
    case audio = "audio"
    case delimiter = "delimiter"
    case header = "header"
    case incut = "incut"
    case list = "list"
    case media = "media"
    case osnovaEmbed = "osnovaEmbed"
    case person = "person"
    case quiz = "quiz"
    case quote = "quote"
    case text = "text"
    case video = "video"
}

enum ItemsUnion: Codable {
    case itemsClass(ItemsClass)
    case unionArray([ItemUnion])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([ItemUnion].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(ItemsClass.self) {
            self = .itemsClass(x)
            return
        }
        throw DecodingError.typeMismatch(ItemsUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ItemsUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .itemsClass(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}

enum ItemUnion: Codable {
    case itemItem(ItemItem)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ItemItem.self) {
            self = .itemItem(x)
            return
        }
        throw DecodingError.typeMismatch(ItemUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ItemUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .itemItem(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ItemItem
struct ItemItem: Codable {
    let title: String
    let image: Avatar
}

// MARK: - ItemsClass
struct ItemsClass: Codable {
    let a17034460550, a17034460551, a17034461440, a17034461441: String?
    let a17034462400, a17034462401, a17034463280, a17034463281: String?
    let a17034464660, a17034464661, a17034465730, a17034465731: String?
    let a17033373510, a17033373511, a17033373702, a17033373773: String?
    let a17033373824, a17033373885, a17034475880, a17034475881: String?
    let a17034476192, a17034476253, a17034476294, a17034476355: String?
}

// MARK: - PurpleOsnovaEmbed
struct PurpleOsnovaEmbed: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: FluffyData
}

// MARK: - FluffyData
struct FluffyData: Codable {
    let originalID: Int
    let isNotAvailable: Bool
    let title, description: String
    let isEditorial: Bool
    let image: Avatar
    let url: String
    let blocks: [FluffyBlock]
    let date: Int
    let author, subsite: PurpleAuthor
    let likes, comments: Int
    let isBlur: Bool

    enum CodingKeys: String, CodingKey {
        case originalID = "original_id"
        case isNotAvailable, title, description, isEditorial, image, url, blocks, date, author, subsite, likes, comments, isBlur
    }
}

// MARK: - PurpleAuthor
struct PurpleAuthor: Codable {
    let id: Int
    let name: String
    let avatar: Avatar
}

// MARK: - FluffyBlock
struct FluffyBlock: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: TentacledData
    let cover, hidden: Bool
    let anchor: String
}

// MARK: - TentacledData
struct TentacledData: Codable {
    let text, textTruncated: String?
    let items: [ItemItem]?

    enum CodingKeys: String, CodingKey {
        case text
        case textTruncated = "text_truncated"
        case items
    }
}

enum Style: String, Codable {
    case h2 = "h2"
}

enum TextSize: String, Codable {
    case big = "big"
    case empty = ""
    case medium = "medium"
    case small = "small"
}

enum FluffyType: String, Codable {
    case empty = ""
    case typeDefault = "default"
    case typeLeft = "left"
    case ul = "UL"
}

// MARK: - Video
struct Video: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: VideoData
}

// MARK: - VideoData
struct VideoData: Codable {
    let thumbnail: Avatar
    let width, height, time: Int
    let externalService: ExternalService

    enum CodingKeys: String, CodingKey {
        case thumbnail, width, height, time
        case externalService = "external_service"
    }
}

// MARK: - ExternalService
struct ExternalService: Codable {
    let name, id: String
}

// MARK: - CommentEditor
struct CommentEditor: Codable {
    let enabled: Bool
}

// MARK: - Counters
struct Counters: Codable {
    let comments, favorites, reposts, views: Int
    let hits: Int
    var reads: JSONNull?
}

// MARK: - Likes
struct Likes: Codable {
    let counterLikes: Int
    let counterDislikes: JSONNull?
    let isLiked: Int
    let isHidden: Bool
}

// MARK: - News
struct News: Codable {
    let id, type: Int
    let author: NewsAuthor
    let subsiteID: Int
    let subsite: NewsAuthor
    let title: String
    let date: Int
    let blocks: [NewsBlock]
    @OptionallyDecodable var warningFromEditor: JSONNull?
    let counters: Counters
    @OptionallyDecodable var commentsSeenCount: JSONNull?
    let dateFavorite, hitsCount: Int
    let isCommentsEnabled, isLikesEnabled, isFavorited, isRepost: Bool
    let likes: Likes
    let isPinned, canEdit: Bool
    @OptionallyDecodable var repost: JSONNull?
    @OptionallyDecodable var repostID: JSONNull?
    @OptionallyDecodable var repostData: JSONNull?
    let isRepostedByMe: Bool
    let stackedRepostsAuthors: [JSONAny]
    let subscribedToTreads, isShowThanks, isStillUpdating, isFilledByEditors: Bool
    let isEditorial, isPromoted: Bool
    let recommendedType: String
    let isAudioAvailable: Bool
    let audioURL: String
    let commentEditor: CommentEditor
    @OptionallyDecodable var coAuthor: JSONNull?
    let isBlur, isPublished, isDisabledAd: Bool

    enum CodingKeys: String, CodingKey {
        case id, type, author
        case subsiteID = "subsiteId"
        case subsite, title, date, blocks, warningFromEditor, counters, commentsSeenCount, dateFavorite, hitsCount, isCommentsEnabled, isLikesEnabled, isFavorited, isRepost, likes, isPinned, canEdit, repost
        case repostID = "repostId"
        case repostData, isRepostedByMe, stackedRepostsAuthors, subscribedToTreads, isShowThanks, isStillUpdating, isFilledByEditors, isEditorial, isPromoted, recommendedType, isAudioAvailable
        case audioURL = "audioUrl"
        case commentEditor, coAuthor, isBlur, isPublished, isDisabledAd
    }
}

// MARK: - NewsBlock
struct NewsBlock: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: StickyData
    let cover, hidden: Bool
    let anchor: String
}

// MARK: - StickyData
struct StickyData: Codable {
    let text: String?
    @OptionallyDecodable var textTruncated: TextTruncated?
    let items: [ItemUnion]?
    @OptionallyDecodable var type: FluffyType?
    let osnovaEmbed: FluffyOsnovaEmbed?
    @OptionallyDecodable var style: Style?

    enum CodingKeys: String, CodingKey {
        case text
        case textTruncated = "text_truncated"
        case items, type, osnovaEmbed, style
    }
}

// MARK: - FluffyOsnovaEmbed
struct FluffyOsnovaEmbed: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: IndigoData
}

// MARK: - IndigoData
struct IndigoData: Codable {
    let originalID: Int
    let isNotAvailable: Bool
    let title, description: String
    let isEditorial: Bool
    let image: Avatar
    let url: String
    let blocks: [TentacledBlock]
    let date: Int
    let author, subsite: PurpleAuthor
    let likes, comments: Int
    let isBlur: Bool

    enum CodingKeys: String, CodingKey {
        case originalID = "original_id"
        case isNotAvailable, title, description, isEditorial, image, url, blocks, date, author, subsite, likes, comments, isBlur
    }
}

// MARK: - TentacledBlock
struct TentacledBlock: Codable {
    @OptionallyDecodable var type: AudioType?
    let data: IndecentData
    let cover, hidden: Bool
    let anchor: String
}

// MARK: - IndecentData
struct IndecentData: Codable {
    let text: String?
    @OptionallyDecodable var textTruncated: TextTruncated?
    let items: [ItemItem]?
    let video: Video?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case text
        case textTruncated = "text_truncated"
        case items, video, title
    }
}

enum TextTruncated: String, Codable {
    case same = "<<<same>>>"
}

enum ItemType: String, Codable {
    case entry = "entry"
    case news = "news"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
