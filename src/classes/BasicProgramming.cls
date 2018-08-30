public with sharing class BasicProgramming {

    public static string testingEvenOddNumber( Integer firstNumber) {
        Integer secondNumber, result;
        if(firstNumber == 0)
            return('0 is neither even nor odd number');
        else 
        {
            result = Math.mod(firstNumber,2);
            if(result == 0)
                return ('even');
            else 
                return ('odd');
          }
        
        }
        
        
    public static Integer [] creatingArray(Integer indexVal)
    {   
        // = 4;
        Integer [] arrayVal=new Integer[indexVal];
        for(Integer index = 0; index < indexVal; index++)
            arrayVal[index] = index;
        for (Integer i : arrayVal) 
        {
            System.debug(i+1);
        }
        return arrayVal;
    }    
    
    
    public void passingArray(List<Integer> inputArray) {
        Integer size, min, max;
        size = inputArray.size();
        for (Integer index : inputArray) {
            System.debug('value'+index);
        }
        
       
        //sorting array in ascending order
            
        inputArray.sort();
        for (Integer index : inputArray) {
            System.debug('ac'+index);
        }
            
        //sorting array in descending order
        
        size = inputArray.size();
        List <Integer>descArray = new List<Integer>();
        for(Integer ascVal = size-1; ascVal >= 0; ascVal--)
        {
            descArray.add(inputArray[ascVal]);
            system.debug('#####'+inputArray[ascVal]);
        }
        for (Integer index : descArray) {
            System.debug('dc'+index);
        }
        //Print the Maximum number in the array
        
    system.debug('min ='+ inputArray.get(0));
    
    //Print the Minimum number in the array
    
    //system.debug('max ='+ descArray.get(0));
    
    
    }
        
    //Print duplicates and its occurrences in the array
    
    public void countOccurences(List<Integer> inputArray) 
    {   
         Integer size = inputArray.size();  
         for (Integer outer1 = 0; outer1 < size; outer1++) {
            Integer countvar = 1, flag = 0;
            Integer test = inputArray[outer1];
             
             for (Integer check = 0; check < outer1; check++) {
                if (inputArray[check] == test)
                flag = 1;
             }
             
             if(flag == 1)
                break;
             
             else
             {
                for (Integer inner1 = outer1 + 1; inner1 < size; inner1++) {
                    if (test == inputArray[inner1])
                    countvar++;
             }
            }

            system.debug(test+' = '+countvar);
            
         }
         
       
}

        //Method to display the summation of numbers from zero to parameter number

        public void calculateSummationofNumber(Integer input)
        {
            system.debug('Summation of numbers from 0 to '+input+' = '+(input*(input+1)/2));
        }



       //Method which will calculate the simple interest


         public void calculateSimpleInterest(Decimal principalAmount, Decimal numberofYears, Decimal rateofInterest)
         {
              system.debug('Total Interest = '+(principalAmount*numberofYears*rateofInterest)/100); 
         }
         
  }