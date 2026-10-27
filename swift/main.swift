import Foundation

let api = APIService()

func validateStudent(
    name: String, 
    program: String, 
    age: Int
) -> Bool {

    if name 
        .trimmingCharacters(in: .whitespaces)
        .isEmpty {

            print ("Name cannot be empty")

            return false
    }

        if program 
        .trimmingCharacters(in: .whitespaces)
        .isEmpty {

            print ("Program cannot be empty")

            return false
    }

    if age < 15 || age > 100 {

        print ("Age must be between 15 and 100")

        return false
    }


    //otherwise
    return true   
}


//TODO fn: DisplayStats (pg54 of pdf)



//Welcome msg / splash screen
print("""
__________________________________
| Student Management Application |
|   420-DM5-AS iOS Development   |
|                                |
| Edward Angeles, Shayan Delbari |
|       and Brett Trudel         |
|________________________________|
""")

try await Task.sleep(for: .seconds(3.25)) 

// clear screen 
print("\u{001B}[3J\u{001B}[2J\u{001B}[H", terminator: "")


print ("""
        ▄▄▄▄  ▄        ▄          ▄      
        █     █        █          █      
        █▄▄▄ ▄█▄ ▄ ▄ ▄▄█ ▄▄▄ ▄▄▄ ▄█▄     
           █  █  █ █ █ █ █▄█ █ █  █      
        ▄▄▄█  █▄ █▄█ █▄█ █▄▄ █ █  █▄     
▄▄▄▄▄   ____________________________     ▄ 
█ █ █                                    █ 
█ █ █ ▄▄▄ ▄▄▄ ▄▄▄ ▄▄▄ ▄▄▄ ▄▄▄▄▄ ▄▄▄ ▄▄▄ ▄█▄
█ █ █ ▄▄█ █ █ ▄▄█ █ █ █▄█ █ █ █ █▄█ █ █  █ 
█ █ █ █▄█ █ █ █▄█ █▄█ █▄▄ █ █ █ █▄▄ █ █  █▄
___________________ █ _____________________
                  ▄▄█                      
""")

// start of actual console menu app:
var isRunning = true


while isRunning {
        
   
    print("""
    ===========================================
                    MAIN MENU:
    ===========================================

            1. Display all students
            2. Search student by ID
            3. Add student
            4. Update student
            5. Delete student
            6. Filter by program
            7. Sort by age
            8. Display statistics

            X. Exit
    ___________________________________________

    Choose an option:
    """)

    var input : String? = nil

    while input == nil || input?.isEmpty ?? true {
        input = readLine()?.trimmingCharacters(in: .whitespaces) ?? nil
    }

    let choice = input

    switch choice{

        //display all
        case "1":
            
            do{

                let students = try await api.getStudents()

                if students.isEmpty {
                   
                    print ("No students found.")

                } else {
                    for student in students {

                        print (
                            "ID: \(student.id) - " + 
                            "\(student.name) - " +
                            "\(student.program) - " + 
                            "\(student.age) years old"
                        )
                    }
                }
            } catch {
                
                print ("Error: \(error)")
            }            

        //find student by ID
        case "2":        
            
            continue 

        //add student
        case "3":        
            
            print("Enter name:")

            let name = readLine()?? ""
            
            print("Enter age:")

            guard let ageInput = readLine(),
                let age = Int(ageInput) else {
                    
                    print("Age must be an integer.")

                    continue
                }

            if validateStudent(
                name: name,
                program: program,
                age: age
            ) {
                let newStudent = NewStudent(
                    name: name,
                    program: program,
                    age: age
                )

                do {

                    let student = 
                        try await api.addStudent(
                            newStdudent
                        )
                    print(
                        "Student created succesfully" 
                    )

                    print(
                         "\(student.id) - " +                    
                         "\(student.name) - " +                    
                         "\(student.program) - " +                    
                         "\(student.age)"
                    )
                } catch {
                    print("Error: \(error)")
                }
            }

        //update student
        case "4":        

            print("Enter sutdent ID:")
              
            guard let idInput = readLine(),
                let id = Int(idInput) else {

                    print("Invalid ID.")

                    continue
                } 

            print("Enter new name:")
             
            let name = readLine() ?? ""

            print("Enter new program:")

            let program = readLine() ?? ""

            print("Enter new age:")

            guard let ageInput = readLine(), 
                let age = Int(ageInput) else {

                    print("Age must be an integer.")

                    continue
                }
            if validateStudent(
                name: name,
                program: program,
                age: age
            ) {
                let updatedData = NewStudent(
                    name: name,
                    program: program,
                    age: age
                )

                do {
                    let student = 
                        try await api.updateStudent(
                            id: id,
                            student: updatedData
                        )

                    print(
                        "Student updated successfully."
                    )

                    print(
                          "\(student.id) - " +                    
                          "\(student.name) - " +                    
                          "\(student.program) - " +                    
                          "\(student.age)"
                    )
                } catch {
                    print("Error: \(error)")
                }
            }
        // delete student
        case "5":        
            
            print("Enter student ID:")

            guard let input = readLine(),
                let id = Int(input) else {
                    
                    print("Invalid ID.")
                    
                    continue
                }
            do {
                let message =
                    try await api.deleteStudent(id: id)

                print(message)
            } catch {
                print("Error: \(error)")
            }
  
        // filter by program
        case "6":
            var program: String? = nil
            print("Enter a program:")
            while program == nil || program?.isEmpty ?? true {
                program = readLine()?.trimmingCharacters(in: .whitespaces) ?? nil
            }

            guard let program else {
                continue
            }

            do {
                let students = try await api.getStudentsByProgram(program: program)

                if students.isEmpty {
                    print ("No students found.")
                } else {
                    for student in students {
                        print(
                            "ID: \(student.id) - " + 
                            "\(student.name) - " +
                            "\(student.program) - " + 
                            "\(student.age) years old"
                        )
                    }
                }
            } catch {
                print("Error: \(error)")
            }

        //sort by age
        case "7":
            do {
                let students = try await api.getStudentsSortedByAge()

                if students.isEmpty {
                    print("No students found.")
                } else {
                    for student in students {
                        print(
                            "ID: \(student.id) - " +
                            "\(student.name) - " +
                            "\(student.program) - " +
                            "\(student.age) years old"
                        )
                    }
                }
            } catch {
                print("Error: \(error)")
            }

        //display stats
        case "8":
            do {
                let average = try await api.getAverageAge()
                print("Average age: \(average)")
            } catch {
                print("Error: \(error)")
            }

        //exit
        case "x", "X", "0":       
            
            isRunning = false
            
            print()
            print("Exiting Application")


        //invalid input
        default:        
            print("Invalid Input:")

    }
}
