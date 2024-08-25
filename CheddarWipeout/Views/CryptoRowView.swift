//
//  CryptoRowView.swift#imageLiteral(resourceName: "CryptoScreen.png")
//  CheddarWipeout
//
//  Created by Timea Bartha on 23/8/24.
//

import SwiftUI

struct CryptoRowView: View {
    @ObservedObject var viewModel: CryptoCoinViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    if let imageUrl = viewModel.imageUrl, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle()) // Optional: Make the image circular
                            } else if phase.error != nil {
                                // placeholder or error image
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.red)
                            } else {
                                // placeholder while loading
                                ProgressView()
                                    .frame(width: 40, height: 40)
                            }
                        }
                    } else {
                        // placeholder image if the URL is nil
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                    }
                    Text(viewModel.name)
                        .font(.headline)
                    
                    Spacer()
                    Text("$\(viewModel.currentPrice, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(viewModel.priceChangeColor)
                        .padding(5)
                        .background(viewModel.priceChangeBackgroundColor)
                        .cornerRadius(7)
                        .animation(.easeInOut(duration: 0.7), value: viewModel.priceChangeBackgroundColor)
                }
                HStack {
                    Text("Min: $\(viewModel.minPrice, specifier: "%.2f")")
                        .font(.subheadline)
                    Text("Max: $\(viewModel.maxPrice, specifier: "%.2f")")
                        .font(.subheadline)
                }
            }
        }
    }
}

