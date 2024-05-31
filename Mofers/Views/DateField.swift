import SwiftUI

struct DateField: View {
    let placeholder: String
    @Binding var presented: Bool
    @Binding var date: Date?
    @Binding var value: String
    
    var body: some View {
        TextField(placeholder, text: $value, onEditingChanged: { value in
            presented = value
        })
        .onChange(of: value, perform: { _ in
            date = Globals.dateFormatter.date(from: value)
        })
    }
}

struct DateField_Previews: PreviewProvider {
    static var previews: some View {
        @State var date: Date? = nil
        @State var presented = false
        return DateField(placeholder: "Enter Date", presented: $presented, date: $date, value: .constant(""))
            .padding()
    }
}
