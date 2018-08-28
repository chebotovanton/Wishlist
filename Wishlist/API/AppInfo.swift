import ObjectMapper

struct AppInfo: ImmutableMappable {
    let name: String
    let iconUrlString: String
    let description: String
    let rating: Float
    let price: Int
    let currency: String

    init(map: Map) throws {
        name = try map.value("trackName")
        iconUrlString = try map.value("artworkUrl100")
        description = try map.value("description")
        rating = try map.value("averageUserRating")
        price = try map.value("price")
        currency = try map.value("currency")
    }
}
