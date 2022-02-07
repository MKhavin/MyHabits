import UIKit

class InfoViewController: UIViewController {

    private lazy var infoScrollView: UIScrollView = {
        let view = UIScrollView()
        view.toAutoLayout()
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.addSubviews([
            infoHeader,
            infoText
        ])
        return view
    }()
    
    private lazy var infoHeader: UILabel = {
        let view = UILabel(font: Fonts.title3, text: "Привычка за 21 день")
        return view
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
        let view = UILabel(font: Fonts.body, text: text)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        view.addSubview(infoScrollView)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Информация"
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.activate([
            infoScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            infoScrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            infoScrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoHeader.topAnchor.constraint(equalTo: infoScrollView.topAnchor,
                                            constant: GlobalConstants.subViewsBorderInset),
            infoHeader.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor,
                                                constant: GlobalConstants.subViewsBorderInset),
            infoHeader.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor,
                                                 constant: -GlobalConstants.subViewsBorderInset)
        ])
        
        NSLayoutConstraint.activate([
            infoText.topAnchor.constraint(equalTo: infoHeader.bottomAnchor,
                                          constant: GlobalConstants.subViewsBorderInset),
            infoText.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor,
                                              constant: GlobalConstants.subViewsBorderInset),
            infoText.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor,
                                               constant: -GlobalConstants.subViewsBorderInset),
            infoText.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor,
                                             constant: -GlobalConstants.subViewsBorderInset)
        ])
    }
}
