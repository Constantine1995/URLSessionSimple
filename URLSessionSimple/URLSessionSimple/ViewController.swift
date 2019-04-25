//
//  ViewController.swift
//  URLSessionSimple
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Get запрос - получить данные
    @IBAction func getTapped(_ sender: Any) {
        // Создали url
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Создаем singlenton и вызываем в нем dataTask ниже
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            // response - ответ сервера, содержится вся необходимая информация по запросу, и его статус
            if let response = response {
                print(response)
            }
            
            // data - данные, которые мы получили по данному url
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            }.resume()
    }
    
    // Post запрос - отправить данные
    @IBAction func postTapped(_ sender: Any) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        // Параметры, которые мы хотим передать на сервер
        let parameters = ["username": "Constantine", "message": "It's me"]
        // Создаем запрос
        var request = URLRequest(url: url)
        // Определяем метод, что это POST
        request.httpMethod = "POST"
        // Определяяем заголовок, гооврим о том, что мы будет отправлять JSON
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Создаем тело запроса с параметрами
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        // Присваиваем тело запроса
        request.httpBody = httpBody
        
        let session = URLSession.shared
        // Задача на получение данных с текущим request
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            // Извлекаем данные
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            }.resume()
    }
}

