**Part 48 -- Learning Questions**

1.

2.

3.

4.

5.

6.

7.

8.

9.

10.

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
