import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Random;

public class TMachineCode {
	public static void main(String[] args) throws FileNotFoundException {
		//resource code address
		String resource = "C:\\Users\\qqwil\\Desktop\\HW\\cse132\\CSE132A PA2\\src\\source.txt";
		//output code address
		String output = "C:\\Users\\qqwil\\Desktop\\HW\\cse132\\CSE132A PA2\\src\\test.txt";
		
		
		//start comment here if use random generate
		try (BufferedReader br = Files.newBufferedReader(
				Paths.get(resource))) {//resource code address

			// read line by line
			String line; //line to read
			String writein; //buffer line to write
			PrintStream fileStream = new PrintStream(new File(output));
			while ((line = br.readLine()) != null) {
				//line is the current line of code
				writein = "";// refresh the write in data
				//start remove comment
				if(line.contains("/")) {
					int end = line.indexOf("/");
					line = line.substring(0, end);
				}
				//done
				if(line.isEmpty()) {//writein when not empty(comment line
					continue;//skip this one
				}
				
				//start getting op machine code
				int opindex = line.indexOf(" ");	
				String op = line.substring(0, opindex);
				if(op.contains("load")) {
					writein ="000";
				}
				if(op.contains("store")) {
					writein ="001";
				}
				if(op.contains("xor")) {
					writein ="010";
				}
				if(op.contains("add")) {
					writein ="011";
				}
				if(op.contains("shl")) {
					writein ="100";
				}
				if(op.contains("shr")) {
					writein ="101";
				}
				if(op.contains("bnez")) {
					writein ="110";
				}
				if(op.contains("bez")) {
					writein ="111";
				}
				//done
				//start getting first arg
				line = line.substring(opindex+1);
				int argindex = line.indexOf(",");
				String tmparg = line.substring(0, argindex);
				if(tmparg.contains("R")) {
					tmparg = tmparg.substring(1);//remove R
				}
				int tmpv = Integer.parseInt(tmparg);
				if(tmpv == 8) {
					tmpv = 0;
				}
				writein = writein + intToString(tmpv, 3);//convert to string then makesure is 3 bit
				//done
				//get the begin index of arg2
				line = line.substring(argindex+1);//skip the " " and " "
				while(line.charAt(0) == ' ') {
					line = line.substring(1);
				}
				//start getting arg2
				if(line.contains(" ")) {
					line = line.substring(0, line.indexOf(" "));
				}
				tmparg = line;
				if(tmparg.contains("R")) {
					tmparg = tmparg.substring(1);//remove R
				}
				tmpv = Integer.parseInt(tmparg);
				if(tmpv == 8) {
					tmpv = 0;
				}
				writein = writein + intToString(tmpv, 3);//convert to string then makesure is 3 bit
				//done
				fileStream.println(writein);
			}
		} catch (IOException e) {
			System.err.format("IOException: %s%n", e);
		}
		//end comment here if use random generate
		
		
//		//random generator
//		//number of line you want
//		int n = 10;
//		PrintStream fileStream = new PrintStream(new File(output));
//		for(int i = 0; i < n ; i++ ) {
//			Random rg = new Random();
//			int buffer = rg.nextInt(255);
//			fileStream.println(intToString(buffer, 9));
//		}
//		//end of random generator
		
		
	}
	
	//use to fill out the for enought bit
	static String intToString(int input, int size) {//first arg is integer to convert, second is number of bit for this string
		String result = Integer.toBinaryString(input);
		if(result.length()<size) {
			int rest = size - result.length();
			for(int i = 0 ; i < rest ; i++) {
				result = "0" + result;
			}
		}
		return result;	
	}

}
