public class NotifyQueueable implements Queueable {
    private List<Id> projectIds;
    public NotifyQueueable(List<Id> projectIds) {
        this.projectIds = projectIds;
    }

    public void execute(QueueableContext ctx) {
        if (projectIds == null || projectIds.isEmpty()) return;

        List<Task> tasks = new List<Task>();
        for (Id pid : projectIds) {
            Task t = new Task();
            t.Subject = 'Review Credits for Completed Project';
            t.WhatId = pid;
            t.OwnerId = UserInfo.getUserId(); // adjust to Sustainability Manager as needed
            t.Status = 'Not Started';
            t.Priority = 'Normal';
            tasks.add(t);
        }
        if (!tasks.isEmpty()) insert tasks;
    }
}
