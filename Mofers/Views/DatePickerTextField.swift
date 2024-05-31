import Foundation
import SwiftUI


class dataPicker: ObservableObject {
    @Published var selectDate: Date?
}


struct DatePickerTextField: UIViewRepresentable {

    @ObservedObject var selectDate = dataPicker()
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    
    public var placeholder: String
    @Binding public var date: Date?
    var width: CGFloat
    @State var isDate: Date?
    
    func makeUIView(context: Context) -> UITextField {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        
        textField.placeholder = placeholder
        textField.inputView = datePicker
        textField.textColor = .black
        textField.font = .systemFont(ofSize: width / 30)
        //textField.borderStyle = .roundedRect
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: helper, action: #selector(helper.doneButtonTapped))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        helper.onDateValueChanged = {
            date = datePicker.date
            selectDate.selectDate = date
        }
        
        helper.onDoneButtonTapped = {
            if date == nil {
                date = datePicker.date
                selectDate.selectDate = date
            }
            
            textField.resignFirstResponder()
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = Globals.dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        public var onDateValueChanged: (() -> Void)?
        public var onDoneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            onDateValueChanged?()
        }
        
        @objc func doneButtonTapped() {
            onDoneButtonTapped?()
        }
    }
    
    class Coordinator {}
}
