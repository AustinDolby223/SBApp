import SwiftUI

struct ItemView: View {
    @Binding var name: String
    @Binding var points: String
    @Binding var coin: String
    @Binding var player: String
    @Binding var player2: String
    @Binding var rushing: String
    @Binding var pass: String
    @Binding var winner: Int

    var body: some View {
        VStack{
            Text("\(name)")
            Text("\(points)")
            Text("\(coin)")
            Text("\(player)")
           Text("\(player2)")
            Text("\(rushing) Rushing TD")
            Text("\(pass) Passing TD")
            Text("Score: \(winner)")
        }
        .font(.largeTitle)

    }
}


