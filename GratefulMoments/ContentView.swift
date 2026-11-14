//
//  ContentView.swift
//  GratefulMoments
//
//  Created by Jagruti Parab on 10/11/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Moment.timestamp, order: .reverse)
    private var moments: [Moment]

    @State private var showingMomentEntry = false

    var body: some View {

        NavigationStack {

            List {

                ForEach(moments) { moment in

                    NavigationLink {
                        MomentDetailView(moment: moment)
                    } label: {

                        VStack(alignment: .leading, spacing: 5) {

                            Text(moment.title)
                                .font(.headline)

                            Text(
                                moment.timestamp,
                                format: .dateTime
                                    .day()
                                    .month()
                                    .year()
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteMoments)
            }
            .navigationTitle("Grateful Moments")
            .toolbar {

                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }

                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingMomentEntry = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingMomentEntry) {
                MomentEntryView()
            }
        }
    }

    private func deleteMoments(offsets: IndexSet) {

        withAnimation {
            for index in offsets {
                modelContext.delete(moments[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Moment.self, inMemory: true)
        .environment(DataContainer(includeSampleMoments: true))
}
