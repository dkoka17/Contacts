//
//  ContactVC.swift
//  DialPad
//
//  Created by dato on 1/9/21.
//

import UIKit
import CoreData


class ContactVC: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!

    
    var dbContext = DBManager.shared.persistentContainer.viewContext
    
    lazy var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            UINib(nibName: "CollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CollectionViewCell"
        )
        fetchContacts()
        
    }
    
    func fetchContacts(){
        let request = Contact.fetchRequest() as NSFetchRequest<Contact>
        
        do{
            contacts = try dbContext.fetch(request)
            collectionView.reloadData()
        } catch {}
    }
    
    @IBAction func addContact(_ sender: Any) {
        let alert = UIAlertController(
            title: "Add Contact",
            message: "Add Contact",
            preferredStyle: .alert)
        
        var curName: UITextField?
        var curNumber:  UITextField?
        
        alert.addTextField { (textField) in
            textField.placeholder = "Contact Name"
            curName = textField
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Contact Number"
            textField.keyboardType = .numberPad
            curNumber = textField
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { [unowned self](_) in
             
            guard let nameField = curName, let name  = nameField.text, !name.isEmpty else { return }
            guard let numberField = curNumber, let number  = numberField.text, !number.isEmpty else { return }
           
            let contact = Contact(context: dbContext)
            
            contact.name = name
            contact.number = number
            
            do {
                try dbContext.save()
                fetchContacts()
                
            }catch {}
        }))
        
        present(alert, animated: true, completion: nil)
    }


}


extension ContactVC: UICollectionViewDelegate {
    
}

extension ContactVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.conf(with: contacts[indexPath.row])
        return cell
        
    }
}

extension ContactVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 145)
    }
    
}
