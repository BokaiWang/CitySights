//
//  BusinessSection.swift
//  CitySights
//
//  Created by Bo-Kai Wang on 2021-12-21.
//

import SwiftUI

struct BusinessSection: View {
    var title: String
    var businesses: [Business]
    var body: some View {
        Section(content: {
            ForEach(businesses) { business in
                Text(business.name ?? "")
                Divider()
            }
        }, header: {
            BusinessSectionHeader(title: title)
        })
    }
}

//struct BusinessSection_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSection()
//    }
//}
