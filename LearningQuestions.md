**Part 48 -- Learning Questions**

1. The front end should not connect directly to the DB because it would open up the application to security issues, like the user could access the entire DB. It would cut out the layer that has all business logic, so we could not properly validate data coming in or going out

2. Flask is the framework to support extensions for the API. It connects the DB to the APIService layer.

3. APIService is a part of the swift backend to communicate with the server (or Flask) to be able to transfer data.

4. NewStudent is the class to format the data given by the user. The user does not provide the id, it is auto-generated (autoincremented) by the DB.

5. NewStudent does not have ID, but Student does. When making a new student, you do not need the ID b/c it will added by the DB, it does not make sense to have ID be optional, because it is needed by other functions. When you are reading student you will need the ID. By having Student with an ID, you can use that type of the object instead

6.

7.

8.

9.

10.

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

21.

22.

23.

24.

25.

26.

27.

28.

29.

30.
