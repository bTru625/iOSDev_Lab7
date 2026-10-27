**Part 48 -- Learning Questions**

1. The front end should not connect directly to the DB because it would open up the application to security issues, like the user could access the entire DB. It would cut out the layer that has all business logic, so we could not properly validate data coming in or going out

2. Flask is the framework to support extensions for the API. It also acts as the HTTP server. It recieves requests from the Service layer, uses the SQL queries to access the SQLite, and returns JSON (+ the status codes).

3. APIService is a part of the swift backend to communicate with the server (or Flask) to be able to transfer data.

4. NewStudent is the class to format the data given by the user. The user does not provide the id, it is auto-generated (autoincremented) by the DB.

5. NewStudent does not have ID, but Student does. When making a new student, you do not need the ID b/c it will added by the DB, it does not make sense to have ID be optional, because it is needed by other functions. When you are reading student you will need the ID. By having Student with an ID, you can use that type of the object instead

6. If delete works, it returns a message instead of an object. Therefore, the Delete function needs to decode a messageResponse.

7. 201 means Created. It means that the student was created successfully. It could return 200 also, but that does not explain fully the situation.

8. URLSession is only looking for issues in the transport-level. 404 is is an application-level error.

9. Codable allows for Encodable and Decodable. This allows swift to be converted to JSON.

10. JSONEncoder = turning Swift into JSON.
    JSONDecoder = turning JSON into Swift

11. Content-Type: application/json required?
    Yes, when sending a JSON body. It tells Flask how to interpret the request body. Without it, request.get_json() can fail or return None, because Flask won’t treat the body as JSON.

12. What is the purpose of async ?
    It marks a function as asynchronous, meaning it can pause while waiting for something slow (like a network call) without blocking the main thread. This keeps the UI responsive.

13. What is the purpose of await ?
    It pauses execution of the current async function until the awaited operation finishes, then resumes with the result. It makes asynchronous code read like normal sequential code. It can only be used inside an async context.

14. What is the purpose of throws ?
    It declares that a function can fail by throwing an error. Callers are then forced to handle that possibility, which makes error handling explicit and safe.

15. What does try mean?
    It marks a call to a throwing function. It acknowledges that the call might fail and must be handled (via do-catch, or with try variants).

16. Why are network calls placed inside do-catch ?
    Network calls can fail (no connection, timeout, bad server response, decoding errors). do-catch lets the app handle these failures, such as showing an error message, instead of crashing.

17. What is the role of validateResponse ?
    It checks that the server’s response is acceptable before the app uses it, typically verifying the HTTP status code (e.g., 200-299) and that the data is present. If the check fails, it throws an error, preventing bad or error data from being processed as if it were valid.

18. Why must validation occur in Swift and Flask?
    - Swift (client): gives users fast feedback and avoids unnecessary requests, which improves the user experience. Client validation is for convenience.
    - Flask (server): is the real security and integrity boundary. Client-side checks can be bypassed (by editing the app or calling the API directly), so the server must never trust incoming data. Server validation is for safety.

19. What does map do in displayStatistics?
    It transforms each element of a collection into something else and returns a new collection of the same length. Ex. It might convert an array of data objects into an array of display strings or numeric values to show in the UI.

20. What does reduce do?
    It combines all elements of a collection into a single value by repeatedly applying a closure to an accumulator. For example, numbers.reduce(0, +) sums an array. In statistics code, it’s commonly used to compute totals, which can then be divided by the count to get an average.

21. When you do an Int / Int, it will return an Int, and any values after a decimal point will be lost. By converting to Double first, you can be precise with the data.

22. Filtering locally would mean you get all of the data, then you use Swift to sort the data you want.
    Filtering on the server side would be using SQL to only pull the info you need, and only getting that.

23. All swift files are needed in the swiftc command so the compiler can compile them all together.

24. vcvars64.bat sets up the build environment, it makes the libraries and the other files we need in compiling Swift.

25. One of the commands in the task.json file is cd swift. If .vscode was in another file, the cd command would not work as the swift folder is in the root folder.

26. students.db exists on the hard drive so the data can survive even if the application is shut down and turned back on again.

27. This way, by using concatenation, user inputs are never run as SQL commands directly. SQL Injection used as a way to attack an application are not possible using concatenation.

28. (id,) in python means that it is a tuple, but a tuple of one element

29. If the Flask server is stopped (or I forgot to turn it on, dont ask me how I know this...) the app will still run, but data will not be able to be retrieved.

30. HTTP 404 gets translated in the validateresponse(\_:) method in the APIService layer.
