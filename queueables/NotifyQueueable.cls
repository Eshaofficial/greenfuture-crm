public class NotifyQueueable implements Queueable {
    private List<Id> projectIds;
    public NotifyQueueable(List<Id> projectIds) {
        this.projectIds = projectIds;
    }

    public void execute(QueueableContext ctx) {
        if (projectIds == null || projectIds.isEmpty()) return;

        List<Task> tasks = new List<Task>();
        for (Id pid : projectIds) {
            Task t = new Task(
                Subject = 'Review Credits for Completed Project',
                WhatId = pid,
                OwnerId = UserInfo.getUserId(),
                Status = 'Not Started',
                Priority = 'Normal'
            );
            tasks.add(t);
        }
        if (!tasks.isEmpty()) insert tasks;
    }
}