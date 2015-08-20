global class BatchDemo {
 // instantiate Batch_Prep__c
	public Batch_Prep__c batchPrep {get; private set;}

	public String selectedBatch {get; set;}
// method invokation
	public BatchDemo() {

		if(ApexPages.CurrentPage().getParameters().containsKey('bpid')) {
			selectedBatch = ApexPages.CurrentPage().getParameters().get('bpid');
		}

	}
// action definition
	public List<SObject> getBatchOptions() {

		List<SObject> opts = new List<SObject>();
// loading the batch and storing at opts list
		for(Batch_Prep__c bp : [SELECT Id, Name, Status__c, Start_Time__c, End_Time__c FROM Batch_Prep__c WHERE Status__c = 'Complete']) {
			opts.add(new SObject(bp.Id, bp.Name));
		}

		return opts;

	}
// getter definition and returns filtered by id :selectedBatch
	public Batch_Prep__c getBatch() {

		if(selectedBatch != null) {
			return [SELECT Id, Name, Batch_Job_Id__c, Start_Time__c, End_Time__c, Results__c,
					(SELECT Id, Name, Emotions_Count__c, Minute_Number__c, Score__c, Timestamp__c FROM Batch_Results__r)
					FROM Batch_Prep__c WHERE Id = :selectedBatch];
		}

		return null;

	}


}
