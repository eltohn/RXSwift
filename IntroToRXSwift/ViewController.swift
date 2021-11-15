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
        let label = UILabel()
        label.text = "El"
        return label
    }()
    
     var names = BehaviorRelay(value: ["VVV"])
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRxSwift()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(viewLabel)
        viewLabel.frame = CGRect(x: 10, y: 10, width: view.frame.width, height: view.frame.height)
    }
    
    private func setupRxSwift(){
        names.asObservable().debug()
            .throttle(<#T##dueTime: RxTimeInterval##RxTimeInterval#>, scheduler: <#T##SchedulerType#>)
            .filter({ value in
                value.count > 1
            })
            .map({ value in
                value.joined(separator: ", ,")
            })
            .subscribe(onNext: {[weak self] value in
                self?.viewLabel.text = value
            }).disposed(by: bag)
        
        names.accept(["AAA", "AAA", "AAA"])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.names.accept(["vvv","vvv"])
        }
        
    }
}

