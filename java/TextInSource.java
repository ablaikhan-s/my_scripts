import java.util.Arrays;
import java.util.Scanner;

public class TextInSource{
	public static void main(String[] args){
		Scanner input = new Scanner(System.in);
		System.out.print("Input source text: ");
		String source = input.nextLine();
		System.out.print("Input another text: ");
		String text = input.nextLine();
		
		int lenSrc = source.length();
		int lenText = text.length();
		char[] arrSrc = new char[lenSrc];
		char[] arrText = new char[lenText];
		for ( int i = 0; i < lenSrc; i++) { 
			arrSrc[i] = source.charAt(i); }
		for ( int i = 0; i < lenText; i++) { 
			arrText[i] = text.charAt(i); }
		System.out.println("Your \'source\' text: " + source);
		System.out.println("Your second text: " + text);
		System.out.println("working...");
		System.out.println(arrSrc);
		System.out.println(arrText);

		int x = (lenSrc - lenText) +1 ;
		
		if (lenSrc == 0 || lenText == 0 ){
			System.out.print("Error occured! Check \'source\' and \'text\'!");
		} else {
			for ( int i = 0; i < x; i++ ){ 
				boolean isEqual = Arrays.equals(Arrays.copyOfRange(arrSrc, i, i+lenText), arrText);
				if (isEqual == true)
				{
					System.out.println("OK. Start index: " + i);
				}
			}
		}	
	}
}