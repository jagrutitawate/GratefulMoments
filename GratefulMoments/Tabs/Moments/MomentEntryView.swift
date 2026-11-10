//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by Jagruti Tawate on 10/11/26.
//

import SwiftUI
import PhotosUI
import UIKit
import SwiftData


struct MomentEntryView: View {
    @State private var title = ""
    @State private var note = ""
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    @State private var isShowingCancelConfirmation = false

    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
       
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful For")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        if title.isEmpty, note.isEmpty, imageData == nil {
                                                   dismiss()
                                               } else {
                                                   isShowingCancelConfirmation = true
                                               }
                    }
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancelConfirmation) {
                        Button("Discard Moment", role: .destructive) {
                            
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        let newMoment = Moment(
                            title: title,
                            note: note,
                            imageData: imageData,
                            timestamp: .now
                        )
                        dataContainer.context.insert(newMoment)
                                                do {
                                                    try dataContainer.context.save()
                                                    dismiss()
                                                } catch {
                                                    // Don't dismiss
                                                }
                          
                    }  .disabled(title.isEmpty)
                }
            }
        }
    }
   

    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let img = UIImage(data: imageData) {
                                   Image(uiImage: img)
                                       .resizable()
                                       .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color(white: 0.4, opacity: 0.32))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        
        .onChange(of: newImage) {
            guard let newImage else { return }
            Task {
                
                do {
                    imageData = try await newImage.loadTransferable(type: Data.self)
                } catch {
                    print("Image loading failed: \(error)")
                }
            }
        }
    }
    
    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())
            .padding(.top, 48)
            Divider()
            TextField("Log your small wins", text: $note, axis: .vertical)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5...Int.max)
            
            photoPicker
        }
        .padding()
    }
}

#Preview {
    MomentEntryView()
           .environment(DataContainer(includeSampleMoments: true))
}
