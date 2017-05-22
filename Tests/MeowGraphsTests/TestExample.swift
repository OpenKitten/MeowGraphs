import Foundation
import XCTest
import Meow
import MeowGraphs

class CRUDTests : XCTestCase {
    override func setUp() {
        try! Meow.init("mongodb://localhost/meowtests")
        try! Meow.database.drop()
    }
    
    func setupGraph() throws {
        let a = User(username: "A", firstName: "Bob", lastName: "Janssen")
        let b = User(username: "B", firstName: "Klaas", lastName: "Janssen")
        let c = User(username: "C", firstName: "Piet", lastName: "Janssen")
        let d = User(username: "D", firstName: "Henk", lastName: "Janssen")
        let e = User(username: "E", firstName: "Geert", lastName: "Janssen")
        let f = User(username: "F", firstName: "Karel", lastName: "Boom")
        let g = User(username: "G", firstName: "Peter", lastName: "Janssen")
        
        a.friends.append(b._id)
        a.friends.append(c._id)
        
        b.friends.append(d._id)
        c.friends.append(e._id)
        
        c.friends.append(e._id)
        c.friends.append(f._id)
        
        e.friends.append(g._id)
        
        try a.save()
        try b.save()
        try c.save()
        try d.save()
        try e.save()
        try f.save()
        try g.save()
    }

    func testGraphQuery() throws {
        try setupGraph()
        
        let relevantUsers = try User.findRelations(forEntitiesMatching: "username" == "A", whereForeignKey: ._id, existsAt: .friends, until: 2, restrictions: "name.last" == "Janssen")
        
        let users = Array(relevantUsers)
        
        XCTAssertEqual(users.count, 1)
        
        guard let user = users.first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(user.entity.username, "A")
        
        XCTAssertEqual(user.relations.count, 5)
        
        XCTAssertEqual(user.orderRelationsClosest().last?.username, "G")
        
        XCTAssertEqual(user.orderRelationsFurthest().first?.username, "G")
        
        for relation in user.orderRelationsClosest() {
            XCTAssertNotEqual(relation.username, "F")
        }
    }
}
