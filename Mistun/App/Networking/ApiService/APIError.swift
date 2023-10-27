import Foundation

enum APIError: Error {
    case clientError
    case serverError
    case unknownError
    case decodingError
}

extension APIError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("Client error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .decodingError:
            return NSLocalizedString("Error decoding", comment: "")
        }
    }
}
