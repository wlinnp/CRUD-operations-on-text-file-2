#! /usr/bin/perl
use warnings;
use strict;

my $phoneDB="datebook"; # save name


# check file exist. if not leave program
if ( ! -f "$phoneDB" )
{
    print "Database file not found. exiting. bye bye. \n";
    exit;
}
sub insertRecord
{
    print "Please enter your mobile phone number: \n";
    my $ph=<STDIN>;
    chomp ($ph);
    while ( 1 )
    {
        while ( 1 )
        {
            if ( $ph =~ /^[0-9]{10}$/ )
            {
                last;
            }
            else
            {
                print "Invalid format. phone should contain 10 digits 0 to 9. enter again. \n";
                $ph = <STDIN>;# get mobile phone number
                chomp($ph);
            }
        }
        $ph= substr( $ph, 0, 3)."-".substr( $ph, 3,3)."-".substr( $ph, 6, 4);
        my $res=`awk -F: -v var="$ph" '{if (\$3 ~ var ) {print "yes";}}' "$phoneDB" `;
        if ( $res =~ /yes/ )
        {
            print "phone number exists. enter again. \n";
            $ph = <STDIN>;# get mobile phone number
            chomp($ph);
        }
        else
        {
            last;
        }
    }
	print "You entered ".$ph."\n";
	#--------------------------
	print "Please enter your first name:\n";
	my $fName=<STDIN>;
    chomp ($fName);
	while ( 1 )
	{
		if ( $fName =~ /^[A-Z][a-z]+$/  )
		{
			last;
		}
		else
		{
			print "Invalid format. first name should contain only alphabets. enter again. \n";
			$fName=<STDIN>;
			chomp ($fName);
		}
	}
	print "You entered ".$fName."\n";
	#--------------------------
	print "Please enter your last name:\n";
	my $lName=<STDIN>;
    chomp ($lName);
	while ( 1 )
	{
		if ( $lName =~ /^[A-Z][a-z]+$/  )
		{
			last;
		}
		else
		{
			print "Invalid format. last name should contain only alphabets. enter again. \n";
			$lName=<STDIN>;
			chomp ($lName);
		}
	}
	print "You entered ".$lName."\n";
	#--------------------------
	print "Please enter your homephone:\n";
	my $phHm=<STDIN>;
    chomp ($phHm);
	while ( 1 )
	{
		if ( $phHm =~ /^[0-9]{10}$/  )
		{
			last;
		}
		else
		{
			print "Invalid format. phone should contain 10 digits 0 to 9. enter again. \n";
			$phHm=<STDIN>;
			chomp ($phHm);
		}
	}
	$phHm= substr( $phHm, 0, 3)."-".substr( $phHm, 3,3)."-".substr( $phHm, 6, 4);
	print "You entered ".$phHm."\n";
	#--------------------------
	print "Please enter your address w/o ZIPcode:(NOTE: no validation. type the correct format. ( Address: Street address, City, State) )  \n";
	my $address=<STDIN>;
    chomp ($address);
	#--------------------------
	print "Please enter your zipcode:\n";
	my $zip=<STDIN>;
    chomp ($zip);
	while ( 1 )
	{
		if ( $zip =~ /^[0-9]{5}$/  )
		{
			last;
		}
		else
		{
			print "Invalid format. zipcode should contain 5 digits 0 to 9. enter again. \n";
			$zip=<STDIN>;
			chomp ($zip);
		}
	}
	print "You entered ".$zip."\n";
	#--------------------------
	print "Please enter your birthday: (NOTE: no validation. type the correct format. (MM/DD/YYYY) ) \n";
	my $birthday=<STDIN>;
    chomp ($birthday);
	#--------------------------
	print "Please enter your salary:\n";
	my $salary=<STDIN>;
    chomp ($salary);
	while ( 1 )
	{
		if ( $salary =~ /^[0-9]{1,}$/  )
		{
			last;
		}
		else
		{
			print "Invalid format. salary should contain only digits. enter again. \n";
			$salary=<STDIN>;
			chomp ($salary);
		}
	}
	print "You entered ".$salary."\n";
	#--------------------------
	my $newRecord=$fName." ".$lName.":".$phHm.":".$ph.":".$address." ".$zip.":".$birthday.":".$salary;
	print "Record to be inserted: ".$newRecord."\n";
	print " ==============================\n";
	my $inCmd="echo $newRecord >> $phoneDB";
	system($inCmd);
	# sorting
	my @cmd = ("touch", "temp");
	system(@cmd);
	my @cmd1 = ("sort", "-t", " ", "-k1d","-o", "temp", "$phoneDB");
	system(@cmd1);
	my @cmd2 = ("cp","temp","$phoneDB");
	system(@cmd2);
	my @cmd3 = ("rm", "temp");
	system(@cmd3);
	my @cmd4=("cat","$phoneDB");
	system(@cmd4);
}

