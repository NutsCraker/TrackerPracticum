import UIKit

protocol FiltersViewControllerDelegate: AnyObject {
    func filterSelected(filter: Filter)
}

final class FiltersViewCcontroller: UIViewController {
    weak var delegate: FiltersViewControllerDelegate?
    
    private let filters: [Filter] = Filter.allCases
    var selectedFilter: Filter?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Фильтры"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.separatorColor = .YPGray
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FiltersViewCcontroller: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return filters.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let filterCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        let filter = filters[indexPath.row]
        filterCell.checkmarkImage.isHidden = filter != selectedFilter
        filterCell.label.text = filters[indexPath.row].rawValue
        if indexPath.row == filters.count - 1 {
            filterCell.separatorInset = UIEdgeInsets(top: 0, left: filterCell.bounds.size.width + 200, bottom: 0, right: 0);
            filterCell.contentView.clipsToBounds = true
            filterCell.contentView.layer.cornerRadius = 16
            filterCell.contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else if indexPath.row == 0 {
            filterCell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            filterCell.contentView.clipsToBounds = true
            filterCell.contentView.layer.cornerRadius = 16
            filterCell.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            filterCell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            filterCell.contentView.layer.cornerRadius = 0
        }
        filterCell.selectionStyle = .none
        return filterCell
    }
}

extension FiltersViewCcontroller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is CategoryTableViewCell else {
            return
        }
        let filter = filters[indexPath.row]
        delegate?.filterSelected(filter: filter)
        dismiss(animated: true)
    }
}

