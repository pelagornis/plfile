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
    
    func testingCreateFile() {
        let file = try! folder.createFile(at: Path("test.swift"))
        XCTAssertEqual(file.name, "test.swift")
        XCTAssertEqual(file.store.path.rawValue, folder.store.path.rawValue + "test.swift")
        XCTAssertEqual(file.extension, "swift")
        
        try XCTAssertEqual(file.read(), Data())
    }
    
    func testingFileWrite() {
        let file = try! folder.createFile(at: Path("testWrite.swift"))
        try! file.write("print(1)")
        
        try XCTAssertEqual(String(data: file.read(), encoding: .utf8), "print(1)")
    }
    
    func testingFileMove() {
        let originFolder = try! folder.createSubfolder(at: Path("folderA"))
        let targetFolder = try! folder.createSubfolder(at: Path("folderB"))
        try! originFolder.move(to: targetFolder)
        XCTAssertEqual(originFolder.store.path.rawValue, folder.store.path.rawValue + "folderB/folderA/" )
    }
}
