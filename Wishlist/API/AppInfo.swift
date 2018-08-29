import ObjectMapper

struct AppInfo: ImmutableMappable {
    let name: String
    let iconUrlString: String
    let description: String
    let rating: Float
    let formattedPrice: String
    var appId: String?

    init(map: Map) throws {
        name = try map.value("trackName")
        iconUrlString = try map.value("artworkUrl100")
        description = try map.value("description")
        rating = try map.value("averageUserRating")
        formattedPrice = try map.value("formattedPrice")
    }
}
