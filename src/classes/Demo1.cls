public with sharing class Demo1 {
  
    private static boolean run = true;
    
    public static boolean runOnce1(){
    if(run){
     run=false;
     return true;
    }else{
        return run;
    }
    }
}