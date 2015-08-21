global class batchDeleteDupATLs implements Database.Batchable<sObject> {
   global batchDeleteDupATLs (){
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, External_Id_vod__c, Account_vod__c FROM Account_Territory_Loader_vod__c';
        return Database.getQueryLocator(query);
   }

    global void execute(Database.BatchableContext BC, List<Account_Territory_Loader_vod__c> scope){
        //process only if scope is not empty
        if(!scope.IsEmpty()) {
            //Step 1. Identify bad ATL records and add them to Delete queue
            List<Account_Territory_Loader_vod__c> atlToDelete = new List<Account_Territory_Loader_vod__c>();
            for(Account_Territory_Loader_vod__c atl : scope) {
                if(atl.Account_vod__c != atl.External_Id_vod__c) {
                    atlToDelete.add(atl);
                    system.debug('Deleting ATL record for Account: ' + atl.account_vod__c);
                }
            }//end for

            //Step 2. If there are ATLs to Delete then delete them
            if(!atlToDelete.IsEmpty()) {
                delete atlToDelete;
            }
        } //end if scope!Empty
    } //end execute method

   global void finish(Database.BatchableContext BC){
   }

    static testMethod void xxx () {
        Test.startTest() ;
        database.executeBatch(new batchDeleteDupATLs ());
        Test.stopTest() ;

    }
}
