import SwiftUI


struct ContentView: View {
    
    var teams = ["49ers", "Cheifs"]
    @State private var selectedTeam = "49ers"

    var points = ["Over 47.5 Pts", "Under 47.5 Pts"]
    
    @State private var selectedPoints = "Over"
    
     var coin = ["Heads", "Tails"]
    
    @State private var selectedToss = "Heads"

    var player = [ "Travis Kelce", "Patrick Mahomes", "Isiah Pacheco", "Rashee Rice"]
    
    @State private var selectedPlayer = "Player"
    
    var player2 = ["Deebo Samuel", "Brandon Aiyuk", "George Kittle", "Christian McCaffrey", "Brock Purdy"]
    
    @State private var selected49er = "Player2"
    
    var rushing = [ "1", "2", "3", "4", "5", "6", "7"]
    
    @State private var selectedRush = "Rushing"
    
    var pass = ["1", "2", "3", "4", "5", "6", "7"]
    
    @State private var selectedPassing = "Passing"
    
    @State var classPicks: [Item] = []
    
    @State var itemName: String = ""

    var highScore: (String,Int) {
        var high = 0
        var person = ""
        for i in classPicks {
            if i.Winner > high{
                person = i.name
                high = i.Winner
            }
        }
        return (person,high)
    }

    @State var PlayerWinner = ""    
    
    var body: some View {
        NavigationStack{
            
            VStack {
                
                HStack {
                    
                    
                    TextField("Enter Name", text: $itemName)
                    
                    Picker("Please choose a team", selection: $selectedTeam) {
                        ForEach(teams, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    
                    
                    Button(action: {
                        
                        if itemName != "" {
                            
                            let newItem = Item(name: itemName, TeamName: selectedTeam, Pionts: selectedPoints, Coin: selectedToss, Player: selectedPlayer,Player2: selected49er, Rushing: selectedRush, Passing: selectedPassing)
                            
                            
                            
                            classPicks.append(newItem)
                            
                            
                            itemName = ""
                            
                            //   TeamName = ""
                            SaveToUserDefaults()
                            
                        }
                        
                        
                    }, label: {
                        
                        Image(systemName: "plus.circle")
                        
                            .font(.largeTitle)
                        
                    })
                    .disabled(itemName == "")
                    
                }
                
                .padding()
                
                .textFieldStyle(.roundedBorder)
                
                .font(.body)
                
                
                HStack{
                    Spacer()
                    Text("Total Pts =")
                    Text("47.5")
                    Picker("Over Under", selection: $selectedPoints) {
                        ForEach(points, id: \.self) {
                            Text($0)
                        }
                    }
                    Spacer()
                }
                
                HStack{
                    Text("Coin Toss")
                    Picker("Coin Toss", selection: $selectedToss) {
                        ForEach(coin, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                
                HStack{
                    Text("Anytime TD Cheifs")
                    Picker("Player", selection: $selectedPlayer) {
                        ForEach(player, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                HStack{
                    Text("Anytime TD 49ers")
                    Picker("Player2", selection: $selected49er) {
                        ForEach(player2, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                HStack{
                    Text("Rushing TD Total")
                    Picker("TDs", selection: $selectedRush) {
                        ForEach(rushing, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                HStack{
                    Text("Passing TD Total")
                    Picker("Touch", selection: $selectedPassing) {
                        ForEach(pass, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                
                
                .padding()
                
                List{ 
                    Text("Winner: \(highScore.0) with \(highScore.1)")
                        .foregroundColor(.red)
                    ForEach($classPicks, id:\.self) { $item in
                        @State var score = item.Winner
                        VStack(alignment: .leading) {
                            
                        
                            
                            NavigationLink(destination: 
                                            ItemView(name: $item.name, points: $item.Pionts, coin: $item.Coin, player: $item.Player, player2: $item.Player2, rushing: $item.Rushing, pass: $item.Passing, winner: $score), label: {
                                HStack{
                                    Text("\(item.name)")
                                    Text("\(item.Winner)")
                                    
                                }
                                
                            })
                    }
                        
                  
                        
                        .font(.title)
                        .foregroundColor(.black)
                        
                    }
                    .onDelete(perform: delete)

                    .font(.title)
                    
                    
                    // 
                    
                }
                .toolbar {
                    EditButton()
                }
                
            }
            .onAppear(perform: {
                LoadFromUserDefaults()
            })
            
            .font(.title)
            
        }
    }
    func delete(at offsets: IndexSet) {
        // delete the objects here
        classPicks.remove(atOffsets: offsets)
        SaveToUserDefaults()
    }
    
    
    
    func SaveToUserDefaults ()
    {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(classPicks)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "classPicks")
            
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
     func LoadFromUserDefaults (){
         // Read/Get Data
         if let data = UserDefaults.standard.data(forKey: "classPicks") {
             do {
                 // Create JSON Decoder
                 let decoder = JSONDecoder()
                 
                 // Decode Note
                 let note = try decoder.decode([Item].self, from: data)
                 classPicks = note
                 
             } catch {
                 print("Unable to Decode Note (\(error))")
             }
         }

         
     }
    
}


struct Item: Hashable, Codable {
    
    var name: String
    
    var TeamName: String
    
    var Pionts: String
    
    var Coin: String

    var Player: String
    
    var Player2: String
    
    var Rushing: String
    
    var Passing: String
    
    var Winner: Int {
        var over = false
        var toss = false
        var players = false
        var passing = false
        if Pionts == "Under 47.5 Pts" {
            over = true
        }
        if Coin == "Heads" {
            toss = true
        }
        let player3 = false
        
        if Player2 == "Christian McCaffrey" {
            players = true
        }
        
        let rush = false 
        
        if Passing == "4" {
            passing = true
        }
        
        return((over ? 2 : 0) + (toss ? 2 : 0) + (player3 ? 3 : 0) + (players ? 3 : 0) + (passing ? 3 : 0) + (rush ? 3 : 0))
        
    }
}



