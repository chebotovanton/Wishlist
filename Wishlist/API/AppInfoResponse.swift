import ObjectMapper

struct AppInfoResponse: ImmutableMappable {
    let info: [AppInfo]

    init(map: Map) throws {
        info = try map.value("results")
    }
}
