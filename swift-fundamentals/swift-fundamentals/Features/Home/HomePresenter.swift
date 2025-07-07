//
//  HomePresenter.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

protocol HomePresenterProtocol {
    var homeViewController: HomeViewControllerOutputProtocol? { get set }
}

class HomePresenter: HomePresenterProtocol {
    weak var homeViewController: HomeViewControllerOutputProtocol?
}
