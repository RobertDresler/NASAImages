//
//  BViewController.swift
//  NASAImages
//
//  Created by Robert Dresler on 07/05/2020.
//  Copyright © 2020 Robert Dresler. All rights reserved.
//

import NASAImagesCore
import RxSwift

class BViewController<ViewModel: BViewModel, ContentView: BView>: UIViewController {

    let viewModel: ViewModel

    var contentView: ContentView {
        guard let view = view as? ContentView else {
            fatalError("\(self) view is not \(String(describing: ContentView.self))")
        }
        return view
    }

    var bag = DisposeBag()

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Deinit of view controller: \(self)")
    }

    // MARK: Lifecycle

    override func loadView() {
        view = ContentView()
        setupView()
        setupGestures()
        setupTitle()
    }

    private func setupTitle() {
        title = viewModel.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    // MARK: Aditional setup

    func setupView() {}

    func setupGestures() {
        addHideGesture()
    }

    func bindViewModel() {}

    // MARK: Keyboard handling

    private func addHideGesture() {
        let hideGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(hideGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

}
