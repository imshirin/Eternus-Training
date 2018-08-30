/*Supportive class to check flag*/

public with sharing class CheckFlag {
    private static boolean flag = true;
    public static boolean Check(){
        if(flag) {
            flag=false;
            return true;
    }
        else {
            flag = true;
            return false;
        }
    }
}