public with sharing class ECS_8_ConstructorDemo {
    public ECS_8_ConstructorDemo(){
        system.debug('Constructor is instantiated');
    }
    
    /*method which will accept following parameters & return the result :
    Parameter: String : (Value here will be any of the following :
    ‘SUM’,’SUB’,’MUL’,’DIV’)
    Parameter: Two integers :
    Example :
    Integer result = Calculator(‘SUM’, 2 ,3);
    result = 5*/

    
    Public integer calculator(String operation, Integer inp1 , Integer Inp2)
    {
        Integer result;
        if(operation == 'SUM')
            result = (inp1 + inp2);
            
        else if(operation == 'SUB')
             result = (inp1 - inp2);
            
        else if(operation == 'MUL')
             result = (inp1 * inp2);
            
        else if(operation == 'DIV')
              result = (inp1 / inp2);
        
        return(result);
    }
    
    
}