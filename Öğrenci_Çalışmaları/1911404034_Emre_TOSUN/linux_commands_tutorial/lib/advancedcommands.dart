import 'package:flutter/material.dart';
import 'main.dart';


class AdvancedCommands extends StatefulWidget {
  const AdvancedCommands({Key? key}) : super(key: key);
  @override
  AdvancedCommandsState createState() => AdvancedCommandsState();
}

class AdvancedCommandsState extends State<AdvancedCommands> {
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
                advancedCommandData[index].isExpanded = !isExpanded;
                });
              },
            children: advancedCommandData.map<ExpansionPanel>((Item item) {
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
  static const Color commdanTextColor = Color.fromARGB(255, 255, 0, 0);
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

  List <Item> advancedCommandData = [
  Item(headervalue:'free',expandedvalue: "In Linux systems, you can use the free command to get a detailed report on the system’s memory usage.The free command provides information about the total amount of the physical and swap memory, as well as the free and used memory.\nSyntax:free [OPTIONS]"),
  Item(headervalue: 'passwd',expandedvalue: "passwd command in Linux is used to change the user account passwords. The root user reserves the privilege to change the password for any user on the system, while a normal user can only change the account password for his or her own account.\nSyntax: passwd [options] [username]"),
  Item(headervalue: 'paste,',expandedvalue: "Paste command is one of the useful commands in Unix or Linux operating system. It is used to join files horizontally (parallel merging) by outputting lines consisting of lines from each file specified, separated by tab as delimiter, to the standard output. When no file is specified, or put dash (“-“) instead of file name, paste reads from standard input and gives output as it is until a interrupt command [Ctrl-c] is given.\nSyntax:paste [OPTION]... [FILES]..."),
  Item(headervalue: 'su',expandedvalue: "The su (short for substitute or switch user) utility allows you to run commands with another user’s privileges, by default the root user.\nSyntax:su [OPTIONS] [USER [ARGUMENT...]]"),
  Item(headervalue:  'diff',expandedvalue:"The diff command compares two files line by line to find differences. The output will be the lines that are different.\$ diff file1.txt file2.txt"),
  Item(headervalue:  'rsync',expandedvalue: "rsync or remote synchronization is a software utility for Unix-Like systems that efficiently sync files and directories between two hosts or machines. One of them being the source or the local-host from which the files will be synced, the other one being the remote-host, on which synchronization will take place.\nSyntax:rsync [options] source [destination]"),
  Item(headervalue:  'export',expandedvalue:"export is bash shell BUILTINS commands, which means it is part of the shell. It marks an environment variables to be exported to child-processes.Export is defined in POSIX as The shell shall give the export attribute to the variables corresponding to the specified names, which shall cause them to be in the environment of subsequently executed commands. If the name of a variable is followed by = word, then the value of that variable shall be set to the word.\nSyntax:export [-f] [-n] [name[=value] ...] or export -p"),
  Item(headervalue:  'systemctl',expandedvalue:"The shutdown command in Linux is used to shutdown the system in a safe way. You can shutdown the machine immediately, or schedule a shutdown using 24 hour format.It brings the system down in a secure way. When the shutdown is initiated, all logged-in users and processes are notified that the system is going down, and no further logins are allowed.Only root user can execute shutdown command.\nSyntax:shutdown [OPTIONS] [TIME] [MESSAGE]"),
  Item(headervalue:  'shutdown',expandedvalue:"The rm command in Linux OS is used to remove files and directories from the command line. However, the removed files and directories do not get moved to the Trash. Instead, the rm command removes the files and directories permanently.\nSyntax:\$ rm [option]... [file]..."),
  Item(headervalue: 'ssh',expandedvalue:"ssh stands for “Secure Shell”. It is a protocol used to securely connect to a remote server/system. ssh is secure in the sense that it transfers the data in encrypted form between the host and the client. It transfers inputs from the client to the host and relays back the output. ssh runs at TCP/IP port 22.\nSyntax:ssh user_name@host(IP/Domain_name)"),
  Item(headervalue:  'ifconfig',expandedvalue:"ifconfig is used to configure the kernel-resident network interfaces. It is used at boot time to set up interfaces as necessary. After that, it is usually only needed when debugging or when system tuning is needed.\nSyntax:[USER ~]\$ ifconfig "),
  Item(headervalue:  'netstat',expandedvalue:"Netstat is a command-line tool used by system administrators to evaluate network configuration and activity. The term Netstat is results from network and statistics. It shows open ports on the host device and their corresponding addresses, the routing table, and masquerade connections.\nSyntax# netstat [OPTION]"),
  Item(headervalue:  'nslookup',expandedvalue:"A network utility program used to obtain information about Internet servers. As its name suggests, the utility finds name server information for domains by querying DNS.\nSyntax:nslookup [option]"),
  Item(headervalue:'dig',expandedvalue:"dig is a tool for querying DNS nameservers for information about host addresses, mail exchanges, nameservers, and related information. This tool can be used from any Linux (Unix) or Macintosh OS X operating system. The most typical use of dig is to simply query a single host.\nSyntax:dig [server] [name] [type]"),
  Item(headervalue:  'uptime',expandedvalue:"Uptime Command In Linux: It is used to find out how long the system is active (running). This command returns set of values that involve, the current time, and the amount of time system is in running state, number of users currently logged into, and the load time for the past 1, 5 and 15 minutes respectively.\nSyntax: uptime [-options]"),
  Item(headervalue:  'wall',expandedvalue:"wall command in Linux system is used to write a message to all users. This command displays a message, or the contents of a file, or otherwise its standard input, on the terminals of all currently logged in users. The lines which will be longer than 79 characters, wrapped by this command. Short lines are whitespace padded to have 79 characters. A carriage return and newline at the end of each line is put by wall command always. Only the superuser can write on the terminals of users who have chosen to deny messages or are using a program which automatically denies messages. Reading from a file is refused when the invoker is not superuser and the program is suid(set-user-ID) or sgid(set-group-ID).\nSyntax: wall [-n] [-t timeout] [message | file]"),
  Item(headervalue:  'write',expandedvalue:"write command in Linux is used to send a message to another user. The write utility allows a user to communicate with other users, by copying lines from one user’s terminal to others.\nSyntax:write user [tty]"),
  Item(headervalue:  'awk',expandedvalue:"Awk is a scripting language used for manipulating data and generating reports. The awk command programming language requires no compiling and allows the user to use variables, numeric functions, string functions, and logical operators. Awk is a utility that enables a programmer to write tiny but effective programs in the form of statements that define text patterns that are to be searched for in each line of a document and the action that is to be taken when a match is found within a line. Awk is mostly used for pattern scanning and processing. It searches one or more files to see if they contain lines that matches with the specified patterns and then perform the associated actions.\n Syntax:awk options 'selection _criteria {action }' input-file > output-file "),
  Item(headervalue:  'split',expandedvalue:"Split command in Linux is used to split large files into smaller files. It splits the files into 1000 lines per file(by default) and even allows users to change the number of lines as per requirement.\nSyntax:split [options] name_of_file prefix_for_new_files "),
  Item(headervalue:  'traceroute',expandedvalue:"traceroute command in Linux prints the route that a packet takes to reach the host. This command is useful when you want to know about the route and about all the hops that a packet takes.\nSyntax:traceroute [options]  host_Address [pathlength] "),



];