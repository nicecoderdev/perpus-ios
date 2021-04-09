//
//  HomeViewController.swift
//  Perpus
//
//  Created by Dody Wicaksono on 08/04/21.
//  Copyright © 2021 Dody Wicaksono. All rights reserved.
//


import UIKit
import vfrReader

struct Section {
    var name: String!
    var folder: String!
    var items: [Book]!

    init(name: String, folder: String, items: [Book]) {
        self.name = name
        self.folder = folder
        self.items = items
    }
}

struct Book {
    var title: String!
    var file: String!
    
    init(title: String, file: String) {
        self.title = title
        self.file = file
    }
}

class HomeViewController: UITableViewController, ReaderViewControllerDelegate {
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Perpus - My Library"
        
        initData()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file : String = sections[indexPath.section].items[indexPath.row].file
        let folder : String = sections[indexPath.section].folder
        loadPdf(file: file, folder: folder)
    }

    func loadPdf(file : String, folder : String) {
        if let filePath = Bundle.main.path(forResource: file, ofType: "pdf", inDirectory: "pdf/\(folder)") {
            let document : ReaderDocument = ReaderDocument.init(filePath: filePath, password: nil)
            let readerViewController : ReaderViewController = ReaderViewController.init(readerDocument: document)
            readerViewController.delegate = self
            self.present(readerViewController, animated: true, completion: nil)
        }
    }
    
    func dismiss(_ viewController: ReaderViewController!) {
        dismiss(animated: true, completion: nil)
    }
    
    func initData() {
        sections = [
            Section(
                name: "Business",
                folder: "business",
                items: [
                    Book(
                        title: "75 No-Code Business Ideas",
                        file: "75 No-Code Business Ideas"
                    ),
                    Book(
                        title: "Flat Fee Freelancer PDF version",
                        file: "Flat_Fee_Freelancer_PDF_version"
                    ),
                    Book(
                        title: "Freelancing and Consulting as a Side Hustle",
                        file: "Freelancing and Consulting as a Side Hustle"
                    ),
                    Book(
                        title: "The Gig Economy Mindset",
                        file: "The Gig Economy Mindset"
                    ),
                ]
            ),
            Section(
                name: "Swift",
                folder: "swift",
                items: [
                    Book(
                        title: "iOS13 Programming for Beginners 4th Edition",
                        file: "ios13programmingforbeginners4thedition"
                    ),
                    Book(
                        title: "Learn Swift by Building Applications",
                        file: "learnswiftbybuildingapplications"
                    ),
                ]
            ),
            Section(
                name: "Java Android",
                folder: "java-android",
                items: [
                    Book(
                        title: "Android Programming for Beginners 2nd Edition.pdf",
                        file: "androidprogrammingforbeginners2ndedition"
                    ),
                ]
            ),
            Section(
                name: "Kotlin",
                folder: "kotlin",
                items: [
                    Book(
                        title: "Android Programming with Kotlin for Beginners",
                        file: "androidprogrammingwithkotlinforbeginners"
                    ),
                ]
            ),
        ]
    }
}
