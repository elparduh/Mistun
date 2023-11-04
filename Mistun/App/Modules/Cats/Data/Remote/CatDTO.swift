import Foundation

struct CatDTO: Codable {

  let id: String?
  let url: String?
  let width: Int?
  let height: Int?

  enum CodingKeys: String, CodingKey {

    case id = "id"
    case url = "url"
    case width = "width"
    case height = "height"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(String.self, forKey: .id)
    url = try values.decodeIfPresent(String.self, forKey: .url)
    width = try values.decodeIfPresent(Int.self, forKey: .width)
    height = try values.decodeIfPresent(Int.self, forKey: .height)
  }
}
