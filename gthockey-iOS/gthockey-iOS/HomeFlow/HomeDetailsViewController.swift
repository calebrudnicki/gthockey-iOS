//
//  HomeDetailsViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/4/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController {

    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 4000)

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.frame = self.view.bounds
        scrollView.contentSize = contentViewSize
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame.size = contentViewSize
//        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.frame.size = contentViewSize
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hey there"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
//        textView.isScrollEnabled = true
//        textView.isUserInteractionEnabled = true
        textView.text = "To Whom It May Concern, I am a senior Computer Science major at Georgia Tech with a focus on mobile development. I pride myself on clean and effective code as well working collaboratively with other programmers, designers, and product managers. After learning more about technology at Wayfair, including talking to a product manager on the Catalog Enrichment team, an iOS position seems to be a great fit for my skills and interests. To be an effective programmer, I believe that you not only have to write comprehensive code, but you also have to work well with your colleagues. Through my past three internships at Nike, ESPN, and Evident ID, I have refined my teamwork skills all while learning and refining new technical concepts. At my internship with Nike this past summer, I was tasked with deploying new designs to the Nike App’s checkout flow. In addition to the actual implementation, I was also involved in the entire optimization lifecycle: from design through testing. After finalizing the Invision mocks from the team’s designer, I was able to ask him questions and strategize the best approach to seamlessly integrate the new designs into the project. Next, I was able to use my technical skills to recreate the optimizations live in the Nike app. The final step in the process was to work alongside the team’s product manager to set up an AB test. This test enabled her to make critical decisions as to whether the optimizations were beneficial or detrimental to the Nike App’s checkout process and the company’s bottom-line. Throughout the entire process, I used my social skills to continually work alongside my colleagues for help with potential roadblocks and questions. In order to deliver a comprehensive mobile product, I had to work hand-in-hand with other developers, designers, and product owners. Though I enjoy the technical programming aspect of mobile development, my passion to create a product that real users benefit from drives me the most. Even if a product is the most technically sound, it is useless if it does not positively affect its intended audience. From my time working on a mobile e-commerce platform, I have not only learned about techniques to enhance the overall user experience, but I have also implemented technical functionalities to capitalize on a consumer’s digital behavior. I believe that these skills and experiences would be very applicable at Wayfair. I pride myself in my ability to connect with my colleagues on a technical, creative, and social level. I believe that this, alongside my technical programming skills and my understanding for mobile e-commerce, would allow me to hit the ground running as a mobile developer for Wayfair and I would be thrilled and honored to do so. Thank you in advance for your consideration. Caleb Rudnicki"
        textView.font = UIFont(name:"Helvetica Neue", size: 24.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    public func setWord(word: String) {
        label.text = word
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        imageView.image = UIImage(named: "JonesPic")

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textView)
//
//        NSLayoutConstraint.activate([
//                   stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
//                   stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//                   stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//                   stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//               ])

//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3)
//        ])
//
//        NSLayoutConstraint.activate([
//            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
//            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//        ])
    }

}
