//
//  BusinessTitle.swift
//  CitySights
//
//  Created by Bo-Kai Wang on 2021-12-27.
//

import SwiftUI

struct BusinessTitle: View {
    var business:Business
    var body: some View {
        VStack(alignment: .leading) {
            // Business Name
            Text(business.name!)
                .font(.largeTitle)
            // Loop through displayAddress
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { address in
                    Text(address)
                }
            }
            // Rating
            Image("regular_\(business.rating ?? 0)")
        }
    }
}

//struct BusinessTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessTitle()
//    }
//}
