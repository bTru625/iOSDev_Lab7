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

11.

12.

13.

14.

15.

16.

17.

18.

19.

20.

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
