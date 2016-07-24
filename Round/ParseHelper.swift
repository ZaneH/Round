//
//  ParseHelper.swift
//  round
//
//  Created by Skylar Thomas on 6/25/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import Parse
import ParseUI

class ParseHelper {
    
    
    // User Relation
    static let ParseUserUsername  = "username"
    static let ParseUserFirstName = "firstName"
    static let ParseUserLastName = "lastName"
    static let ParseFullName = "fullName"
    static let ParseUserArray  = "userArray"
    
    static let ParseAddress = "address"
    
    static let ParseLocationName = "Name"
    static let ParseCreator = "creatorName"
    static let ParseDateMade = "createdAt"
    
    
    
    static func getUserArray(completionBlock: PFQueryArrayResultBlock){
        let query = PFUser.query()!
        
        query.findObjectsInBackgroundWithBlock(completionBlock)

    }
    
    
    // MARK: Users
    
    /**
     Fetch all users, except the one that's currently signed in.
     Limits the amount of users returned to 20.
     
     :param: completionBlock The completion block that is called when the query completes
     
     :returns: The generated PFQuery
     */
    static func allUsers(completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        let query = PFUser.query()!
        // exclude the current user
        //query.whereKey(ParseHelper.ParseUserUsername)
        query.orderByAscending(ParseHelper.ParseUserUsername)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
    static func searchEvents(searchText: String, completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        /*
         NOTE: We are using a Regex to allow for a case insensitive compare of usernames.
         Regex can be slow on large datasets. For large amount of data it's better to store
         lowercased username in a separate column and perform a regular string compare.
         */
        
        let query1 = PFQuery(className: "Events").whereKey(ParseHelper.ParseLocationName,
                                                             matchesRegex: searchText, modifiers: "i")
        
        let query2 = PFQuery(className: "Events").whereKey(ParseHelper.ParseCreator,
                                                           matchesRegex: searchText, modifiers: "i")
        
        let query = PFQuery.orQueryWithSubqueries([query1, query2])
        
        query.orderByAscending(ParseHelper.ParseLocationName) //order by closest
        query.limit = 80
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        
        return query
    }
    static func searchEventsByLoc(searchText: String, completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        /*
         NOTE: We are using a Regex to allow for a case insensitive compare of usernames.
         Regex can be slow on large datasets. For large amount of data it's better to store
         lowercased username in a separate column and perform a regular string compare.
         */
        
        let query = PFQuery(className: "Events")
        
        query.orderByAscending(ParseHelper.ParseLocationName) //order by closest
        query.limit = 80
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        
        return query
    }
//    static func searchUsers(searchText: String, completionBlock: PFQueryArrayResultBlock) -> PFQuery {
//        /*
//         NOTE: We are using a Regex to allow for a case insensitive compare of usernames.
//         Regex can be slow on large datasets. For large amount of data it's better to store
//         lowercased username in a separate column and perform a regular string compare.
//         */
//        let query1 = PFUser.query()!.whereKey(ParseHelper.ParseUserUsername,
//                                              matchesRegex: searchText, modifiers: "i")
//        
//        let query2 = PFUser.query()!.whereKey(ParseHelper.ParseUserFirstName,
//                                              matchesRegex: searchText, modifiers: "i")
//        
//        let query3 = PFUser.query()!.whereKey(ParseHelper.ParseUserLastName,
//                                              matchesRegex: searchText, modifiers: "i")
//        
//        let query4 = PFUser.query()!.whereKey(ParseHelper.ParseFullName,
//                                              matchesRegex: searchText, modifiers: "i")
//        
//        let query = PFQuery.orQueryWithSubqueries([query1, query2, query3, query4])
//        
//        query.orderByAscending(ParseHelper.ParseUserUsername)
//        query.limit = 20
//        
//        query.findObjectsInBackgroundWithBlock(completionBlock)
//        
//        return query
//    }
}
