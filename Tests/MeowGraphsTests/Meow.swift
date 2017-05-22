// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: Meow.ejs
// MARK: MeowCore.ejs


// MARK: - General Information
// Supported Primitives: ObjectId, String, Int, Int32, Bool, Document, Double, Data, Binary, Date, RegularExpression
// Sourcery Types: class CRUDTests, class User, enum User.Login
import Foundation
import Meow
import ExtendedJSON


// MARK: Protocols.ejs




// MARK: - 🐈 for User
// MARK: Serializable.ejs
// MARK: SerializableStructClass.ejs

extension User : SerializableToDocument {

	

	internal func serialize() -> Document {
		var document: Document = [:]
		document.pack(self._id, as: "_id")
		document.pack(self.name, as: Key.name.keyString)
		document.pack(self.username, as: Key.username.keyString)
		document.pack(self.login, as: Key.login.keyString)
		document.pack(self.friends, as: Key.friends.keyString)
		return document
	}

	internal static func validateUpdate(with document: Document) throws {
		let keys = document.keys
		if keys.contains(Key.name.keyString) {
			_ = (try document.unpack(Key.name.keyString)) as (first: String, last: String)
		}
		if keys.contains(Key.username.keyString) {
			_ = (try document.unpack(Key.username.keyString)) as String
		}
		if keys.contains(Key.login.keyString) {
			_ = (try document.unpack(Key.login.keyString)) as User.Login
		}
		if keys.contains(Key.friends.keyString) {
			_ = (try document.unpack(Key.friends.keyString)) as Array<ObjectId>
		}
	}

	internal func update(with document: Document) throws {
		try User.validateUpdate(with: document)

		for key in document.keys {
			switch key {
			case Key.name.keyString:
				self.name = try document.unpack(Key.name.keyString)
			case Key.username.keyString:
				self.username = try document.unpack(Key.username.keyString)
			case Key.login.keyString:
				self.login = try document.unpack(Key.login.keyString)
			case Key.friends.keyString:
				self.friends = try document.unpack(Key.friends.keyString)
			default: break
			}
		}
	}

	
	
	internal static let collection: MongoKitten.Collection = Meow.database["users"]
	

	// MARK: ModelResolvingFunctions.ejs

	
	internal static func byId(_ value: ObjectId) throws -> User? {
		return try User.findOne("_id" == value)
	}
	



	internal static func byUsername(_ value: String) throws -> User? {
		return try User.findOne(Key.username.rawValue == value)
	}


	

	// MARK: KeyEnum.ejs

	internal enum Key : String, ModelKey {
		case _id
		case name = "name"
		case username = "username"
		case login = "login"
		case friends = "friends"


		internal var keyString: String { return self.rawValue }

		internal var type: Any.Type {
			switch self {
			case ._id: return ObjectId.self
			case .name: return (first: String, last: String).self
			case .username: return String.self
			case .login: return User.Login.self
			case .friends: return Array<ObjectId>.self
			}
		}

		internal static var all: Set<Key> {
			return [._id, .name, .username, .login, .friends]
		}
	}

	// MARK: Values.ejs
	

	/// Represents (part of) the values of a User
	internal struct Values : ModelValues {
		internal init() {}
		internal init(restoring source: BSON.Primitive, key: String) throws {
			guard let document = source as? BSON.Document else {
				throw Meow.Error.cannotDeserialize(type: User.Values.self, source: source, expectedPrimitive: BSON.Document.self);
			}
			try self.update(with: document)
		}

		internal var name: (first: String, last: String)?
		internal var username: String?
		internal var login: User.Login?
		internal var friends: Array<ObjectId>?


		internal func serialize() -> Document {
			var document: Document = [:]			
			document.pack(self.name, as: Key.name.keyString)
			document.pack(self.username, as: Key.username.keyString)
			document.pack(self.login, as: Key.login.keyString)
			document.pack(self.friends, as: Key.friends.keyString)
			return document
		}

		internal mutating func update(with document: Document) throws {
			for key in document.keys {
				switch key {
				case Key.name.keyString:
					self.name = try document.unpack(Key.name.keyString)
				case Key.username.keyString:
					self.username = try document.unpack(Key.username.keyString)
				case Key.login.keyString:
					self.login = try document.unpack(Key.login.keyString)
				case Key.friends.keyString:
					self.friends = try document.unpack(Key.friends.keyString)
				default: break
				}
			}
		}
	}

