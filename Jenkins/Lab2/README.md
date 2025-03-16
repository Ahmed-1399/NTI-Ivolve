# Lab1
![Architecture](./assets/Lab2.png)

# Add Role Plugin
```bash
From Manage Jenkins  --->  Plugins  --->  Available Plugins  --->  Role-based Authorization Strategy
```
![Architecture](./assets/Role-Plugin.png)

# Configure Role-based Authorization Strategy
```bash
From Manage Jenkins  --->  Security  --->  Authorization(Role-Based Strategy)  --->  Save
```
![Architecture](./assets/Configure-Strategy.png)

# Create Roles
```bash
From Manage Jenkins  --->  Manage and Assign Roles  ---> 
Manage Roles  --->  Role to add(Add-Name of Role)  then Click Add  ---> Save
```
![Architecture](./assets/Create-Role.png)

# Create 2 Users
```bash
From Manage Jenkins --->  Users  ---> Create User
```
![Architecture](./assets/2-users.png)

# Assign Role for Users
```bash
From Manage Jenkins  --->  Manage and Assign Roles  ---> 
Assign Roles  --->  Global Role (Add User-ID)  then Click OK  ---> Save
```
![Architecture](./assets/Assign-Role.png)

# Change Password for Users
```bash
From Manage Jenkins --->  Users  --->  Choose Your user to(Configure your Password)  ---> Security  ---> Password
```

# Test Enters by 2 Users
![Architecture](./assets/Admin-user1.png)
![Architecture](./assets/Read-user2.png)
