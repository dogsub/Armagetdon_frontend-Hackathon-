import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    private let baseURL = "http://13.125.239.111:8080"

    private init() {}

    func getMyPage(memberId: String, completion: @escaping (Result<MyPageResponse, Error>) -> Void) {
        let url = "\(baseURL)/member/mypage/\(memberId)"
        AF.request(url).validate().responseDecodable(of: MyPageResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct MyPageResponse: Decodable {
    let isSuccess: Bool
    let code: String // Changed from Int to String
    let message: String
    let result: MyPageResult?
}

struct MyPageResult: Decodable {
    let nickname: String
    let reward: Int
    let level: String
    let leftAltitude: Int
}
