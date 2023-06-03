//
//  NetworkStatusView.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 6/2/23.
//

import SwiftUI

struct NetworkStatusView: View {
  var body: some View {
    VStack {
      Image(systemName: "antenna.radiowaves.left.and.right.slash")
        .font(.largeTitle)
        .fontWeight(.bold)
        .imageScale(.large)
        .foregroundColor(.green)
        .padding(30)
        .background(.gray.opacity(0.3))
        .clipShape(Circle())
        .padding()

      Text("Network connection seems offline.\nPlease check your connection.")
        .font(.title3)
        .fontWeight(.regular)
        .kerning(0.5)
        .multilineTextAlignment(.center)
    }
    .padding()
  }
}

#if DEBUG
struct NetworkStatusView_Previews: PreviewProvider {
  static var previews: some View {
    NetworkStatusView()
  }
}
#endif
