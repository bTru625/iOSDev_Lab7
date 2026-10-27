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
            
            continue

        //update student
        case "4":        
              
            continue 
        // delete student
        case "5":        
            
            continue
  
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
            
            continue

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
