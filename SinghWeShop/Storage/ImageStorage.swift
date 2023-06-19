//
//  ImageStorage.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/14/23.
//

import UIKit

@globalActor actor ImageStorage {
  enum DownloadState {
    case inProgress(Task<UIImage, Error>)
    case completed(UIImage)
    case failed
  }

  static let shared = ImageStorage()

  private(set) var cache: [String: DownloadState] = [:]

  // swiftlint:disable:next implicitly_unwrapped_optional
  private var storage: DiskStorage!
  // DiskStorage is annotated to run on ImageStorage serial executor to avoid concurrency issues.
  // Hence a instance of Diskstorage cannot be created until an ImageStorage instance has been created.
  // Thus creation of DiskStorage has been delayed till a setup function for ImageStorage is called.

  private var storedImagesIndex = Set<String>()

  func setup() async throws {
    storage = await DiskStorage()
    for fileURL in try await storage.persistedFiles() {
      storedImagesIndex.insert(fileURL.lastPathComponent)
    }
  }

  func addToCache(_ image: UIImage, forKey key: String) {
    cache[key] = .completed(image)
  }

  func clearCache() {
    cache.removeAll()
  }

  func store(image: UIImage, forKey key: String) async throws {
    guard let data = image.pngData() else {
      throw "Could not save image \(key)"
    }
    let fileName = DiskStorage.fileName(for: key)
    try await storage.write(data, name: fileName)
    storedImagesIndex.insert(fileName)
  }

  func clear() async {
    for name in storedImagesIndex {
      try? await storage.remove(name: name)
    }
    storedImagesIndex.removeAll()
  }

  func image(_ urlString: String) async throws -> UIImage {
    guard let url = URL(string: urlString) else {
      throw "Could not create download URL"
    }

    let key = url.lastPathComponent

    if let cached = cache[key] {
      switch cached {
      case .completed(let image):
        print("Cached in Memory")
        return image
      case .inProgress(let task):
        print("in progress task")
        return try await task.value
      case .failed:
        throw "Download failed"
      }
    }

    do {
      let filename = DiskStorage.fileName(for: key)
      if !storedImagesIndex.contains(filename) {
        throw "File not persisted"
      }

      let data = try await storage.read(name: filename)
      guard let image = UIImage(data: data) else {
        throw "Invalid image data"
      }
      print("Cached in disk")

      addToCache(image, forKey: key)
      return image
    } catch {
      let image = try await downloadImage(urlString, key)
      try await store(image: image, forKey: key)
      return image
    }
  }

  func downloadImage(_ urlString: String, _ key: String) async throws -> UIImage {
    let download: Task<UIImage, Error> = Task.detached {
      guard let url = URL(string: urlString) else {
        throw "Could not create download URL"
      }
      print("Download: \(url.absoluteString)")
      let data = try await URLSession.shared.data(from: url).0
      guard let image = UIImage(data: data) else {
        throw "Invalid image data"
      }
      return image
    }

    cache[key] = .inProgress(download)

    do {
      let result = try await download.value
      addToCache(result, forKey: key)
      return result
    } catch {
      cache[key] = .failed
      throw error
    }
  }
}
