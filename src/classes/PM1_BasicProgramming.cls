public with sharing class PM1_BasicProgramming {
    
    /*method to test even odd number*/
    
    public void testingEvenOddNumber( Integer firstNumber) {
        Integer secondNumber, result;
        if(firstNumber == 0)
            System.debug('0 is neither even nor odd number');
        else 
        {
            result = Math.mod(firstNumber,2);
            if(result == 0)
                System.debug('number is even');
            else 
                System.debug('Number is odd&&&&');  
        }
        
    }
}