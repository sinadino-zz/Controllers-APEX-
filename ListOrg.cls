Public class listorgs
    implements iterator<org__c>{
        public static List<org__c> newlist {get; set;}
        Integer i {get; set;}

        public listorgs(){
            newlist = [select id, name from org__c];
            i = 0;
                }
        Public boolean hasnext(){
            if(i>= newlist.size()){
                return false;
            } else {
                return true;
            }
        }
        Public Org__c next(){
            if(i==100){return null;}
            i++;
            return newlist[i-1];
        }
}

    
