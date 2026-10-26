import Foundation
import FoundationNetworking 

class APIService {

    private let baseURL = "http://127.0.0.1:3000"

    // look into, should there be 2 decode fns, and no encode fns? Should one of them be changed?    
    
    /*    nvm, dont look into it, this is the redundant FN

    private func decode <t: Decodable> (
        type: T.type, from data: Data
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
        _ type: T.type, from data: Data
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


    func getStudent (id: Int) async throws -> Student {

        guard let url = URL(
            string: "\(baseURL)/student/\(id)"
            ) else {

                throw APIError.InvalidURL
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



}