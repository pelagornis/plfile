import XCTest
@testable import PLFile

final class PLFileTests: XCTestCase {
    private var folder: PLFile.Folder!
    
    override func setUp() {
        super.setUp()
        folder = try! PLFile.Folder(path: .home).createSubfolder(at: Path(".plfileTest"))
        try! folder.empty()
    }
    
    override func tearDown() {
        try? folder.delete()
        super.tearDown()
    }
    
    func testingCreateFileAndDeleteFile() {
        let file = try! folder.createFile(at: Path("test.swift"))
        print("Test: ⚠️ \(file.store.path)")
        XCTAssertEqual(file.name, "test.swift")
        XCTAssertEqual(file.store.path.rawValue, folder.store.path.rawValue + "test.swift")
    }
}

