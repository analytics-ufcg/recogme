#inputs
train = read.table("/home/tales/recogme/train-1.2.csv", sep = "\t", header = T)
k = 20
attempts = c(108, 111)

att.email = data.frame("attempt_id" = train$attempt_id, "email" = train$email)
train$attempt_id = NULL
train$email = NULL

cl = kmeans(train, centers = k)

clusters = data.frame(att.email, "cluster" = cl$cluster)
row.names(clusters) = NULL

train = data.frame("attempt_id" = att.email$attempt_id,  "email" = att.email$email, train)

cluster = clusters[is.element(clusters$cluster, clusters[is.element(clusters$attempt_id, attempts),]$cluster),]$attempt_id

cluster_members = train[is.element(train$attempt_id, cluster),]
