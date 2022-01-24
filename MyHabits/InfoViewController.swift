import UIKit

class InfoViewController: UIViewController {

    private lazy var infoStackView: UIScrollView = {
        let value = UIScrollView()
        value.toAutoLayout()
        value.showsVerticalScrollIndicator = true
        value.showsHorizontalScrollIndicator = false
        return value
    }()
    
    
    private lazy var infoHeader: UILabel = {
        let value = UILabel(font: Fonts.title3, text: "Привычка за 21 день")
        value.toAutoLayout()
        return value
    }()
    
    private lazy var infoText: UILabel = {
        let text = """
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        
        1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
        
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.
        
        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
        
        4. Поздравить себя с прохождением первого серьезного порога в 21 день.
        За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
        
        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        
        6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
        """
        let value = UILabel(font: Fonts.body, text: text)
        value.toAutoLayout()
        value.textAlignment = .left
        value.numberOfLines = 0
        value.lineBreakMode = .byWordWrapping
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Информация"
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        infoStackView.addSubview(infoHeader)
        infoStackView.addSubview(infoText)
        view.addSubview(infoStackView)
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
            infoHeader.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: GlobalConstants.subViewsBorderInset),
            infoHeader.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: GlobalConstants.subViewsBorderInset),
            infoHeader.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            infoText.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: GlobalConstants.subViewsBorderInset),
            infoText.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: GlobalConstants.subViewsBorderInset),
            infoText.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: -GlobalConstants.subViewsBorderInset),
            infoText.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor)
        ])
    }
}
