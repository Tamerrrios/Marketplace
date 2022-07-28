//
//  FilterContent.swift
//  TexnomartiOS
//
//  Created by yns on 06.04.2022.
//

import SwiftUI

struct FilterContent: View {
    @State var presentingActionSheet: Bool = false
    @State var showFilterView: Bool = false
    @State var sortType: SortType = .popular
    @Binding var columns: [GridItem]

    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.easeOut) {
                        presentingActionSheet.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.blackGray)
                        Text(sortType.title)
                            .robotoRegular(fontSize: 14, fontColor: .blackGray)
                    }
                    .animation(.easeOut)
                }
                Spacer()
                HStack(spacing: 40) {
                    Button {
                        showFilterView.toggle()
                    } label: {
                        HStack {
                            Image("filterImage")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.blackGray)
                            Text("Фильтры")
                                .robotoRegular(fontSize: 14, fontColor: .blackGray)
                        }
                    }
                    Button {
                        withAnimation(.easeOut) {
                            if columns.count == 2 {
                                columns.removeLast()
                            } else {
                                columns.append(GridItem(.flexible(), spacing: 15))
                            }
                        }
                    } label: {
                        Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
                            .resizable()
                            .frame(width: 20, height: 18)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.blackGray)
                    }
                    .animation(.easeOut)
                }
            }
            Divider()
                .padding(.top, 6)
                .padding(.bottom, 0)
        }
        .actionSheet(isPresented: $presentingActionSheet, content: {
            ActionSheet(title: Text("Сортировка"), buttons: [
                .default(Text("По популярности"), action: {
                    sortType = .popular
                }),
                .default(Text("По цене"), action: {
                    sortType = .price
                }),
                .cancel(Text("Отмена")),
            ])
        })
        .fullScreenCover(isPresented: $showFilterView, content: {
            FilterView()
        })
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
}

struct FilterContent_Previews: PreviewProvider {
    static var previews: some View {
        FilterContent(columns: .constant([GridItem(), GridItem()]))
    }
}
