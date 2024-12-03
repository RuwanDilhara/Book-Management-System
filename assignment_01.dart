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
        print("\t\t\t\t\t\t\t\t\t\t(1) => add book");
        print("\t\t\t\t\t\t\t\t\t\t(2) => search by book title");
        print("\t\t\t\t\t\t\t\t\t\t(3) => search by book author");
        print("\t\t\t\t\t\t\t\t\t\t(4) => search by book isbm");
        print("\t\t\t\t\t\t\t\t\t\t(5) => remove book");
        print("\t\t\t\t\t\t\t\t\t\t(6) => update  book status");
        print("\t\t\t\t\t\t\t\t\t\t(7) => Exit");
        print('\n');

        stdout.write("                    Choose an option(1-7) : ");
        String? option = stdin.readLineSync();

        switch (option) {
          case "1":bookManagement.addBook();
          case "2":bookManagement.searchByTitle();
          case "3":bookManagement.searchByAuthor();
          case "4":bookManagement.searchByISBM();
          case "5":bookManagement.removeBook();
          case "6":bookManagement.updateBookStatus();
          case "7":exit(0);
          default: print("\n\t\t\t\t\t\t\t\t\t\tInvalid option. Please enter a number between 1 and 7.");
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

    stdout.write("\n\t\t\t\t\t\t\t\t\t\tEnter Title : ");
    String? title = stdin.readLineSync();

    stdout.write("\t\t\t\t\t\t\t\t\t\tEnter Author : ");
    String? author = stdin.readLineSync();

    stdout.write("\t\t\t\t\t\t\t\t\t\tEnter ISBM : ");
    String? iSBM = stdin.readLineSync();

    if(title != null && title != '' && author != null && author != ''){
        var upperCaseAuthor = author.toUpperCase();
        var upperCaseTitle = title.toUpperCase();


      if(isValidISBM(iSBM)){
        Book book = Book(upperCaseTitle, upperCaseAuthor, iSBM!);
        books.add(book);
        print(book.toString());
      }else{
        print('\n\t\t\t\t\t\t\t\t\t\tThe ISBM number must contain 13 digits. Try Again!...');
      }
    }else{
      print('\n\t\t\t\t\t\t\t\t\t\tEnter value try again!...');
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

    stdout.write("\n\t\t\t\t\t\t\t\t\t\tPlease enter the valid ISBN number : ");
    String? iSBM = stdin.readLineSync();

    if(iSBM != null && iSBM != '' && isValidISBM(iSBM)){
      Book? book;
        for (Book value in books) {
          if(iSBM == value._iSBM){
            book = value;
            String  title = value._title;
            String  author = value._author;
            String  isbm = value._iSBM;

            print("\n\t\t\t\t\t\t\t\t\t\tTitle  : $title");
            print("\t\t\t\t\t\t\t\t\t\tAuthor : $author");
            print("\t\t\t\t\t\t\t\t\t\tISBM   : $isbm");

            return value;
          }
        }if(book == null){
        print("\n\t\t\t\t\t\t\t\t\t\tInvalid iSBM Number !..");
      }
    }else{
      print("\n\t\t\t\t\t\t\t\t\t\tInvalid iSBM Number !..");
    }
    return null;
  }

  void removeBook() {
    Book? book;
    book = searchByISBM();
    
    stdout.write('\n\t\t\t\t\t\t\t\t\t\tAre you sure you want to delete this book? (y/n)');
    var option = stdin.readLineSync();
    if(option.toString() == "Y" || option.toString() == "y" && book != null){
      books.remove(book);
      print("\n\t\t\t\t\t\t\t\t\t\tCustomer deleted successfully");
    }
  }
  void updateBookStatus(){
    stdout.write("\n\t\t\t\t\t\t\t\t\t\tPlease enter the valid ISBN number : ");
    String? iSBM = stdin.readLineSync();

    if(iSBM != null && iSBM != '' && isValidISBM(iSBM)){
      for (Book value in books) {
        if (iSBM == value._iSBM) {
          String title = value._title;
          String author = value._author;
          String isbm = value._iSBM;
          Enum status = value._status;

          print("\n\t\t\t\t\t\t\t\t\t\tTitle  : $title.");
          print("\t\t\t\t\t\t\t\t\t\tAuthor : $author");
          print("\t\t\t\t\t\t\t\t\t\tISBM   : $isbm");
          print("\t\t\t\t\t\t\t\t\t\tStatus   : $status");
          stdout.write("\t\t\t\t\t\t\t\t\t\tEnter Book Status(available => a / borrowed => b) : ");
          String? newStatus = stdin.readLineSync();

          if (newStatus == "a" || newStatus == "A") {
            value._status = Status.available;
          } else if (newStatus == "b" || newStatus == "B") {
            value._status = Status.borrowed;
          } else {
            print('\t\t\t\t\t\t\t\t\t\tInvalid input.Try again !...');
          }
        } else {
          print("\n\t\t\t\t\t\t\t\t\t\tWrong iSBM Number !..");
        }
      }
    }else{
      print("\n\t\t\t\t\t\t\t\t\t\tInvalid iSBM Number !..");
    }
  }

  Book? searchByTitle(){
    stdout.write("\n\t\t\t\t\t\t\t\t\t\tPlease enter the correct title : ");
    String? title = stdin.readLineSync();

    if(title != null && title != ""){
      String upperCaseTitle = title.toUpperCase();
      for(Book value in books){
        if(value._title == upperCaseTitle){
          String title = value._title;
          String author = value._author;
          String isbm = value._iSBM;
          Enum status = value._status;

          print("\n\t\t\t\t\t\t\t\t\t\tTitle  : $title");
          print("\t\t\t\t\t\t\t\t\t\tAuthor : $author");
          print("\t\t\t\t\t\t\t\t\t\tISBM   : $isbm");
          print("\t\t\t\t\t\t\t\t\t\tStatus   : $status");

          return value;
        }
        print('\n\t\t\t\t\t\t\t\t\t\tInvalid Title! ...');
      }
    }
    return null;
  }
  Book? searchByAuthor(){
    stdout.write("\n\t\t\t\t\t\t\t\t\t\tPlease enter the correct author name : ");
    String? author = stdin.readLineSync();

    if(author != null && author != ""){
      String upperCaseAuthor = author.toUpperCase();
      for(Book value in books){
        if(value._author == upperCaseAuthor){
          String title = value._title;
          String author = value._author;
          String isbm = value._iSBM;
          Enum status = value._status;

          print("\n\t\t\t\t\t\t\t\t\t\tTitle  : $title");
          print("\t\t\t\t\t\t\t\t\t\tAuthor : $author");
          print("\t\t\t\t\t\t\t\t\t\tISBM   : $isbm");
          print("\t\t\t\t\t\t\t\t\t\tStatus   : $status");

          return value;
        }
        print('\n\t\t\t\t\t\t\t\t\t\tInvalid Author! ...');
      }
    }
    return null;
  }
  void clearConsole() {
    print('\x1B[2J\x1B[0;0H'); // Clears the terminal
  }
}

void main() {
  Homepage homepage = Homepage();
  homepage.printWelcomeTitle();
}