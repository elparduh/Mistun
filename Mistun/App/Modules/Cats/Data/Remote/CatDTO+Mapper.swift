import Foundation

extension Array where Element == CatDTO {

  func asToDomain() -> [Cat] {
    self.compactMap { catDTO in
      Cat(id: catDTO.id ?? "", url: catDTO.url ?? "")
    }
  }
}
