import Foundation

protocol ApiClientProtocol {
  func request<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T
}

struct ApiClient: ApiClientProtocol {
  private let urlSession: URLSession

  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }

  func request<T>(endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable {
    try await makeRequest(endpoint: endpoint)
  }

  private func makeRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
    let request = try await urlSession.data(for: endpoint.urlRequest())
    return try validateResponse(request:request)
  }


  private func validateResponse<T: Decodable>(
      request: (data: Data, httpResponse: URLResponse)
  ) throws -> T {
      guard let httpResponse = request.httpResponse as? HTTPURLResponse
      else { throw ApiError.unknownError }

      switch httpResponse.statusCode {
      case HttpResponseStatus.ok:
          return try decodeModel(data: request.data)
      case HttpResponseStatus.clienteError:
          throw ApiError.clientError
      case HttpResponseStatus.serverError:
          throw ApiError.serverError
      default:
          throw ApiError.unknownError
      }
  }
  
  private func decodeModel<T: Decodable>(data: Data) throws -> T {
    let decoder = JSONDecoder()
    let model = try? decoder.decode(T.self, from: data)
    guard let model = model else { throw ApiError.decodingError }
    return model
  }
}
