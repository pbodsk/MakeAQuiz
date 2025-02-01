import Foundation

public struct NetworkQuizRepository {
  private let urlSession: URLSession
  private let baseURL: URL
  private let decoder: JSONDecoder
  
  public init(
    urlSession: URLSession = URLSession.shared,
    baseURL: URL,
    decoder: JSONDecoder = JSONDecoder()
  ) {
    self.urlSession = urlSession
    self.baseURL = baseURL
    self.decoder = decoder
  }
}

extension NetworkQuizRepository: QuizRepository {
  public func fetchQuizCategories() async throws -> QuizCategoryResponse {
    let url = baseURL.appendingPathComponent("api_category.php")
    return try await getData(url: url)
  }
  
  private func getData<T: Decodable>(url: URL) async throws -> T {
    let (data, response) = try await urlSession.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw QuizRepositoryError.invalidResponse
    }
    
    guard httpResponse.statusCode == 200 else {
      throw QuizRepositoryError.invalidStatusCode(httpResponse.statusCode)
    }
    
    return try decoder.decode(T.self, from: data)
  }
}
