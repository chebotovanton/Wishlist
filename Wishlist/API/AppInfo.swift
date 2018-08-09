import ObjectMapper

struct AppInfo: ImmutableMappable {
    let name: String
    let iconUrlString: String
    let description: String
//    let price: Int
//    let rating: Float


    init(map: Map) throws {
        name = try map.value("trackName")
        iconUrlString = try map.value("artworkUrl100")
        description = try map.value("description")
//        price = try map.value("")
//        rating = try map.value("")

    }
}
