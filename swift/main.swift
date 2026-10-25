import Foundation

let api = APIService()

func validateStudent(
    name: String, 
    program: String, 
    age: Int``
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

sleep(3.25) 

// clear screen 
print("\u{001B}[3J\u{001B}[2J\u{001B}[H", terminator: "")


var isRunning = true


while isRunning {
        
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

        case: "1":        // display all
            
            continue

        case: "2":        // find student by ID
            
            continue 

        case: "3":        // display all
            
            continue

        case: "4":        // find student by ID
              
            continue 

        case: "5":        // display all
            
            continue
  
        case: "6":        // find student by ID
            
            continue 

        case: "7":        // display all
            
            continue

        case: "8":        // find student by ID
            
            continue 

        case: "x" || "X": // exit
            
            isRunning = false
            
            print()
            print("Exiting Application")


        default:        // invalid input
    }


}

