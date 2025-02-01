import Foundation
import QuizManager

enum Dependencies {
  enum Live {
    public static var quizRepository: NetworkQuizRepository {
      guard
        let baseURL = URL(string: "https://opentdb.com")
      else {
        fatalError(
          "https://opentdb.com is not a valid URL, now I've seen it all"
        )
      }
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      
      return NetworkQuizRepository(
        baseURL: baseURL,
        decoder: decoder
      )
    }
    
    public static var quizManager: LiveQuizManager {
      return LiveQuizManager(repository: Dependencies.Live.quizRepository)
    }
  }
  
//  enum Mock {
//    public static var quizRepository: MockPokemonRepository {
//      return MockPokemonRepository()
//    }
//    
//    public static var pokemonManager: MockPokemonManager {
//      return MockPokemonManager()
//    }
//  }
}
