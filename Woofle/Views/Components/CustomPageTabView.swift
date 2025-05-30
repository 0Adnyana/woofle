//
//  CustomPageTabView.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 30/05/25.
//


import SwiftUI
import UIKit

struct CustomPageTabView<Content: View, Item: Identifiable>: UIViewControllerRepresentable {
    var items: [Item]
    var content: (Item) -> Content
    var currentPageTintColor: UIColor = .systemBlue
    var pageIndicatorTintColor: UIColor = .lightGray

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageVC.dataSource = context.coordinator
        pageVC.delegate = context.coordinator

        let controllers = items.map { UIHostingController(rootView: content($0)) }
        context.coordinator.controllers = controllers

        if let first = controllers.first {
            pageVC.setViewControllers([first], direction: .forward, animated: false)
        }

        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.currentPageIndicatorTintColor = currentPageTintColor
        appearance.pageIndicatorTintColor = pageIndicatorTintColor

        return pageVC
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {}

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: CustomPageTabView
        var controllers: [UIViewController] = []

        init(_ parent: CustomPageTabView) {
            self.parent = parent
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
            return controllers[index - 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController), index + 1 < controllers.count else { return nil }
            return controllers[index + 1]
        }

        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            controllers.count
        }

        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            0
        }
    }
}