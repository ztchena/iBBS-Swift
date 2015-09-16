//
//  IBBSPostViewController.swift
//  iBBS
//
//  Created by Augus on 9/15/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit
import SwiftyJSON

class IBBSPostViewController: ZSSRichTextEditor {

    private let nodeID = "board"
    private let uid = "uid"
    private let articleTitle = "title"
    private let token = "token"
    private let content = "content"
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Preview", style: .Plain, target: self, action: "exportHTML")
//      self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelAction")
        
        // Set the HTML contents of the editor
//        self.setHTML(html)
        
//        self.placeholder = "Please tap to start editing";
        
        self.formatHTML = false
        
        // Set the base URL if you would like to use relative links, such as to images.
        self.baseURL = NSURL(string: "http://iAugus.com")
        
        
        // Set the toolbar item color
        self.toolbarItemTintColor = UIColor.redColor()
        
        // Set the toolbar selected color
        self.toolbarItemSelectedTintColor = UIColor.blackColor()

        // Choose which toolbar items to show
        //        self.enabledToolbarItems = [ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarH1, ZSSRichTextEditorToolbarParagraph]
        /**
        
        ZSSRichTextEditorToolbarBold
        ZSSRichTextEditorToolbarItalic
        ZSSRichTextEditorToolbarSubscript
        ZSSRichTextEditorToolbarSuperscript
        ZSSRichTextEditorToolbarStrikeThrough
        ZSSRichTextEditorToolbarUnderline
        ZSSRichTextEditorToolbarRemoveFormat
        ZSSRichTextEditorToolbarJustifyLeft
        ZSSRichTextEditorToolbarJustifyCenter
        ZSSRichTextEditorToolbarJustifyRight
        ZSSRichTextEditorToolbarJustifyFull
        ZSSRichTextEditorToolbarH1
        ZSSRichTextEditorToolbarH2
        ZSSRichTextEditorToolbarH3
        ZSSRichTextEditorToolbarH4
        ZSSRichTextEditorToolbarH5
        ZSSRichTextEditorToolbarH6
        ZSSRichTextEditorToolbarTextColor
        ZSSRichTextEditorToolbarBackgroundColor
        ZSSRichTextEditorToolbarUnorderedList
        ZSSRichTextEditorToolbarOrderedList
        ZSSRichTextEditorToolbarHorizontalRule
        ZSSRichTextEditorToolbarIndent
        ZSSRichTextEditorToolbarOutdent
        ZSSRichTextEditorToolbarInsertImage
        ZSSRichTextEditorToolbarInsertLink
        ZSSRichTextEditorToolbarRemoveLink
        ZSSRichTextEditorToolbarQuickLink
        ZSSRichTextEditorToolbarUndo
        ZSSRichTextEditorToolbarRedo
        ZSSRichTextEditorToolbarViewSource
        ZSSRichTextEditorToolbarParagraph
        ZSSRichTextEditorToolbarAll
        ZSSRichTextEditorToolbarNone
        
        */
        

    }


    @IBAction func sendAction(sender: AnyObject) {

        articleArray.setValue(getHTML(), forKey: content)
        
        APIClient.sharedInstance.post(articleArray[uid]!, nodeID: articleArray[nodeID]!, content: articleArray[content]!, title: articleArray[articleTitle]!, token: articleArray[token]!, success: { (json) -> Void in
            print(json)
            }) { (error ) -> Void in
                print(error)
        }
        
//        let param = [nodeID: articleArray[nodeID]!, uid: articleArray[uid]!, articleTitle: articleArray[articleTitle]!, token: articleArray[token]!, content: articleArray[content]!]
//        print(param)
//        APIClient.sharedInstance.post(param, success: { (json) -> Void in
//            print(json)
//            }) { (error ) -> Void in
//            print(error)
//        }
        print(articleArray)

    }
    
    func cancelAction(){
        self.dismissViewControllerAnimated(true , completion: nil)
    }

    
    override func showInsertURLAlternatePicker(){
        self.dismissAlertView()
        let picker = IBBSPickerViewController()
        picker.demoView = self
        let nav = UINavigationController()
        nav.navigationBar.translucent = false
        self.presentViewController(nav, animated: true, completion: nil)
        
    }
    
    override func showInsertImageAlternatePicker() {
        self.dismissAlertView()
        let picker = IBBSPickerViewController()
        picker.demoView = self
        picker.isInsertImagePicker = true
        let nav = UINavigationController()
        nav.navigationBar.translucent = false
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    func exportHTML() {
        NSLog("%@", self.getHTML())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
