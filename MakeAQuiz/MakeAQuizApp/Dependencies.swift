import Foundation
import QuizManager

/*
 So this is where we tie it all together and create the right QuizRepository
 and QuizManager for the various environments (currently there's only one)

 You can see how this is used in the MakeAQuizApp struct
 */
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
}
