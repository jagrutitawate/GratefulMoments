//
//  MomentsView.swift
//  GratefulMoments
//
//  Created by Jagruti Parab on 10/11/26.
//

import SwiftUI
import SwiftData


struct MomentsView: View {
    @State private var showCreateMoment = false
    @Query(sort: \Moment.timestamp)
    private var moments: [Moment]
    static let offsetAmount: CGFloat = 70.0

    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    pathItems
                        .frame(maxWidth: .infinity)
                }
                .overlay {
                    if moments.isEmpty {
                        ContentUnavailableView {
                            Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
                        } description: {
                            Text("Post a note or photo to start filling this space with gratitude.")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showCreateMoment = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showCreateMoment) {
                            MomentEntryView()
                        }
                    }
                }
            }
        }
        .navigationTitle("Grateful Moments")
    }
        
        private var pathItems: some View {
            ForEach(Array(moments.enumerated()), id: \.offset) { index, moment in

                NavigationLink {
                               MomentDetailView(moment: moment)
                } label: {
                    if moment == moments.last {
                        MomentHexagonView(moment: moment, layout: .large)
                    } else {
                        MomentHexagonView(moment: moment)
                        .offset(x: sin(Double(index) * .pi / 2) * Self.offsetAmount)

                    }
                }
                .scrollTransition { content, phase in
                    content
                        .opacity(phase.isIdentity ? 1 : 0)
                        .scaleEffect(phase.isIdentity ? 1 : 0.8)
                }
        }
    }
}

#Preview {
    MomentsView().sampleDataContainer()
}
