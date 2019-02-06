//Name: Jonathan Brotherton
//Class: ApexP0Exercises
//Description: Odds and Ends methods done to show that I can write code :-) Note: Did not specify if I could do it well
//Date: 2/6/2019
public class ApexP0Exercises {
        //gathers the nth fibonacci number
        public static Integer nFibonacci( Integer n){
            integer i = 0;
            integer num = 0;
            integer numtwo = 1;
            //cases for 0 and 1, while loop to move around the numbers till we get the number.
            while(i < n){
               integer sumOfBoth = num + numtwo;
               num = numtwo;
               numtwo = sumOfBoth;
               i++;
            }
            system.debug('Input: ' + n + '\t' + 'Output: ' + num);
            return num;
        }
        //sorts an array from smallest number to biggest number
        public static Integer[] sortArray( Integer[] intList ) {
            integer testnum;
            //nested for loop to sort, pretty bad optimization btu it works
            for(integer i= 0; i < intList.size(); i++){
                for(integer j= i + 1; j < intList.size(); j++){
                    if(intList[j] < intList[i]){
                        testnum = intList[i];
                        intList[i] = intList[j];
                        intList[j] = testnum;
                    }
                }
            }
            system.debug(intList);
            return intList;
        }
    //gets the factorial of a given integer input
    public static Integer nFactorial( Integer n){
        integer sum = 0;
        //recursive call to get numbers until 0
        if((n-1) >= 0){
            return sum + n + nFactorial(n-1);
        }
        else{
            return sum;
        }
    }
    //rotates an array of integers n times to the left
    public static Integer[] rotateLeftNTimes( Integer[] arrayy, Integer n){
        //gets the size of the array to mod in the case of numbers larger than array length
        integer size = arrayy.size();
        n = Math.mod(n, size);
        //for loop to rotate numbers
        for(Integer i = 0; i < n; i++){
            Integer placeholder0 = arrayy[i];
            arrayy[i] = arrayy[(i + 1)];
            for(integer j = size-1; j > i; j--){
                integer mover = arrayy[j];
                arrayy[j] = placeholder0;
                placeholder0 = mover;
            }
        }
        return arrayy;
    }
    //boolean check that makes sure the brackets are balanced
    public static Boolean bracketsAreBalanced(String s){
        //split string parameter into list based off of each separate character
        List<String> stringtolist = s.split('');
        Integer i = 0;
        //mod check to make sure it's an even length
        if ( Math.mod(stringtolist.size(), 2) == 1){
            return False;
        }
        //recursive calls to check equality
        while(i < s.length()){
            string beginning = s.substring(0,1);
            string ending = s.substring(s.length()- 1);
            s = s.substring(1,s.length()-1);
            if(beginning == '[' && ending == ']'){
                bracketsAreBalanced(s);
            }
            else if(beginning == '{' && ending == '}'){
                bracketsAreBalanced(s);
            }
            else if(beginning == '(' && ending == ')'){
                bracketsAreBalanced(s);
            }
            else{
                return false;
            }
        }
        return true;
    }
    //updates Account Size field based on how many employees are in the company
    public static void updateAccountSize(){
        List<Account> accounts = new List<Account>();
        //all accounts in Account- could simplify this to make it pull less
        for(Account a:[SELECT Id, Size__c, NumberOfEmployees FROM Account]){
            Integer employees = a.NumberOfEmployees;
            //could do a switch statement here maybe- but big if else to determine the size of accounts
            if(employees == 0 || employees == NULL){
                system.debug('no employees');
                accounts.add(a);
            }
            else if(employees > 0 && employees <= 1000){
                a.Size__c = 'Small';
                accounts.add(a);
            }
            else if(employees > 1000 && employees <= 10000){
                a.Size__c = 'Medium';
                accounts.add(a);
            }
            else{
                a.Size__c = 'Large';
                accounts.add(a);
            }       
        }
        update accounts;
    }
    //updates all leads that are in the state of California
    public static void updateCALeads(){
        //List is updated with all California based leads
        List<Lead> caleadsupdate = new List<Lead>();
        for(Lead l:[SELECT Id, Status, Description FROM Lead WHERE state='CA']){
            l.Status = 'Closed - Not Converted';
            l.Description = 'We are no longer doing business in California.';
            caleadsupdate.add(l);
        }
        update caleadsupdate;
    }
    //finds any list that is passed due, sets the stage name appropriately.
    public static void closePastDueOpportunities(){
        List<Opportunity> closedops = new List<Opportunity>();
        for(Opportunity o:[SELECT Id, StageName, CloseDate FROM Opportunity WHERE StageName != 'Closed Won']){
            if(o.CloseDate < date.today()){
                    o.StageName = 'Closed Lost';
                    closedops.add(o);
            }
        }
        update(closedops);
    }
    
}