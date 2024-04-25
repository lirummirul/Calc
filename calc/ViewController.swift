//
//  ViewController.swift
//  calc
//
//  Created by Lambert Lani on 4/25/24.
//

import UIKit

enum OperationType: String {
    case plus = "+"
    case minus = "-"
    case division = "/"
    case multi = "*"
    case equal = "="
}

class ViewController: UIViewController {
    private var leftOperand: Int?
    private var operation: OperationType?
    
    private let displayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 5
        label.text = "0"
        return label
    }()

    private let buttons: [[UIButton]] = {
        let buttonTitles: [[String]] = [
            ["7", "8", "9", "/"],
            ["4", "5", "6", "*"],
            ["1", "2", "3", "-"],
            ["0", ".", "=", "+"]
        ]

        var buttons: [[UIButton]] = []

        for titles in buttonTitles {
            var row: [UIButton] = []
            for title in titles {
                let button = UIButton()
                button.setTitle(title, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .lightGray
                button.layer.cornerRadius = 5
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
                row.append(button)
            }
            buttons.append(row)
        }

        return buttons
    }()

    private let buttonStacks: [UIStackView] = {
        var stackViews: [UIStackView] = []

        for _ in 0..<4 {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 12
            stackViews.append(stackView)
        }

        return stackViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupDisplayLabel()
        setupButtons()
    }
    
    private func setupDisplayLabel() {
           view.addSubview(displayLabel)

           NSLayoutConstraint.activate([
               displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               displayLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90)
           ])
       }

   private func setupButtons() {
       let buttonSize: CGFloat = 70
       let buttonSpacing: CGFloat = 12
       let vert: CGFloat = 30
       let goriz: CGFloat = 170

       for (rowIndex, row) in buttons.enumerated() {
           for (_, button) in row.enumerated() {
               buttonStacks[rowIndex].addArrangedSubview(button)
           }
       }

       for (rowIndex, stackView) in buttonStacks.enumerated() {
           view.addSubview(stackView)

           let rowPosition = CGFloat(rowIndex) * (buttonSize + buttonSpacing) + goriz

           stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: vert).isActive = true
           stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: rowPosition).isActive = true
           stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -vert).isActive = true
           stackView.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
       }
   }
    
    @objc func buttonClick(_ sender: UIButton) {
        guard let buttonText = sender.title(for: .normal) else {
            return
        }

        var text = displayLabel.text ?? ""
        text += buttonText
        displayLabel.text = text
    }

    func performOperation(_ sender: UIButton) {
        guard let operationText = sender.title(for: .normal),
            let operation = OperationType(rawValue: operationText) else {
                return
        }

        if case .equal = operation,
            let existingOperation = self.operation,
            let leftOperand = leftOperand,
            let rightOperandText = displayLabel.text,
            let rightOperand = Int(rightOperandText) {
            performOperation(existingOperation, lft: leftOperand, rgt: rightOperand)
        }

        guard let leftOperandText = displayLabel.text,
            let leftOperand = Int(leftOperandText) else {
                return
        }

        self.leftOperand = leftOperand
        self.operation = operation
        displayLabel.text = nil
    }

    private func performOperation(_ operation: OperationType, lft: Int, rgt: Int) {

        var result: Int = 0
        switch operation {
        case .plus:
            result = lft + rgt

        case .minus:
            result = lft - rgt

        case .division:
            result = lft / rgt

        case .multi:
            result = lft * rgt

        default:
            break
        }

        print(result)
    }

}


