import UIKit

final class ViewController: UIViewController {
//MARK: - переменные и константы
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var textFieldLogg: UITextView!
    @IBOutlet private weak var LableLog: UILabel!
    
    private var counter: UInt8 = 0 {
        didSet {
            updateCounterValue()
            setColorLabel()
            isBestNum()
        }
    }
    
//MARK: - перед запуском
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorLabel()
        LableLog.text = "История изменений:"
        textFieldLogg.text = ""
        textFieldLogg.isEditable = false
        counterLabel.text = "\(counter)"
    }

//MARK: - работа с кнопками
    @IBAction private func increaseCounter(_ sender: Any) {
        if counter < type(of: counter).max{
            counter += 1
            printLogg(code: "+")
        }
        else {
            printLogg(code: "Error")
        }
    }
    
    @IBAction private func reduceCounter(_ sender: Any) {
        printLogg(code: "-")
        
        if counter == type(of: counter).min {
        } else {
            counter -= 1
        }
    }
    
    @IBAction private func resetCounter(_ sender: Any) {
        counter = 0
        printLogg(code: "=")
    }
    
//MARK: - вспомогательные функции
    private func updateCounterValue() {
        counterLabel.text = "\(counter)"
    }
    
    private func setColorLabel(){
        switch counter {
            case 0...9: counterLabel.textColor = UIColor.magenta
            case 10...19: counterLabel.textColor = UIColor.brown
            default: counterLabel.textColor = UIColor.orange
        }
    }
    
    private func isBestNum(){
        if counter == 73 {
            textFieldLogg.text += "73 - Лучшее число не только по мнению Шелдона Купера!"
        }
    }
    
    //плавный скролл к концу лога нажатий кнопки
    private func scrollToBottom(){
        let range = NSRange(location: textFieldLogg.text.count - 1, length: 1)
        textFieldLogg.scrollRangeToVisible(range)
    }
    
    //логирование нажатий
    private func printLogg(code: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "[dd-MM-yyy HH:MM]"
        let formattedDate = dateFormatter.string(from: Date())
        
        if code == "=" {
            textFieldLogg.text += "\(formattedDate): значение сброшено\n"
        } else if counter == 0 && code == "-" {
            textFieldLogg.text += "\(formattedDate): попытка уменьшить значение счётчика ниже 0\n"
        } else if code == "Error" {
            textFieldLogg.text += "\(formattedDate): попытка выйти за установленный диапазон 0...\(type(of: counter).max)\n"
        } else {
            textFieldLogg.text += "\(formattedDate): значение измененено на \(code)1\n"
        }
        
        scrollToBottom()
    }
    
}