# infinite loop for menu
while ( 1 )
{
	print "1 for Listing of records in alphabetical order of first name\n";
	print "2 for Listing of records in alphabetical order of last name\n";
	print "3 for Listing of records in reverse alphabetical order of first name\n";
	print "4 for Listing of records in reverse alphabetical order of last name\n";
	print "5 for Search for a record by Last Name\n";
	print "6 for Search for a record by birthday in a given year\n";
	print "7 for Search for a record by birthday in a given month\n";
	print "8 for Delete for a record by Last Name\n";
	print "9 for Delete for a record by Phone Number\n";
	print "10 for Insert a record\n";
	print "0 for exit\n";
	my $option=<STDIN>;# get input
	chomp($option);# remove "enter key"

	# redirect options
	if ( $option == 1 )
	{
		print "Listing of records in alphabetical order of first name\n";
		print "------------------------------------------------------\n";
		my @cmd = ("touch", "temp");
		system(@cmd);
		my @cmd1 = ("sort", "-t", " ", "-k1d","-o", "temp", "$phoneDB");
		system(@cmd1);
		my @cmd2 = ("cp","temp","$phoneDB");
		system(@cmd2);
		my @cmd3 = ("rm", "temp");
		system(@cmd3);
		my @cmd4=("cat","$phoneDB");
		system(@cmd4);
	}
	elsif ( $option == 2 )
	{
		print "Listing of records in alphabetical order of last name\n";
		print "------------------------------------------------------\n";
		my @cmd = ("touch", "temp");
		system(@cmd);
		my @cmd1 = ("sort", "-t", " ", "-k2d","-o", "temp", "$phoneDB");
		system(@cmd1);
		my @cmd2 = ("cp","temp","$phoneDB");
		system(@cmd2);
		my @cmd3 = ("rm", "temp");
		system(@cmd3);
		my @cmd4=("cat","$phoneDB");
		system(@cmd4);
	}
	elsif ( $option == 3 )
	{
		print "Listing of records in reverse alphabetical order of first name\n";
		print "--------------------------------------------------------------\n";
		my @cmd = ("touch", "temp");
		system(@cmd);
		my @cmd1 = ("sort", "-t", " ", "-k1dr","-o", "temp", "$phoneDB");
		system(@cmd1);
		my @cmd2 = ("cp","temp","$phoneDB");
		system(@cmd2);
		my @cmd3 = ("rm", "temp");
		system(@cmd3);
		my @cmd4=("cat","$phoneDB");
		system(@cmd4);
	}
	elsif ( $option == 4 )
	{
		print "Listing of records in reverse alphabetical order of last name\n";
		print "-------------------------------------------------------------\n";
		my @cmd = ("touch", "temp");
		system(@cmd);
		my @cmd1 = ("sort", "-t", " ", "-k2dr","-o", "temp", "$phoneDB");
		system(@cmd1);
		my @cmd2 = ("cp","temp","$phoneDB");
		system(@cmd2);
		my @cmd3 = ("rm", "temp");
		system(@cmd3);
		my @cmd4=("cat","$phoneDB");
		system(@cmd4);
	}
	elsif ( $option == 5 )
	{
		print "Search for a record by Last Name\n";
		print "--------------------------------\n";
		print "Enter the last name you want to search: \n";
		my $lName = <STDIN>; # get last name
		chomp($lName);
		my @cmd = ("awk", "-v", "var=$lName", "-F", "[ :]", "{if(\$2 ~ var) {print;} }", "$phoneDB");
		system(@cmd);
	}
	elsif ( $option == 6 )
	{
		print "Search for a record by birthday in a given year\n";
		print "-----------------------------------------------\n";
		print "Enter the year you want to search: \n";
		my $year =  <STDIN>; # get year
		chomp($year);
		my @cmd = ("awk", "-v", "var=$year", "-F", "[:/]", "{if(\$7 == var) {print;} }", "$phoneDB");
		system(@cmd);
	}
	elsif ( $option == 7 )
	{
		print "Search for a record by birthday in a given month\n";
		print "------------------------------------------------\n";
		print "Enter the year you want to search: \n";
		my $month =  <STDIN>; # get year
		chomp($month);
		my @cmd = ("awk", "-v", "var=$month", "-F", "[:/]", "{if(\$5 == var) {print;} }", "$phoneDB");
		system(@cmd);
	}
	elsif ( $option == 8 )
	{
		print "Delete for a record by Last Name\n";
		print "--------------------------------\n";
		print "Enter the last name you want to delete: \n";
		my $lName = <STDIN>;# get last name
		chomp($lName);
		print "Records with last name: $lName\n";
		my @cmd = ("awk", "-v", "var=$lName", "-F", "[ :]", "{if(\$2 ~ var) {print;} }", "$phoneDB");
		system(@cmd);
		print "deleting them. New database file\n";
		print "--------------------------------\n";
		my $cmd1="touch temp; awk -v var=$lName -F'[: ]' '{if (\$2 !~ var) {print;} }' $phoneDB >> temp; cp temp $phoneDB; rm temp; cat $phoneDB;";
		system($cmd1);
	}
	elsif ( $option == 9 )
	{
		print "Delete for a record by Phone Number\n";
		print "-----------------------------------\n";
		print "Enter the mobile phone number you want to delete: (10 digit without dashes or parenthesis) \n";
		my $ph = <STDIN>;# get mobile phone number
		chomp($ph);
		while ( 1 )
		{
			if ( $ph =~ /^[0-9]{10}$/ )
			{
				last;
			}
			else
			{
				print "Invalid format. phone should contain 10 digits 0 to 9. enter again. \n";
				$ph = <STDIN>;# get mobile phone number
				chomp($ph);
			}
		}
		$ph= substr( $ph, 0, 3)."-".substr( $ph, 3,3)."-".substr( $ph, 6, 4);


		print "Records with mobile phone number: $ph\n";
		my @cmd = ("awk", "-v", "var=$ph", "-F", "[:]", "{if(\$3 ~ var) {print;} }", "$phoneDB");
		system(@cmd);
		print "deleting them. New database file\n";
		print "--------------------------------\n";
		my $cmd1="touch temp; awk -v var=$ph -F'[:]' '{if (\$3 !~ var) {print;} }' $phoneDB >> temp; cp temp $phoneDB; rm temp; cat $phoneDB;";
		system($cmd1);
	}
	elsif ( $option == 10 )
	{
		insertRecord;
	}
	elsif ( $option == 0 )
	{
		print "Exiting the program. Bye bye\n";
		last;
	}
	else
	{
		print "Invalid option\n";
	}
}

