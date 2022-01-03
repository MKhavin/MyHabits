import UIKit

class InfoViewController: UIViewController {

    private lazy var infoStackView: UIScrollView = {
        let value = UIScrollView()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.showsVerticalScrollIndicator = true
        value.showsHorizontalScrollIndicator = false
        return value
    }()
    
    
    private lazy var infoHeader: UILabel = {
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.font = .systemFont(ofSize: 20, weight: .semibold)
        value.text = "Привычка за 21 день"
        value.textColor = .black
        return value
    }()
    
    private lazy var infoText: UILabel = {
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.font = .preferredFont(forTextStyle: .body).withSize(17)
        value.textAlignment = .left
        value.numberOfLines = 0
        value.lineBreakMode = .byWordWrapping
        value.text = """
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        
        1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
        
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.
        
        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
        
        4. Поздравить себя с прохождением первого серьезного порога в 21 день.
        За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
        
        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        
        6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
        """
        value.textColor = .black
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoStackView.addSubview(infoHeader)
        infoStackView.addSubview(infoText)
        view.addSubview(infoStackView)
        navigationItem.title = "Информация"
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            infoStackView.contentLayoutGuide.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor),
            infoStackView.contentLayoutGuide.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoHeader.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 16),
            infoHeader.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: 16),
            infoHeader.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            infoText.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 16),
            infoText.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: 16),
            infoText.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: -16),
            infoText.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor)
        ])
    }
}
