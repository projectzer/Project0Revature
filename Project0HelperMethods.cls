//Name:Jonathan Brotherton
//Description: Helper methods for project 0
//class: Project0HelperMethods
//Date: 2/6/2019
public class Project0HelperMethods {
    //check if account is overdrawn, change status of account accordingly
    public static void accountStatus(String accName){
        Account a;
        //only gets matching account to the account name. Could have used an Account parameter, but calling it within the execution black seemed daunting.
        a = [Select Id, Status__c, Total_Balance__c from Account WHERE Name = :accName];
        if(a.Total_Balance__c < 0){
            a.Status__c = 'Overdrawn';
            update a;
        }
    }

//create a new transaction relating to the account
//accName-account name to add the money
//bigmoney is that big money to add
    public static void newTransaction(String accName, decimal bigmoney){
        Account a = [Select Id, Name FROM Account WHERE Name = :accName];
        Transaction__c t = new Transaction__c(Account_Transactions__c = a.id, Transaction_Type__c = 'Loan', Transaction_Amount__c = bigmoney);
        insert t;
    }
//update the account based on all related transactions to show current balance
    public static void updateBalance(String accName){
        decimal total = 0;
        Account a = [Select Id, Name FROM Account WHERE Name = :accName];
        ID aid = a.Id;
        //confusing wordage- for each transaction in my transactions where the account id is the same, update the total_balance field of my account
        for(Transaction__c t: [SELECT Account_Transactions__c, Transaction_Amount__c FROM Transaction__c WHERE Account_Transactions__c = :aid]){
             total += t.Transaction_Amount__c;
        }
        a.Total_Balance__c = total;
        update a;        
    }
}