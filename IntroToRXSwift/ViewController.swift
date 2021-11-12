//
//  ViewController.swift
//  IntroToRXSwift
//
//  Created by Elbek Shaykulov on 11/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let viewLabel: UILabel = {
        let l = UILabel()
        l.text = "El"
        return l
    }()
    
    var names = BehaviorRelay(value: ["Elbek"])
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(viewLabel)
        viewLabel.frame = CGRect(x: 10, y: 10, width: view.frame.width, height: view.frame.height)
        
        
        names.asObservable()
            .subscribe(onNext:{ [weak self] value in
                self?.viewLabel.text = value.joined(separator: ", ")
            }).disposed(by: bag)
        
        names.accept(["a","b","c","d","e","f"])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.names.accept(["g","h","i"])
        }
    }
}

