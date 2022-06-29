//
//  ContentView.swift
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State var hero: Image?
    @State private var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var fork: UIImage?
    
    var body: some View {
        VStack {
            if let hero = hero {
                hero
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack {
 
                Button(action: {
                    self.showingImagePicker = true
                }, label: {
                    Text("Photo")
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                })
                /*Menu("Filters") {
                    Button("Fork", action: filterFork)
                    Button("Gaussian Blur", action: filterGaussianBlur)
                    Button("Sepia", action: filterSepia)
                    Button("Twirl", action: filterTwirl)
                }*/
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.blue, lineWidth: 2)
                )
            }
            HStack {
                Button(action: {
                    guard let photo = inputImage else { return }
                    let saver = PhotoLibrarySaver()
                    saver.writeToPhotosAlbum(image: photo)
                    
                }, label: {
                    Text("Save to Library")
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                })
                /*Button(action: {
                    guard let photo = inputImage else { return }
                    saveImageToFile(image: photo)
                }, label: {
                    Text("Save to Disk")
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                })*/
            }
            
        }
        .onAppear(perform: {
            fork = UIImage(named: "Fork_Logo")
        })
        .fullScreenCover(isPresented: $showingImagePicker, onDismiss: loadImage ) {
            ImagePicker(image: self.$inputImage)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        hero = Image(uiImage: inputImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
