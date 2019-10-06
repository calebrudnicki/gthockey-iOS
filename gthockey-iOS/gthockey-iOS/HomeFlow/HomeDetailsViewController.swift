//
//  HomeDetailsViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/4/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
//        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.text = "To Whom It May Concern, I am a senior Computer Science major at Georgia Tech with a focus on mobile development. I pride myself on clean and effective code as well working collaboratively with other programmers, designers, and product managers. After learning more about technology at Wayfair, including talking to a product manager on the Catalog Enrichment team, an iOS position seems to be a great fit for my skills and interests. To be an effective programmer, I believe that you not only have to write comprehensive code, but you also have to work well with your colleagues. Through my past three internships at Nike, ESPN, and Evident ID, I have refined my teamwork skills all while learning and refining new technical concepts. At my internship with Nike this past summer, I was tasked with deploying new designs to the Nike App’s checkout flow. In addition to the actual implementation, I was also involved in the entire optimization lifecycle: from design through testing. After finalizing the Invision mocks from the team’s designer, I was able to ask him questions and strategize the best approach to seamlessly integrate the new designs into the project. Next, I was able to use my technical skills to recreate the optimizations live in the Nike app. The final step in the process was to work alongside the team’s product manager to set up an AB test. This test enabled her to make critical decisions as to whether the optimizations were beneficial or detrimental to the Nike App’s checkout process and the company’s bottom-line. Throughout the entire process, I used my social skills to continually work alongside my colleagues for help with potential roadblocks and questions. In order to deliver a comprehensive mobile product, I had to work hand-in-hand with other developers, designers, and product owners. Though I enjoy the technical programming aspect of mobile development, my passion to create a product that real users benefit from drives me the most. Even if a product is the most technically sound, it is useless if it does not positively affect its intended audience. From my time working on a mobile e-commerce platform, I have not only learned about techniques to enhance the overall user experience, but I have also implemented technical functionalities to capitalize on a consumer’s digital behavior. I believe that these skills and experiences would be very applicable at Wayfair. I pride myself in my ability to connect with my colleagues on a technical, creative, and social level. I believe that this, alongside my technical programming skills and my understanding for mobile e-commerce, would allow me to hit the ground running as a mobile developer for Wayfair and I would be thrilled and honored to do so. Thank you in advance for your consideration. Caleb Rudnicki"
        textView.font = UIFont(name:"Helvetica Neue", size: 24.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    public func setWord(word: String) {
        textView.text = word
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "JonesPic")
        view.addSubview(imageView)
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
