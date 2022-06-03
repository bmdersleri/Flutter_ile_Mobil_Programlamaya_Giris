import 'package:flutter/material.dart';
import 'main.dart';


class BasicCommands extends StatefulWidget {
  const BasicCommands({Key? key}) : super(key: key);
  @override
  BasicCommandsState createState() => BasicCommandsState();
}

class BasicCommandsState extends State<BasicCommands> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.dark(),
    home: Container(
      decoration:const BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [MainColors.backcolor1,MainColors.backcolor2 ])
      ) ,
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
          child: ExpansionPanelList(
            dividerColor: Colors.transparent,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                basicCommandData[index].isExpanded = !isExpanded;
                });
              },
            children: basicCommandData.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Colors.transparent,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.headervalue,style: Theme.of(context).textTheme.bodyText1?.copyWith(color: BasicCommandProps.commdanTextColor,fontFamily: "Verdana"),),
                  );
                },
                    body: ListTile(
                      title: Text(item.expandedvalue,style: Theme.of(context).textTheme.bodyText1?.copyWith(color: BasicCommandProps.descTextColor,fontFamily: "Verdana")),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              
              
              ),
              
              
            ),
            ),
          ),
        );
      }
      
    }

class BasicCommandProps {
  static const double commandDescSize = 16;
  static const FontWeight commandWeight = FontWeight.bold;
  static const Color commdanTextColor = Color.fromARGB(255, 132, 255, 0);
  static const Color descTextColor = Color.fromARGB(255, 253, 255, 219);
  
}
class Item {
  Item({
    required this.headervalue,
    required this.expandedvalue,
    this.isExpanded = false,
  });

  String headervalue;
  String expandedvalue;
  bool isExpanded;
}

List <Item> basicCommandData = [
  Item(headervalue:'man',expandedvalue: "man command in Linux is used to display the user manual of any command that we can run on the terminal. \nSyntax:\$man [OPTION]... [COMMAND NAME]..."),
  Item(headervalue: 'cd',expandedvalue: "cd command in linux known as change directory command. It is used to change current working directory. \n Syntax:\$ cd [directory]"),
  Item(headervalue: 'ls,',expandedvalue: "The ls is the list command in Linux. It will show the full list or content of your directory. Just type ls and press the enter key. The whole content will be shown.\n Syntax: ls [flags] [directory]"),
  Item(headervalue: 'cat',expandedvalue: "The cat command is a utility command in Linux. One of its most commonly known usages is to print the content of a file onto the standard output stream. Other than that, the cat command also allows us to write some texts into a file.\nSyntax:cat [OPTION] [FILE]"),
  Item(headervalue: 'touch',expandedvalue: "touch command is a way to create empty files (there are some other mehtods also). You can update the modification and access time of each file with the help of touch command.\nSyntax:"),
  Item(headervalue:  'mkdir',expandedvalue: "The basic command for creating directories in Linux consists of the mkdir command and the name of the directory.\nSyntax:mkdir [option] dir_name"),
  Item(headervalue:  'pwd',expandedvalue:"The pwd Linux command prints the current working directory path, starting from the root (/). Use the pwd command to find your way in the Linux file system structure maze or to pass the working directory in a Bash script..\nSyntax:pwd [-options]"),
  Item(headervalue:  'clear',expandedvalue:"The clear command clears the current terminal screen\nSyntax:clear"),
  Item(headervalue:  'rm',expandedvalue:"The rm command in Linux OS is used to remove files and directories from the command line. However, the removed files and directories do not get moved to the Trash. Instead, the rm command removes the files and directories permanently.\nSyntax:\$ rm [option]... [file]..."),
  Item(headervalue: 'rmdir',expandedvalue:"rmdir command removes empty directories specified on the command line. These directories are removed from the filesystem in the same order as they are specified on the command line, i.e., from left to right. If the directory is not empty you get an error message.\nSyntax:\$ rmdir [OPTION]... DIRECTORY..."),
  Item(headervalue:  'exit',expandedvalue:"The exit command exits the current shell. When you hit enter, you’ll be taken out of the terminal.\nSyntax:\$ exit"),
  Item(headervalue:  'mv',expandedvalue:"The mv command is one of the basic Linux commands that is used to move files and directories from one location to another. It is also used to rename files and directories. The mv command is by default available on all Linux distributions.\nSyntax:\$ mv file1 directory1"),
  Item(headervalue:  'cp',expandedvalue:"cp is a command-line utility for copying files and directories on Unix and Linux systems.\nSyntax:cp [OPTIONS] SOURCE... DESTINATION"),
  Item(headervalue:'which',expandedvalue:"To see where an executable resides in the file system, we use the which command. This displays the path of the executable that will be executed.\nSyntax:\$ which [EXEC]"),
  Item(headervalue:  'nano',expandedvalue:"The nano editor is a command-line, interactive editor that you can use to create and modify text files. The nano editor is also the only text editor that you can use to edit certain system files without changing the permissions of the files.\nSyntax:\$ nano options filename"),
  Item(headervalue:  'head',expandedvalue:"The Linux head command prints the first lines of one or more files (or piped data) to standard output. By default, it shows the first 10 lines. However, head provides several arguments you can use to modify the output.\nSyntax:head [option] file_name"),
  Item(headervalue:  'reboot',expandedvalue:" This command halts, powers off, or reboots a system.\nSyntax:\$reboot "),
  Item(headervalue:  'locate',expandedvalue:"The locate command is used to find a file and runs in the background, unlike the find command.\nSyntax:\$ locate file1.txt"),
  Item(headervalue:  'history',expandedvalue:"The history command in Linux is a built-in shell tool that displays a list of commands used in the terminal session. history allows users to reuse any listed command without retyping it.\nSyntax:history")



];