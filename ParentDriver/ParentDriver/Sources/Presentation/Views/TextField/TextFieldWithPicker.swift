import UIKit

protocol TitleIdble {
    var id: String { get }
    var title: String { get }
}

class TextFieldWithPicker: TextField {
    
    var onIdSelect: ((String) -> Void)?
    var values: [TitleIdble] = []
    var isNeedRightArrow: Bool = true
    
    private let componentsNumber: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func editingState() {
        super.editingState()
        if !values.isEmpty && text?.isEmpty == true {
            (self.inputView as? UIPickerView)?.selectRow(0, inComponent: componentsNumber - 1, animated: true)
            text = values.first?.title
            onIdSelect?(values.first?.id ?? "")
        }
    }
    
    override func normalState() {
        super.normalState()
    }
    
    private func setup() {
        let inputView = UIPickerView()
        inputView.delegate = self
        inputView.dataSource = self
        self.inputView = inputView
    }

    @objc private func changeRightViewState() {
        if isFirstResponder {
            resignFirstResponder()
        } else {
            becomeFirstResponder()
        }
    }
}

extension TextFieldWithPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = values[row]
        text = value.title
        onIdSelect?(value.id)
    }
}

extension TextFieldWithPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return componentsNumber
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
}
