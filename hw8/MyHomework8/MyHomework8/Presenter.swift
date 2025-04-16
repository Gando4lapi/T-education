//
//  Presenter.swift
//  MyHomework8
//
//  Created by main on 16.04.2025.
//

import Foundation
import UIKit

protocol ProductViewProtocol : AnyObject {
    func showProducts(_ products: [Product])
    func showLoading()
    func hideLoading()
    func updateImage(for url: URL, with image : UIImage?)
    func updateDownloadProgress(progress : Double)
}

class ProductPresenter : NSObject {
    private weak var view : ProductViewProtocol?
    private let apiURL = URL(string : "https://fakestoreapi.com/products")!
    private var products : [Product] = []
    private var imageDownloads : [URLSessionTask : URL] = [:]
    private var imageCache : [URL : UIImage] = [:]
    private var downloadProgress : [URL : Double] = [:]
    private var totalBytesExpected: [URL : Int64] = [:]

    init(view : ProductViewProtocol) {
        self.view = view
    }

    func loadProducts() {
        view?.showLoading()
        URLSession.shared.dataTask(with: apiURL) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Ошибка загрузки продуктов: \(error)")
                DispatchQueue.main.async {
                    self.view?.hideLoading()
                }
                return
            }
            guard let data = data else {
                print("Нет данных о продуктах.")
                DispatchQueue.main.async {
                    self.view?.hideLoading()
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                self.products = try decoder.decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.view?.showProducts(self.products)
                    self.downloadImages()
                }
            } catch {
                print("Ошибка декодирования JSON: \(error)")
                DispatchQueue.main.async {
                    self.view?.hideLoading()
                }
            }
        }.resume()
    }

    private func downloadImages() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue : .main)
        for product in products {
            let task = session.dataTask(with : product.image)
            imageDownloads[task] = product.image
            task.resume()
        }
    }

    private func calculateOverallProgress() {
        guard !downloadProgress.isEmpty else { return }
        let overallProgress = downloadProgress.values.reduce(0, +) / Double(downloadProgress.count)
        view?.updateDownloadProgress(progress : overallProgress)
    }
}

extension ProductPresenter: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data : Data) {
        guard let url = imageDownloads[dataTask] else { return }
        if imageCache[url] == nil {
            imageCache[url] = UIImage(data : data)
        } else {
            if let existingData = imageCache[url]?.jpegData(compressionQuality: 1.0) {
                if let newImage = UIImage(data : existingData + data) {
                    imageCache[url] = newImage
                }
            }
        }
        view?.updateImage(for: url, with: imageCache[url])
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        let expectedContentLength = response.expectedContentLength
        guard let url = imageDownloads[dataTask] else {
            completionHandler(.allow)
            return
        }
        totalBytesExpected[url] = expectedContentLength
        downloadProgress[url] = 0
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didSendBodyData bytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let url = imageDownloads[dataTask], let expected = totalBytesExpected[url] else { return }
        if expected > 0 {
            downloadProgress[url] = Double(bytesSent) / Double(expected)
            calculateOverallProgress()
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Ошибка загрузки изображения: \(error)")
        }
        if let url = imageDownloads.removeValue(forKey : task) {
            print("Загружено: \(url)")
        }
    }
}
