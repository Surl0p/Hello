//
//  HelloViewController.swift
//  Hello
//
//  Created by Ivan Pavlov on 05.02.2026.
//

import UIKit

class HelloViewController: UIViewController {

    // MARK: заголовок
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HELLO"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: кнопка для перехода на следующий экран
    private lazy var enterNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ввести имя", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)

        // оформление рамки
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 12
        button.clipsToBounds = true

        // отработка нажатия кнопки
        button.addAction(UIAction { [weak self] _ in
            self?.openNameInput()
        }, for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: регулирование всего по центру
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, enterNameButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: Methods
    private func configureView() {
        title = "Главная"
        view.backgroundColor = .systemBlue // фон
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            // расположение по центру
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            // ограничение, чтобы не вылезило за края
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),

            // кнопка по ширине (чтобы удобно нажимать)
            enterNameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            enterNameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: переход на экран ввода имени
    private func openNameInput() {
        let controller = NameInputViewController()

        // получаем имя со второго экрана и обновляем текст
        controller.setNameAction = { [weak self] name in
            self?.titleLabel.text = "Привет, \(name)"
        }

        navigationController?.pushViewController(controller, animated: true)
    }
}

