import 'package:flutter/material.dart';
import 'main.dart';


class IntermediateCommands extends StatefulWidget {
  const IntermediateCommands({Key? key}) : super(key: key);
  @override
  IntermediateCommandsState createState() => IntermediateCommandsState();
}

class IntermediateCommandsState extends State<IntermediateCommands> {
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
                intermediateCommandData[index].isExpanded = !isExpanded;
                });
              },
            children: intermediateCommandData.map<ExpansionPanel>((Item item) {
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
  static const Color commdanTextColor = Color.fromARGB(255, 255, 251, 0);
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

List <Item> intermediateCommandData = [
  Item(headervalue:'--useradd',expandedvalue:"The useradd command creates a new user. The username is added after the useradd command, as follows:\n\nSyntax:\$ useradd John"),
  Item(headervalue: 'uniq',expandedvalue: "The uniq command in Linux is a command-line utility that reports or filters out the repeated lines in a file. In simple words, uniq is the tool that helps to detect the adjacent duplicate lines and also deletes the duplicate lines. uniq filters out the adjacent matching lines from the input file that is required as an argument and writes the filtered data to the output file.\n\nSyntax:\$uniq [OPTION] [INPUT[OUTPUT]] "),
  Item(headervalue: 'tar,',expandedvalue: "The Linux ‘tar’ stands for tape archive, is used to create Archive and extract the Archive files. tar command in Linux is one of the important command which provides archiving functionality in Linux. We can use Linux tar command to create compressed or uncompressed Archive files and also maintain and modify them.\n\n Syntax:tar [options] [archive-file] [file or directory to be archive"),
  Item(headervalue: 'alias',expandedvalue: "Let's say we're feeling lazy and want a way to navigate to another directory, as well as open a file within that directory.Rather than using cd to move to the folder, then opening with vim, we can shorten these two commands into one through aliasing.Before we choose a variable name to alias, we must make sure that the command is not already taken. Let's first check if shortcut has any function.\n\nSyntax:alias [option] [name]='[value]'"),
  Item(headervalue:  'apropos',expandedvalue: "If you're looking for a command, but not sure where to start looking, we can use apropos, which displays the appropriate commands.This searches all executables for your key term.\n\nSyntax:\$ apropos [COMMAND]"),
  Item(headervalue:  'sort',expandedvalue:"The pwd Linux command prints the current working directory path, starting from the root (/). Use the pwd command to find your way in the Linux file system structure maze or to pass the working directory in a Bash script..\n\nSyntax:pwd [-options]"),
  Item(headervalue:  'mount',expandedvalue:"Use this command to mount the filesystem of an external drive in your local file system. This will allow you to work with the files on the storage device.\n\nSyntax:sudo mount <partition_to_mount> <local_mounting_point>"),
  Item(headervalue:  'service',expandedvalue:"The service command can be used to manage services on your computer. It’s quite versatile in a way that you can start, stop, and restart a service as well as print details and a list of all available services on your computer. To print a list, use the following command:\n\nSyntax:service --status-all"),
  Item(headervalue: 'rmdir',expandedvalue:"rmdir command removes empty directories specified on the command line. These directories are removed from the filesystem in the same order as they are specified on the command line, i.e., from left to right. If the directory is not empty you get an error message.\n\nSyntax:\$ rmdir [OPTION]... DIRECTORY..."),
  Item(headervalue:  'wget',expandedvalue:"wget is a free utility for non-interactive download of files from the web. It supports HTTP, HTTPS, and FTP protocols, and retrieval through HTTP proxies.\n\nSyntax:wget [options] url"),
  Item(headervalue:  'ps / top',expandedvalue:"The ps / top commands allow you to list the processes running on your computer\n\nSyntax:ps - aux"),
  Item(headervalue:  'kill',expandedvalue:"The kill command is used to end a process, usually an unresponsive one. The kill command also includes the process ID or the program name, as shown here:\$ kill 522551"),
  Item(headervalue:'tree',expandedvalue:"As the name suggests, the tree command in Linux lists contents of directories in a tree-like format. \n\nSyntax:tree [OPTIONS] [directory]"),
  Item(headervalue:  'grep',expandedvalue:"Grep (global regular expression print) command is the most powerful and regularly used Linux command-line utility. Using Grep, you can search for useful information by specifying a search criteria. It searches for a particular expression pattern in a specified file. When it finds a match, it prints all the lines of a file that matched the specified pattern. It comes in handy when you have to filter through large log files.\n\nSyntax:\$ grep [options] PATTERN [FILE...]"),
  Item(headervalue:  'chown',expandedvalue:"This command is used to change the ownership of a file/folder or even multiple files/folders for a specified user/group.\n\nSyntax:\$ chmod 744 script.sh"),
  Item(headervalue:  'apt–get',expandedvalue:"apt -get is a powerful and free front-end package manager for Debian/Ubuntu systems. It is used to install new software packages, remove available software packages, upgrade existing software packages as well as upgrade the entire operating system. apt – stands for advanced packaging tool.\n\nSyntax:\$ sudo apt-get update"),
  Item(headervalue:  'tail',expandedvalue:"Linux tail command is used to display the last ten lines of one or more files. Its main purpose is to read the error message. By default, it displays the last ten lines of a file. Additionally, it is used to monitor the file changes in real-time. It is a complementary command of the head command.\n\nSyntax:tail <file name> "),
  Item(headervalue:  'wc',expandedvalue:"On Linux and Unix-like operating systems, the wc command allows you to count the number of lines, words, characters, and bytes of each given file or standard input and print the result.\n\nSyntax:wc OPTION... [FILE]..."),
  Item(headervalue:  'whatis',expandedvalue:"whatis command in Linux is used to get a one-line manual page descriptions. In Linux, each manual page has some sort of description within it. So this command search for the manual pages names and show the manual page description of the specified filename or argument.\nSyntax:whatis [-dlv?V] [-r|-w] [-s list] [-m system[, …]] [-M path] [-L locale] [-C file] name …")



];