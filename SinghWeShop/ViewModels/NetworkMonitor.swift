//
//  NetworkMonitor.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/2/23.
//

import Foundation
import Network

// Week 9: Assignment 3
class NetworkMonitor: ObservableObject {
  private let networkMonitor = NWPathMonitor()
  private let workerQueue = DispatchQueue(label: "MonitorNetwork")
  var isConnected = false

  init() {
    networkMonitor.pathUpdateHandler = { path in
      self.isConnected = (path.status == .satisfied)
      Task {
        await MainActor.run {
          self.objectWillChange.send()
        }
      }
    }
    networkMonitor.start(queue: workerQueue)
  }
}
