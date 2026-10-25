import foundation

struct Student: Codable {

    let id : Int
    let name: String
    let program : String
    let age: Int
}

struct NewStudent : Codable {

    let name: String
    let program : String
    let age: Int
}

struct MessageResponse : Codable {

    let message : String
}

struct AverageAgeResponse : Codable {

    let averageAge : Double
}