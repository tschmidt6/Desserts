//
//  Instructions.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/25/23.
//

import SwiftUI

struct Instructions: View {
    var instructions: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                clipboard
                Spacer()
                VStack {
                    Text("Instructions")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.bottom, 6)
                        .textCase(.uppercase)
                    Text(instructions ?? "Loading")
                        .font(.body)
                }
                Spacer()
            }.padding(.bottom, 4)
        }.padding()
    }
    
    var clipboard: some View {
        VStack {
            Image(systemName: "list.bullet.clipboard")
                .font(.title)
            Spacer(minLength: 24)
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .frame(maxWidth: 2, maxHeight: .infinity)
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
