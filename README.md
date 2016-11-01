# Swift Github Repo Search

## Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/08vCCBNpQi0?rel=0&modestbranding=1" frameborder="0" allowfullscreen></iframe><p><a href="https://www.youtube.com/watch?v=08vCCBNpQi0">GitHub Search Demo</a></p>

## Goal

The goal is to search for repositories on Github and display the results in your tableview. The user will tap a `UIBarButtonItem` such as `Search` to display a `UIAlertController` containing a `UITextField` prompting the user to enter a query. The controller should include two `UIAlertAction`s - one to initiate the search and one to cancel (i.e. dismiss the `UIAlertController`). After the search is complete, the alert controller should be dismissed and the tableview should be reloaded with the search results. Use `Alamofire` instead of `URLSession` to make your network calls.

## API Calls

It will be useful to read [the usage instructions](https://github.com/Alamofire/Alamofire#usage) of Alamofire before proceeding, but below are some high-level guidelines.

###### 0. Bring Alamofire into your API Client
```
import Alamofire
```

###### 1. Declare a property to hold a URL string connecting us to GitHub (use appropriate path and access token, which should be in `Secrets.swift`)
```
let githubURL: String = "https://api.github.com"
```

###### 2. Pass your URL into an Alamofire request and handle the response within the response handler
```
//GET data
Alamofire.request(githubURL).responseJSON { response in
    print(response.request)  // original URL request
    print(response.response) // HTTP URL response
    print(response.error)    // any error, if one exists
    print(response.data)     // server data
    print(response.result)   // result of response serialization

    if let JSON = response.result.value {
        print("JSON: \(JSON)")
    }
}
```

###### 3. Use the appropriate HTTP Method verb in your request
```
// GET data with parameters
let params = [name : keyword] // Parameters are optional

Alamofire.request(.GET, url, parameters: params, encoding: .URL, headers: nil).validate().responseJSON { (response) 
	//pass data back here
}
```
```
// PUT data
Alamofire.request(.PUT, url).responseJSON { (response) in
   //you can create a JSON object by using its initializer: JSON(data: response.data)
   //response.result will give you a success enum that you can work with (will either be .Success or .Failure)
}
```
```
// DELETE data
Alamofire.request(.DELETE, url).responseJSON { (response) in
   //you can create a JSON object by using its initializer: JSON(data: response.data)
   //response.result will give you a success enum that you can work with (will either be .Success or .Failure)
}
```

## Instructions

[Apple's thoughts and feelings on JSON with Swift](https://developer.apple.com/swift/blog/?id=37)

1. Bring over your code from the GitHub Repo Starring lab. After dragging over your files, make sure you reestablish any connections needed in your project file. You will need:

  * `Secrets.swift`

  * `GithubAPIClient.swift`

  * `DataStore.swift`

  * `TableViewController.swift`

  * `Main.storyboard` (you may need to recreate your storyboard instead of dragging it over)

2. Write a method in `GithubAPIClient` that searches for repos from the text provided in the alert controller (which you will create). Take a look at the [repo search documentation](https://developer.github.com/v3/search/#search-repositories) and implement the appropriate method to do a search for repositories.

3. Add a `UIBarButtonItem` such as `Search` to your TableViewController in Storyboard. When a user taps the button, it should display a `UIAlertController` that prompts the user to enter a search query. Add a `UIAlertAction` to initiate the search. [This](https://www.hackingwithswift.com/read/5/3/pick-a-word-any-word-uialertcontroller) is a good resource on `UIAlertController`.

4. Re-implement the star/unstar methods using Alamofire instead of URLSession. If you didn't complete the Github-Starring lab, reference those instructions implementing the methods using Alamofire.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/swift-github-repo-search-lab' title='swift-github-repo-search-lab'>swift-github-repo-search-lab</a> on Learn.co and start learning to code for free.</p>

