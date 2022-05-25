//
//  ReviewView.swift
//  TheChallenge
//
//  Created by Derouiche Elyes on 23/05/2022.
//

import SwiftUI

struct ReviewView: View {
    
    var reviews: [Review]
    
    @State fileprivate var presendDetails: Bool = false
    @State fileprivate var selectedItemIndex: Int = 0 {
        didSet {
            presendDetails.toggle()
        }
    }
    
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
        let emptyCount = Int(5 - rating)
        let halfFullCount = (Float(fullCount + emptyCount) < 5) ? 1 : 0
        
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
                    ForEach(Array(zip(reviews.indices, reviews)), id: \.0) { index, item in

                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text(item.name)
                                    .bold()
                                Spacer()
                            }
                            
                            buildStarsView(rating: item.stars.value)
                            
                            Text(item.review ?? "No comment")
                                .minimumScaleFactor(0.7)
                                .lineLimit(5)
                            
                            Spacer()
                        }
                        .frame(width: 200, height: 100, alignment: .center)
                        .padding(15)
                        .background( Color("bgGray") )
                        .cornerRadius(15)
                        .onTapGesture {
                            selectedItemIndex = index
                        }
                    }
                }
                .padding(.leading)
            }
        }
        .sheet(isPresented: $presendDetails, content: {
            let item = reviews[selectedItemIndex]
            VStack(alignment: .leading) {
                
                HStack {
                    Text(item.name)
                        .bold()
                    Spacer()
                }
                
                buildStarsView(rating: item.stars.value)
                
                Text(item.review ?? "No comment")
                    .lineLimit(nil)
                
                Spacer()
            }.edgesIgnoringSafeArea(.all)
            .padding()
            .background( Color("bgGray") )
        })
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(reviews: [.init(name: "Some cool name", stars: .init(type: "", value: 9.0), review: "Ceci est un long review Ceci est un long review Ceci est un long review Ceci long review Ceci  long review Ceci  long review Ceci  est un long review"),
                             .init(name: "Some cool name", stars: .init(type: "", value: 9.0), review: "Ceci est un long review Ceci est un long review Ceci est un long review Ceci long review Ceci  long review Ceci  long review Ceci  est un long review"),
                             .init(name: "Some cool name", stars: .init(type: "", value: 3.0), review: "Ceci est un long review Ceci est un long review Ceci est un long review Ceci long review Ceci  long review Ceci  long review Ceci  est un long review")])
    }
}
