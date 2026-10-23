# Three-Person Parallel Full-Stack Project Split

The project should be divided into three **vertical feature slices**. Each person works on a separate branch and owns a complete feature from Flask/SQLite through Swift and testing.

The goal is for everyone to work simultaneously. No person should need to wait for another person to finish an entire layer before starting.

## Branch setup

Create three branches from the same clean starting commit:

```text
feature/person-1-retrieval
feature/person-2-crud
feature/person-3-analytics
```

Each person should:

1. Pull the latest shared base before starting.
2. Work only in their assigned files whenever possible.
3. Commit small, focused changes.
4. Push their branch regularly.
5. Open a pull request when their slice is complete.

Do not edit another person's feature files without first coordinating with them.

## Shared contract agreed on before coding

The team should agree on this contract first. It is small enough to finalize in one short meeting and allows all three people to code independently.

### Student response

```json
{
  "id": 1,
  "name": "Alice",
  "program": "Computer Science",
  "age": 21
}
```

### Create/update request

Create and update requests must not include `id`:

```json
{
  "name": "Alice",
  "program": "Computer Science",
  "age": 21
}
```

### Validation rules

- `name` is required and cannot be empty.
- `program` is required and cannot be empty.
- `age` must be an integer from 16 through 100.
- Missing students return HTTP `404`.
- Invalid request data returns HTTP `400`.
- Successful student creation returns HTTP `201`.
- Successful delete returns a JSON object containing `message`.

## Person 1 — Retrieval slice

### Branch

`feature/person-1-retrieval`

### Backend and database

- Own the database setup and seed data in [`api/app.py`](api/app.py).
- Create the `students` table and connection helper.
- Implement:
  - `GET /students`
  - `GET /students/{id}`

If the team splits the Flask server into modules, place the retrieval routes in a separate module such as `api/routes/retrieval.py` rather than editing another person's route module.

### Swift

- Own the shared response models in [`swift/Student.swift`](swift/Student.swift):
  - `Student`
  - `NewStudent`
  - `MessageResponse`
  - `AverageAgeResponse`
- Implement:
  - `getStudents()`
  - `getStudent(id:)`

If `APIService.swift` becomes a merge point, add retrieval methods in a separate extension file such as `swift/APIService+Retrieval.swift`.

### Testing

- Verify database initialization and seed records.
- Test valid and missing student IDs with Thunder Client.
- Test Swift JSON decoding and display output.

### Full-stack deliverable

A working retrieval feature that can load all students and one student by ID.

## Person 2 — Mutation and validation slice

### Branch

`feature/person-2-crud`

### Backend and database

- Implement:
  - `POST /students`
  - `PUT /students/{id}`
  - `DELETE /students/{id}`
- Add and use server-side validation.
- Use parameterized SQL queries.
- Return the agreed status codes and response shapes.

If the team splits the Flask server into modules, place these routes in a separate module such as `api/routes/mutations.py`.

### Swift

- Implement:
  - `addStudent`
  - `updateStudent`
  - `deleteStudent`
- Implement readable networking errors in [`swift/APIError.swift`](swift/APIError.swift).
- Add the input validation needed by the add and update flows.

If `APIService.swift` becomes a merge point, add mutation methods in a separate extension file such as `swift/APIService+Mutations.swift`.

### Testing

- Test valid and invalid POST requests.
- Test complete PUT replacement behavior.
- Test deleting an existing and nonexistent student.
- Confirm errors are displayed clearly in Swift.

### Full-stack deliverable

A complete create, update, and delete flow with both client- and server-side validation.

## Person 3 — Filtering and statistics slice

### Branch

`feature/person-3-analytics`

### Backend and database

- Implement:
  - `GET /students/program/{program}`
  - `GET /students/statistics/average-age`
- Ensure program matching is case-insensitive.
- Use parameterized SQL queries.

If the team splits the Flask server into modules, place these routes in a separate module such as `api/routes/analytics.py`.

### Swift

- Implement:
  - `getStudentsByProgram(program:)`
  - `getAverageAge()`
- Implement local age sorting and statistics display.

If `APIService.swift` becomes a merge point, add analytics methods in a separate extension file such as `swift/APIService+Analytics.swift`.

### Project workflow

- Draft `.vscode/tasks.json` so all Swift files compile together.
- Document how to start Flask, run Swift, and test endpoints with Thunder Client.

### Testing

- Test case-insensitive program filtering.
- Test age sorting.
- Test average-age calculations.
- Test behavior with no matching students.

### Full-stack deliverable

A complete filtering, sorting, and statistics feature that works through the API and Swift client.

## Keeping the work parallel

### Files that should not be shared edit points

Use separate files or modules for feature work whenever possible:

| Feature | Flask module | Swift module |
|---|---|---|
| Retrieval | `api/routes/retrieval.py` | `swift/APIService+Retrieval.swift` |
| Mutations | `api/routes/mutations.py` | `swift/APIService+Mutations.swift` |
| Analytics | `api/routes/analytics.py` | `swift/APIService+Analytics.swift` |

The existing starter files can remain the final public structure after integration. The modules are a collaboration technique; their code can be moved into [`api/app.py`](api/app.py) and [`swift/APIService.swift`](swift/APIService.swift) during the final integration pass if required by the assignment.

### Shared files

These files are likely merge points:

- [`api/app.py`](api/app.py)
- [`swift/APIService.swift`](swift/APIService.swift)
- [`swift/main.swift`](swift/main.swift)
- [`swift/Student.swift`](swift/Student.swift)
- [`swift/APIError.swift`](swift/APIError.swift)
- `.vscode/tasks.json`

To avoid blocking:

- Person 1 owns the initial shared models and database setup.
- Persons 2 and 3 should use extension files and feature modules rather than editing shared files at the same time.
- Do not add menu cases directly to `main.swift` until the integration pass.
- Keep menu handlers in feature-specific files, such as `swift/MenuRetrieval.swift`, `swift/MenuMutations.swift`, and `swift/MenuAnalytics.swift`.

## Integration plan

Integration should happen after all three feature branches pass their own tests.

1. Person 1 opens the integration pull request first because it contains the shared models and database foundation.
2. Person 2 and Person 3 rebase or merge the latest base into their branches, resolve only genuine contract conflicts, and open their pull requests.
3. The team combines the feature modules and wires the menu in [`swift/main.swift`](swift/main.swift).
4. The team compiles all Swift files together and runs the complete endpoint checklist.
5. Each person reviews and manually tests a feature owned by someone else.

## Endpoint ownership

| Method | Endpoint | Owner |
|---|---|---|
| GET | `/students` | Person 1 |
| GET | `/students/{id}` | Person 1 |
| POST | `/students` | Person 2 |
| PUT | `/students/{id}` | Person 2 |
| DELETE | `/students/{id}` | Person 2 |
| GET | `/students/program/{program}` | Person 3 |
| GET | `/students/statistics/average-age` | Person 3 |

## Final end-to-end test

Run the complete request path for every feature:

```text
Swift menu
→ APIService
→ Flask route
→ SQLite query
→ JSON response
→ Swift decoding
→ displayed result
```

Before submitting, verify:

- Flask starts without errors.
- All seven endpoints work.
- Menu options `0` through `8` work.
- Invalid values produce readable messages.
- Missing IDs produce readable errors.
- Thunder Client can test the API independently.
- All Swift files compile together.
- `.vscode/tasks.json` is in the project root.
- `students.db` is created and persists data in the `api` folder.
