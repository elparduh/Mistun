import Foundation

protocol APIClientProtocol {
  func request<T: Codable>(endpoint: Endpoint, type: T.Type) async throws -> T
}

struct APIClient: APIClientProtocol {
  private let urlSession: URLSession

  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }

  func request<T>(endpoint: Endpoint, type: T.Type) async throws -> T where T : Codable {
    try await makeRequest(endpoint: endpoint)
  }

  private func makeRequest<T: Codable>(endpoint: Endpoint) async throws -> T {
    let request = try await urlSession.data(for: endpoint.urlRequest())
    return try validateResponse(request:request)
  }


  private func validateResponse<T: Codable>(
      request: (data: Data, httpResponse: URLResponse)
  ) throws -> T {
      guard let httpResponse = request.httpResponse as? HTTPURLResponse
      else { throw APIError.unknownError }

      switch httpResponse.statusCode {
      case HttpResponseStatus.ok:
          return try decodeModel(data: request.data)
      case HttpResponseStatus.clienteError:
          throw APIError.clientError
      case HttpResponseStatus.serverError:
          throw APIError.serverError
      default:
          throw APIError.unknownError
      }
  }
  
  private func decodeModel<T: Codable>(data: Data) throws -> T {
    let decoder = JSONDecoder()
    let model = try? decoder.decode(T.self, from: data)
    guard let model = model else { throw APIError.decodingError }
    return model
  }
}
