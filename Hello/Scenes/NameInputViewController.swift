//
//  NameInputViewController.swift
//  Hello
//
//  Created by Ivan Pavlov on 05.02.2026.
//

import UIKit

class NameInputViewController: UIViewController {

    // MARK: сюда передаём имя на прошлый экран
    var setNameAction: ((String) -> Void)?

    // MARK: подсказка
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите имя"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: поле ввода
    private lazy var textField: UITextField = {
        let text_field = UITextField()
        text_field.placeholder = "Ваше имя"
        text_field.borderStyle = .roundedRect
        text_field.autocorrectionType = .no
        text_field.autocapitalizationType = .words
        text_field.returnKeyType = .done

        // следим за вводом текста, чтобы включать/выключать кнопку
        text_field.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        text_field.translatesAutoresizingMaskIntoConstraints = false
        return text_field
    }()

    // MARK: кнопка сохранения
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)

        // оформление рамки
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 12
        button.clipsToBounds = true

        // изначально выключена, пока не введут имя
        button.isEnabled = false
        button.alpha = 0.5

        // отработка нажатия кнопки
        button.addAction(UIAction { [weak self] _ in
            self?.saveName()
        }, for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: регулирование всего по центру
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoLabel, textField, saveButton])
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
        setupTapToDismissKeyboard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }

    // MARK: Methods
    private func configureView() {
        title = "Ввод"
        view.backgroundColor = .systemBlue // фон
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            // распологаем ближе к верху, чтобы клавиатура не мешала
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // ограничение, чтобы не вылезило за края
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),

            // ширина для поля и кнопки (иначе может быть неудобно нажимать)
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            textField.heightAnchor.constraint(equalToConstant: 44),

            saveButton.widthAnchor.constraint(equalTo: textField.widthAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // закрытие клавиатуры по тапу на фон
    private func setupTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        tap.cancelsTouchesInView = false // чтобы не ломать нажатия по кнопкам/полю
        view.addGestureRecognizer(tap)
    }

    // чистим пробелы, чтобы "   " не считалось именем
    private func trimmedName() -> String {
        let raw = textField.text ?? ""
        return raw.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: ввод текста
    @objc private func textDidChange() {
        let name = trimmedName()
        let enabled = !name.isEmpty

        saveButton.isEnabled = enabled
        saveButton.alpha = enabled ? 1.0 : 0.5
    }

    // MARK: сохранить имя и вернуться назад
    private func saveName() {
        let name = trimmedName()
        guard !name.isEmpty else { return }

        setNameAction?(name)
        navigationController?.popViewController(animated: true)
    }

    // MARK: появление клавиатуры
    @objc private func didTapBackground() {
        view.endEditing(true)
    }
}

