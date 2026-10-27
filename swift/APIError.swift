enum APIError: Error, CustomStringConvertible {

    case invalidURL    
    case invalidResponse    
    case badRequest    
    case notFound    
    case serverError    
    case decodingError    
    case encodingError    
    case networkError

    var description: String {

        switch self {

            case .invalidURL: return "Invalid URL"

            case .invalidResponse: return "Invalid server response"

            case .badRequest: return "Invalid data sent to server"

            case .notFound: return "Resource not found"

            case .serverError: return "Server error"

            case .decodingError: return "Failed to decode data"

            case .encodingError: return "Failed to encode data"

            case .networkError: return "Network communication failed"

        } 
    }
}    