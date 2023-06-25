import UIKit

protocol ScheduleViewControllerDelegate: AnyObject {
    func createSchedule(schedule: [DayOfWeek])
}

final class ScheduleViewController: UIViewController {
    private let colors = Colors()
    public weak var delegate: ScheduleViewControllerDelegate?
    var schedule: [DayOfWeek] = []
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.text = "Расписание"
        label.font = UIFont.mediumSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .ypWhite
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private lazy var buttonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .ypWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.ypWhite, for: .normal)
        button.backgroundColor = .ypBlack
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        var width = view.frame.width - 16*2
        var height = 75*7
        tableView.register(WeekDayViewCell.self, forCellReuseIdentifier: WeekDayViewCell.identifier)
        tableView.layer.cornerRadius = 16
        tableView.separatorColor = .ypGray
        tableView.frame = CGRect(x: 16, y: 16, width: Int(width), height: Int(height))
        tableView.backgroundColor = .ypWhite
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.viewBackgroundColor
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(label)
        view.addSubview(scrollView)
        scrollView.addSubview(tableView)
        scrollView.addSubview(buttonBackgroundView)
        buttonBackgroundView.addSubview(enterButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27),
            
            scrollView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonBackgroundView.heightAnchor.constraint(equalToConstant: 80),
            
            enterButton.bottomAnchor.constraint(equalTo: buttonBackgroundView.bottomAnchor, constant: -10),
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            enterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            enterButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc
    private func enterButtonAction() {
        delegate?.createSchedule(schedule: schedule)
        dismiss(animated: true)
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayOfWeek.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weekDayCell = tableView.dequeueReusableCell(withIdentifier: WeekDayViewCell.identifier) as? WeekDayViewCell else {
            return UITableViewCell()
        }
        let weekDay = DayOfWeek.allCases[indexPath.row]
        weekDayCell.delegate = self
        weekDayCell.contentView.backgroundColor = .ypBackgroundColor
        weekDayCell.label.text = DayOfWeek.allCases[indexPath.row].rawValue
        weekDayCell.weekDay = weekDay
        weekDayCell.switchCell.isOn = schedule.contains(weekDay)
        if indexPath.row == 6 {
            weekDayCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            weekDayCell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        weekDayCell.selectionStyle = .none
        return weekDayCell
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ScheduleViewController: WeekDayViewCellDelegate {
    func stateChanged(for day: DayOfWeek, isOn: Bool) {
        if isOn {
            schedule.append(day)
        } else {
            if let index = schedule.firstIndex(of: day) {
                schedule.remove(at: index)
            }
        }
    }
}

