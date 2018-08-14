import XCTest
@testable import Wishlist

class AppIdExtractorTests: XCTestCase {

    func testValidUrl() {
        let urlString = "itunes.apple.com/ru/app/10-happier-meditation/id992210239?l=en&mt=8"
        let appId = AppIdExtractor.appIdFrom(urlString: urlString)

        XCTAssertTrue(appId == "992210239")
    }
}
