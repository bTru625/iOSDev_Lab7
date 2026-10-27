import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class APIService {

    private let baseURL = "http://127.0.0.1:3000"

    // look into, should there be 2 decode fns, and no encode fns? Should one of them be changed?    
    
    /*    nvm, dont look into it, this is the redundant FN

    private func decode <t: Decodable> (
        type: T.Type, from data: Data
    ) throws -> T {


        do {

            return try JSONDecoder().decode(
                type, from: data
            )
        } catch {

            throw error
        }
    }
    */

    private func decode<T: Decodable>(
        _ type: T.Type, from data: Data
    ) throws -> T {

        do {

            return try JSONDecoder().decode(
                type, from: data
            )
        } catch {

            throw APIError.decodingError
        }
    }


    private func validateResponse (
        _ response: URLResponse
    ) throws {

        guard let httpResponse = response as? HTTPURLResponse else {

            throw APIError.invalidResponse
        }

        switch httpResponse.statusCode {

            case 200...299: return

            case 400: throw APIError.badRequest

            case 404: throw APIError.notFound

            case 500...599: throw APIError.serverError

            default: throw APIError.invalidResponse 
        }
    }

    //GET ALL
    func getStudents() async throws -> [Student] {
        
        guard let url = URL (
            string: "\(baseURL)/students"
            ) else {

                throw APIError.invalidURL
            }

            do {

                let (data, response) = try await URLSession.shared.data(from: url)

                try validateResponse(response)

                return try decode(
                    [Student].self,
                    from: data
                )

            } catch let error as APIError{

                throw error
            } catch {

                throw APIError.networkError
            }
    }

    //GET by id
    func getStudent (id: Int) async throws -> Student {

        guard let url = URL(
            string: "\(baseURL)/student/\(id)"
            ) else {

                throw APIError.invalidURL
            }

            do {

                let (data, response) = try await URLSession.shared.data(from: url)

                try validateResponse(response)

                return try decode(
                    Student.self,
                    from: data
                )
                
            } catch let error as APIError{

                throw error
            } catch {

                throw APIError.networkError
            }
    }


    //POST
    func addStudent (_ newStudent: NewStudent) async throws -> Student {
        
        guard let url = URL(

            string: "\(baseURL)/students"

        ) else {

            throw APIError.invalidURL

        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        do {
            request.httpBody = 
            try JSONEncoder().encode(
                newStudent
                )
        } catch {

            throw APIError.encodingError
        }

        do {
            let (data, response) = 
                try await URLSession.shared.data(
                    for: request
                )

            try validateResponse(response)

            return try decode(
                Student.self, from: data
            ) 
        } catch let error as APIError {
            
            throw error
        
        } catch {

            throw APIError.networkError
        
        }
    }

    //PUT
    func updateStudent (id: Int, student: NewStudent) async throws -> Student {
        guard let url = URL(
            string: "\(baseURL)/students/\(id)"
        ) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = "PUT"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        do {
            request.httpBody = try JSONEncoder().encode(
                student
            )
        } catch {

            throw APIError.encodingError
        
        }

        do {
            let (data, response) = 
                try await URLSession.shared.data(
                    for: request 
                )

            try validateResponse(response)
            
            return try decode(
                Student.self,
                from:data
            )
        } catch let error as APIError {

            throw error

        } catch  {
            
            throw APIError.networkError 

        }
    }

    //DELETE
    func deleteStudent (id: Int) async throws -> String {

        guard let url = URL(
            string:"\(baseURL)/students/\(id)"
        ) else {
            throw APIError.invalidURL 
        }

        var request = URLRequest(url : url)

        request.httpMethod = "DELETE"

        do {
            let (data, response) = 
                try await URLSession.shared.data (
                    for: request
                )

            try validateResponse(response)

            let result = try decode(
                MessageResponse.self,
                from: data
            )

            return result.message
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError
        }
    }

    func getStudentsByProgram(program: String) async throws -> [Student] {
        guard let url = URL(
            string: "\(baseURL)/students/program/\(program)",
        ) else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try validateResponse(response)
            
            return try decode(
                [Student].self,
                from: data
            )
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError
        }
    }

    func getAverageAge() async throws -> Double {
        guard let url = URL(
            string: "\(baseURL)/students/statistics/average-age",
        ) else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try validateResponse(response)

            let result = try decode(
                [String: Double].self,
                from: data
            )

            guard let averageAge = result["average_age"] else {
                throw APIError.decodingError
            }

            return averageAge
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError
        }
    }

    func getStudentsSortedByAge() async throws -> [Student] {
        guard let url = URL(
            string: "\(baseURL)/students/sort/age"
        ) else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try validateResponse(response)

            return try decode(
                [Student].self,
                from: data
            )
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError
        }
    }

    func validateStudent(
        name: String,
        program: String,
        age: Int
    ) -> Bool {
        if name
            .trimmingCharacters(in: .whitespaces)
            .isEmpty {
                print("Name cannot be empty")
                return false
            }

        if program
            .trimmingCharacters(in: .whitespaces)
            .isEmpty {
                print("Program cannot be empty")
                return false
            }

        if age < 16 || age > 100 {
            print("Age must be between 16 and 100")
            return false
        }

        return true
    }

    
}