# ghost-blog-k8s-deployment
All the stuff you need to deploy a Ghost Blog to kubernetes.

Almost..

Pre requisites:

1. You will need a Kubernetes cluster that have configured to be connected to. (If you can run kubectl and access your cluster then you are good.)
2. You will need a MySQL database that is accessible from your Kubernetes deployment.

There are 2 files in this code that you will need to edit to setup your own website:
1. config.sh (set the variables) - Do not commit this to source control because you will have your SSL secret in here.
2. secrets.yaml (set your secrets) - Do not commit this data into source control because you will put a password in here.

Save all the files into a folder on your computer.
Edit config.sh as needed
Edit secrets.yaml as needed
Make sure you are connected to your K8s cluster.
Navigate into the folder where your files are.
Open a command prompt and type:
```
bash config.sh
```

If you get any errors about a resource not existing, you might want to run that command once more. It could just be that something didn't get created in the right order.

If you don't get errors try navigating to your website. If it isn't loading, it might be that your database is still being configured. Give it a couple minutes and try again. You can view the logs of your pod to see what is going on.


