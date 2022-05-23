//
//  CastView.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 22/05/2022.
//

import SwiftUI

struct CastView: View {
    
    var personnalities: [Personnality]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(personnalities) { personnality in
                if !personnality.personnalitiesList.isEmpty {
                    Text(personnality.personnalityPrefix)
                        .bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(personnality.personnalitiesList, id: \.self) { personnalityItem in
                                VStack(alignment: .center) {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .frame(width: 35, height: 35, alignment: .center)
                                    Text(personnalityItem)
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 300)
    }
}

struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(personnalities: [.init(personnalityPrefix: "", personnalitiesList: [""])])
    }
}
