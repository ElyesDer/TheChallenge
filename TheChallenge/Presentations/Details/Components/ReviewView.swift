//
//  ReviewView.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 23/05/2022.
//

import SwiftUI

struct ReviewView: View {
    
    var reviews: [Review]
    
    
    private var fullStar: some View {
        Image(systemName: "star.fill").foregroundColor(.yellow)
    }
    
    private var halfFullStar: some View {
        Image(systemName: "star.lefthalf.fill").foregroundColor(.yellow)
    }
    
    private var emptyStar: some View {
        Image(systemName: "star").foregroundColor(.gray)
    }
    
    init(reviews: [Review]) {
        self.reviews = reviews
    }
    
    func buildStarsView(rating: Double) -> AnyView {
        
        let fullCount = Int(rating)
        let emptyCount = Int(6 - rating)
        let halfFullCount = (Float(fullCount + emptyCount) < 6) ? 1 : 0
        
        return AnyView(
            HStack {
                ForEach(0..<fullCount) { _ in
                    self.fullStar
                }
                ForEach(0..<halfFullCount) { _ in
                    self.halfFullStar
                }
                ForEach(0..<emptyCount) { _ in
                    self.emptyStar
                }
            }
                .padding(.bottom, 5)
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Review Section")
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(reviews, id: \.id) { item in
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text(item.name)
                                Spacer()
                            }
                            
                            //                            buildStarsView(rating: item.stars.value)
                            
                            Text(item.review ?? "No review")
                                .minimumScaleFactor(0.5)
                                .lineLimit(5)
                            
                            Spacer()
                        }
                        .frame(width: 250, height: 150, alignment: .center)
                        .padding(10)
                        .background(Color.gray)
                        .cornerRadius(15)
                        
                    }
                }
                .padding(.leading)
            }
        }
        .background(Color.red)
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(reviews: [.init(name: "Some cool name", stars: .init(type: "", value: 9.0), review: "Ceci est un long review Ceci est un long review Ceci est un long review Ceci long review Ceci  long review Ceci  long review Ceci  est un long review"),
                             .init(name: "Some cool name", stars: .init(type: "", value: 9.0), review: "Ceci est un long review Ceci est un long review Ceci est un long review Ceci long review Ceci  long review Ceci  long review Ceci  est un long review"),
                             .init(name: "Some cool name", stars: .init(type: "", value: 3.0), review: "Ceci est un long review Ceci est un long review Ceci est un long review Ceci long review Ceci  long review Ceci  long review Ceci  est un long review")])
    }
}
