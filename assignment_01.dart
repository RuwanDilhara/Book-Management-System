import 'dart:io';

class Homepage {
  printWelcomeTitle() {


    BookManagement bookManagement = BookManagement();

      while(true){
        print('\n');
        print("""
                        888       d8b  888                                                  .d8888b.                        888                          
                        888       Y8P  888                                                 d88P  Y88b                       888                          
                        888            888                                                 Y88b.                            888                          
                        888       888  88888b.   888d888   8888b.   888d888  888  888       "Y888b.     888  888  .d8888b   888888  .d88b.   88888b.d88b.  
                        888       888  888  "88b  888P"       "88b  888P"    888  888          "Y88b.   888  888  88K       888    d8P  Y8b  888 "888 "88b 
                        888       888  888   888  888     .d888888  888      888  888            "888   888  888  "Y8888b.  888    88888888  888  888  888 
                        888       888  888  d88P  888     888  888  888      Y88b 888      Y88b  d88P   Y88b 888       X88  Y88b.  Y8b.      888  888  888 
                        88888888  888  88888P"    888     "Y888888  888       "Y88888       "Y8888P"     "Y88888   88888P'   "Y888  "Y8888   888  888  888 
                                                                                  888                        888                                       
                                                                             Y8b d88P                   Y8b d88P                                       
                                                                              "Y88P"                     "Y88P"                                        
        """);
        print('\n');
        print("                   (1) => add book");
        print("                   (2) => search by book title");
        print("                   (3) => search by book author");
        print("                   (4) => search by book isbm");
        print("                   (5) => remove book");
        print("                   (6) => update  book status");
        print("                   (7) => Exit");
        print('\n');

        stdout.write("                    Choose an option(1-7) : ");
        String? option = stdin.readLineSync();

        switch (option) {
          case "1":bookManagement.addBook();
          case "2":bookManagement.searchByTitle();
          // case "3":bookManagement.searchByAuthor();
          case "4":bookManagement.searchByISBM();
          case "5":bookManagement.removeBook();
          case "6":bookManagement.updateBookStatus();
          case "7":exit(0);
          default: print("\n                   Invalid option. Please enter a number between 1 and 7.");
        }
      }
  }
}

enum Status { available, borrowed }

class Book {
  String _title;
  String _author;
  String _iSBM;
  Enum _status = Status.available;

  Book(this._title, this._author, this._iSBM);

  String get title => this._title;
  String get author => this._author;
  String get iSBN => this._iSBM;
  Enum get status => this._status;

  set title(String value) => this._title = value;
  set author(String value) => this._author = value;
  set iSBN(String value) => this._iSBM = value;
  set status(Enum value) => this._status = value;

  @override
  String toString() {
    return 'Book{_title: $_title, _author: $_author, _isbm: $_iSBM, _status: $_status}';
  }

  bool validateIsbm() {
    return _iSBM.length == 13;
  }

  void isUpdateStatus(Enum value) {
    this._status = value;
  }
}

class TextBook extends Book {
  String _subjectArea;
  int _gradeLevel;

  TextBook(super.title, super.author, super.isbm, this._gradeLevel,
      this._subjectArea);

  set subjectArea(String value) => this._subjectArea = value;
  set gradeLevel(int value) => this._gradeLevel = value;

  String get subjectArea => this._subjectArea;
  int get gradeLevel => this._gradeLevel;
}

class BookManagement {
  List<Book> books = [];

  void addBook() {

    stdout.write("\n                    Enter Title : ");
    String? title = stdin.readLineSync();

    stdout.write("                    Enter Author : ");
    String? author = stdin.readLineSync();

    stdout.write("                    Enter ISBM : ");
    String? iSBM = stdin.readLineSync();

    if(title != null && title != '' && author != null && author != ''){
      if(isValidISBM(iSBM)){
        Book book = Book(title, author, iSBM!);
        books.add(book);
        print(book.toString());
      }else{
        print('\n                   The ISBM number must contain 13 digits. Try Again!...');
      }
    }else{
      print('\n                   Enter value try again!...');
    }


  }
  bool isValidISBM(String? iSBM){
    var newISBM="";
    if(iSBM != '' && iSBM != null) {
      for(int i =0; i<iSBM.length; i++){
       int? num = int.tryParse(iSBM[i]);
       if(num != null){
         newISBM += num.toString();
       }
      }
      return newISBM.length == 13;
    }
    return false;
  }
  Book? searchByISBM() {

    stdout.write("\n                   Please enter the valid ISBN number : ");
    String? iSBM = stdin.readLineSync();

    if(iSBM != null && iSBM != '' && isValidISBM(iSBM)){
      Book? book;
        for (Book value in books) {
          if(iSBM == value._iSBM){
            book = value;
            String  title = value._title;
            String  author = value._author;
            String  isbm = value._iSBM;

            print("\n                   Title  : $title.");
            print("                   Author : $author");
            print("                   ISBM   : $isbm");

            return value;
          }
        }if(book == null){
        print("\n                   Invalid iSBM Number !..");
      }
    }else{
      print("\n                   Invalid iSBM Number !..");
    }
    return null;
  }

  void removeBook() {
    Book? book;
    book = searchByISBM();
    
    stdout.write('\n                   Are you sure you want to delete this book? (y/n)');
    var option = stdin.readLineSync();
    if(option.toString() == "Y" || option.toString() == "y" && book != null){
      books.remove(book);
      print("\n                   Customer deleted successfully");
    }
  }
  void updateBookStatus(){
    stdout.write("\n                   Please enter the valid ISBN number : ");
    String? iSBM = stdin.readLineSync();

    if(iSBM != null && iSBM != '' && isValidISBM(iSBM)){
      for (Book value in books) {
        if (iSBM == value._iSBM) {
          String title = value._title;
          String author = value._author;
          String isbm = value._iSBM;
          Enum status = value._status;

          print("\n                   Title  : $title.");
          print("                   Author : $author");
          print("                   ISBM   : $isbm");
          print("                   Status   : $status");
          stdout.write(
              "                    Enter Book Status(available => a / borrowed => b) : ");
          String? newStatus = stdin.readLineSync();

          if (newStatus == "a" || newStatus == "A") {
            value._status = Status.available;
          } else if (newStatus == "b" || newStatus == "B") {
            value._status = Status.borrowed;
          } else {
            print('Invalid input.Try again !...');
          }
        } else {
          print("\n                   Wrong iSBM Number !..");
        }
      }
    }else{
      print("\n                   Invalid iSBM Number !..");
    }
  }

  Book? searchByTitle(){
    stdout.write("\n                   Please enter the valid ISBN number : ");
    String? title = stdin.readLineSync();
    for(Book value in books){

    }
  }
}
void clearConsole() {
  print('\x1B[2J\x1B[0;0H'); // Clears the terminal
}
void main() {
  Homepage homepage = Homepage();
  homepage.printWelcomeTitle();
}