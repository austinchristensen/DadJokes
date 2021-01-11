//
//  AddView.swift
//  DadJokes
//
//  Created by Austin Christensen on 1/8/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var setup = ""
    @State var punchline = ""
    @State var rating = "Silence"
    let ratings = ["Sob", "Sigh", "Silence", "Smirk"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Setup", text: $setup)
                    TextField("Punchline", text: $punchline)
                    
                    Picker("Rating", selection: $rating) {
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating)
                        }
                    }
                }
                
                Button("Add Joke") {
                    let newJoke = Joke(context: self.moc)
                    newJoke.setup = self.setup
                    newJoke.punchline = self.punchline
                    newJoke.rating = self.rating
                    
                    do {
                        try self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Got an error! \(error.localizedDescription)")
                    }
                }
            }.navigationBarTitle("New Joke")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
