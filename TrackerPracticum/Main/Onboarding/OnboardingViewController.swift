//
//  OnboardingViewController.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 08.06.2023.
//

import UIKit

final class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private lazy var pages: [UIViewController] = {
        return [bluePage, redPage]
    }()
    
    private lazy var bluePage: UIViewController = {
        let bluePage = UIViewController()
        let image = "onboardingBlue"
        bluePage.view.addBackground(image: image)
        return bluePage
    }()
    
    private lazy var redPage: UIViewController = {
        let redPage = UIViewController()
        let image = "onboardingRed"
        redPage.view.addBackground(image: image)
        return redPage
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .YPBlack
        pageControl.pageIndicatorTintColor = UIColor.YPBlack.withAlphaComponent(0.3)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var bluePageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Отслеживайте только то, что хотите"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var BluePageEnterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вот это технологии!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .YPBlack
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var redPageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Даже если это не литры воды и йога"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var redPageEnterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вот это технологии!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .YPBlack
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let first = pages.first { setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        addBluePage()
        addRedPage()
        addPageControl()
    }
    
    private func addBluePage() {
        bluePage.view.addSubview(bluePageLabel)
        bluePage.view.addSubview(BluePageEnterButton)
        
        NSLayoutConstraint.activate([
            bluePageLabel.bottomAnchor.constraint(equalTo: bluePage.view.safeAreaLayoutGuide.bottomAnchor, constant: -290),
            bluePageLabel.centerXAnchor.constraint(equalTo: bluePage.view.safeAreaLayoutGuide.centerXAnchor),
            bluePageLabel.widthAnchor.constraint(equalToConstant: 343),
            
            BluePageEnterButton.heightAnchor.constraint(equalToConstant: 60),
            BluePageEnterButton.leadingAnchor.constraint(equalTo: bluePage.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            BluePageEnterButton.trailingAnchor.constraint(equalTo: bluePage.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            BluePageEnterButton.bottomAnchor.constraint(equalTo: bluePage.view.safeAreaLayoutGuide.bottomAnchor, constant: -71)
        ])
    }
    
    private func addRedPage() {
        redPage.view.addSubview(redPageLabel)
        redPage.view.addSubview(redPageEnterButton)
        
        NSLayoutConstraint.activate([
            redPageLabel.bottomAnchor.constraint(equalTo: redPage.view.safeAreaLayoutGuide.bottomAnchor, constant: -290),
            redPageLabel.centerXAnchor.constraint(equalTo: redPage.view.safeAreaLayoutGuide.centerXAnchor),
            redPageLabel.widthAnchor.constraint(equalToConstant: 343),
            
            redPageEnterButton.heightAnchor.constraint(equalToConstant: 60),
            redPageEnterButton.leadingAnchor.constraint(equalTo: redPage.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            redPageEnterButton.trailingAnchor.constraint(equalTo: redPage.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            redPageEnterButton.bottomAnchor.constraint(equalTo: redPage.view.safeAreaLayoutGuide.bottomAnchor, constant: -71)
        ])
    }
    
    private func addPageControl() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -155),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func enterButtonAction() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Invalid Configuration")
        }
        window.rootViewController = TabBarViewController.configure()
        UserDefaults.standard.set(true, forKey: "isOnbordingShown")
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return pages.last
        }
        return pages[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            return pages.first
        }
        return pages[nextIndex]
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool)
    {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}

extension UIView {
    
    func addBackground(image: String) {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: image)
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
