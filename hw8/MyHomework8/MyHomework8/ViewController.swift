//
//  ViewController.swift
//  MyHomework8
//
//  Created by main on 16.04.2025.
//

import UIKit

class ViewController: UIViewController, ProductViewProtocol, UITableViewDelegate {

    private let tableView = UITableView()
    private let progressLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var products: [Product] = []
    private var imageDownloads: [URLSessionTask: URL] = [:]
    private var imageCache: [URL: UIImage] = [:]
    private var downloadProgress: [URL: Double] = [:]
    

    private var presenter: ProductPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = ProductPresenter(view: self)
        presenter.loadProducts()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(progressLabel)
        view.addSubview(activityIndicator)
        
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            progressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        progressLabel.textAlignment = .center
    }
    
    private func startLoadingProducts() {
        activityIndicator.startAnimating()
    }
    
    private func updateProgressLabel() {
        let totalImages = products.count
        let downloadedImages = imageCache.count
        if totalImages > 0 {
            progressLabel.text = "Загружено \(downloadedImages) из \(totalImages)"
        } else {
            progressLabel.text = "Загрузка..."
        }
    }
    
    func showProducts(_ products: [Product]) {
            self.products = products
            tableView.reloadData()
            tableView.isHidden = false
        }

        func showLoading() {
            activityIndicator.startAnimating()
            tableView.isHidden = true
            progressLabel.text = "Загрузка списка..."
        }

        func hideLoading() {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }

        func updateImage(for url: URL, with image: UIImage?) {
            if let index = products.firstIndex(where: { $0.image == url }),
               let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) {
                var content = cell.defaultContentConfiguration()
                content.text = products[index].title
                content.image = image ?? UIImage(systemName: "photo")
                cell.contentConfiguration = content
            }
        }

        func updateDownloadProgress(progress: Double) {
            progressLabel.text = "Прогресс: \(Int(progress * 100))%"
        }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
        let product = products[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = product.title
        content.secondaryText = nil
        content.image = imageCache[product.image] ?? UIImage(systemName: "photo") // Placeholder

        cell.contentConfiguration = content
        return cell
    }
}


extension ViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let url = imageDownloads[dataTask], var imageData = imageCache[url]?.jpegData(compressionQuality: 1.0) else { return }
        imageData.append(data)
        imageCache[url] = UIImage(data: imageData)
        calculateOverallProgress()
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows ?? [], with: .none)
            self.updateProgressLabel()
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        guard let url = imageDownloads[dataTask] else {
            completionHandler(.allow)
            return
        }
        
        downloadProgress[url] = 0
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Error downloading image: \(error)")
        }
        if let url = imageDownloads.removeValue(forKey: task) {
            print("Finished downloading: \(url)")
        }
    }

    private func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let url = imageDownloads[dataTask] else { return }
        if totalBytesExpectedToSend > 0 {
            downloadProgress[url] = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
            calculateOverallProgress()
        }
    }

    private func calculateOverallProgress() {
        guard !downloadProgress.isEmpty else { return }
        let overallProgress = downloadProgress.values.reduce(0, +) / Double(downloadProgress.count)
        DispatchQueue.main.async {
            self.progressLabel.text = "Прогресс: \(Int(overallProgress * 100))%"
        }
    }
}
