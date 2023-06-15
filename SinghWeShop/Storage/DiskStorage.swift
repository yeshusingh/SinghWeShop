//
//  DiskStorage.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/14/23.
//

import Foundation

@ImageStorage
class DiskStorage {
  private var folder: URL

  init() {
    guard let supportFolderURL = FileManager.default
      .urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
      fatalError("Couldn't open the application support folder")
    }
    let databaseFolderURL = supportFolderURL.appendingPathComponent("database", conformingTo: .image)

    do {
      try FileManager.default.createDirectory(at: databaseFolderURL, withIntermediateDirectories: true)
    } catch {
      fatalError("Couldn't creat the database folder in application support folder.")
    }

    folder = databaseFolderURL
  }

  func write(_ data: Data, name: String) throws {
    try data.write(to: folder.appendingPathComponent(name, conformingTo: .image), options: .atomic)
  }

  func read(name: String) throws -> Data {
    try Data(contentsOf: folder.appendingPathComponent(name, conformingTo: .image))
  }

  func remove(name: String) throws {
    try FileManager.default.removeItem(at: folder.appendingPathComponent(name, conformingTo: .image))
  }

  func persistedFiles() throws -> [URL] {
    var result: [URL] = []
    guard let directoryEnumerator = FileManager.default
      .enumerator(at: folder, includingPropertiesForKeys: []) else {
      throw "Couldn't enumerate on database folder."
    }
    for case let fileURL as URL in directoryEnumerator {
      result.append(fileURL)
    }

    return result
  }

  nonisolated static func fileName(for path: String) -> String {
    return path
      .components(separatedBy: .punctuationCharacters)
      .joined(separator: "_")
  }
}