	// MARK: VirtualInstanceStructClass.ejs


internal struct VirtualInstance : VirtualModelInstance {
	/// Compares this model's VirtualInstance type with an actual model and generates a Query
	internal static func ==(lhs: VirtualInstance, rhs: User?) -> Query {
		
		return (lhs.referencedKeyPrefix + "_id") == rhs?._id
		
	}

	internal let keyPrefix: String

	internal let isReference: Bool

	
	internal var _id: VirtualObjectId {
		return VirtualObjectId(name: referencedKeyPrefix + Key._id.keyString)
	}
	

	
		 /// name: (first: String, last: String)
		 
		 /// username: String
		 internal var username: VirtualString { return VirtualString(name: referencedKeyPrefix + Key.username.keyString) } 
		 /// login: Login?
		 internal var login: User.Login.VirtualInstance { return .init(keyPrefix: referencedKeyPrefix + Key.login.keyString) } 
		 /// friends: [ObjectId]
		 

	internal init(keyPrefix: String = "", isReference: Bool = false) {
		self.keyPrefix = keyPrefix
		self.isReference = isReference
	}
} // end VirtualInstance

}

// CustomStringConvertible.ejs


extension User : CustomStringConvertible {
	internal var description: String {
	
		return "User<\(ObjectIdentifier(self).hashValue),\((self.serialize() as Document).makeExtendedJSON(typeSafe: false).serializedString())>"
	
	}
}





// MARK: - 🐈 for User.Login
// MARK: Serializable.ejs
// MARK: SerializableEnum.ejs
extension User.Login : Serializable {
	internal init(restoring source: BSON.Primitive, key: String) throws {
		guard let rawValue = String(source) ?? String(Document(source)?[0]) else {
			throw Meow.Error.cannotDeserialize(type: User.Login.self, source: source, expectedPrimitive: String.self)
		}

		switch rawValue {
			case "password":
						guard let document = Document(source) else {
				throw Meow.Error.cannotDeserialize(type: User.Login.self, source: source, expectedPrimitive: String.self)
			}
				let value0: String = try document.unpack("1")


				self = .password(value0)
		default: throw Meow.Error.enumCaseNotFound(enum: "User.Login", name: rawValue)
		}
	}

	internal func serialize() -> BSON.Primitive {
		switch self {
		case .password(let value0):
			var document: Document = []

			document.append("password")
			document.pack(value0, as: "1")

			return document
		}
	}

	// MARK: VirtualInstanceEnum.ejs
internal struct VirtualInstance {
	/// Compares this enum's VirtualInstance type with an actual enum case and generates a Query
	internal static func ==(lhs: VirtualInstance, rhs: User.Login?) -> Query {
		return lhs.keyPrefix == rhs?.serialize()
	}

	internal var keyPrefix: String

	internal init(keyPrefix: String = "") {
		self.keyPrefix = keyPrefix
	}
}

}




// MARK: Tuple.ejs
extension Document {
	internal mutating func pack(_ tuple: (first: String, last: String)?, as key: String) {
		guard let tuple = tuple else {
			self[key] = nil
			return
		}
		
		var document: Document = [:]		
		document.pack(tuple.first, as: "first")		
		document.pack(tuple.last, as: "last")		
		self[key] = document
	}

	internal func unpack(_ key: String) throws -> (first: String, last: String) {
		guard let document = Document(self[key]) else {
			throw Meow.Error.cannotDeserialize(type: Document.self, source: self[key], expectedPrimitive: Document.self)
		}

		return try (			
				 				 				 first:  				document.unpack("first") 				, 			
				 				 				 last:  				document.unpack("last") 				 			
		)
	}
}

		

fileprivate let meows: [Any.Type] = [User.self, User.Login.self]

extension Meow {
	static func `init`(_ connectionString: String) throws {
		try Meow.init(connectionString, meows)
	}
	
	static func `init`(_ db: MongoKitten.Database) {
		Meow.init(db, meows)
	}
}

// 🐈 Statistics
// Models: 1
//   User
// Serializables: 2
//   User, User.Login
// Model protocols: 0
//   
// Tuples: 1
