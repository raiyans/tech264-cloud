
# Managing File Ownership in Unix/Linux Systems
- [Managing File Ownership in Unix/Linux Systems](#managing-file-ownership-in-unixlinux-systems)
  - [1. Why is managing file ownership important?](#1-why-is-managing-file-ownership-important)
  - [2. What is the command to view file ownership?](#2-what-is-the-command-to-view-file-ownership)
  - [3. What permissions are set when a user creates a file or directory? Who does the file or directory belong to?](#3-what-permissions-are-set-when-a-user-creates-a-file-or-directory-who-does-the-file-or-directory-belong-to)
  - [4. Why does the owner, by default, not receive execute (`x`) permissions when they create a file?](#4-why-does-the-owner-by-default-not-receive-execute-x-permissions-when-they-create-a-file)
  - [5. What command is used to change the owner of a file or directory?](#5-what-command-is-used-to-change-the-owner-of-a-file-or-directory)
- [Understanding File Permissions in Unix/Linux Systems](#understanding-file-permissions-in-unixlinux-systems)
  - [1. Does being the owner of a file mean you have full permissions on that file? Explain.](#1-does-being-the-owner-of-a-file-mean-you-have-full-permissions-on-that-file-explain)
  - [2. If you give permissions to the **User** entity, what does this mean?](#2-if-you-give-permissions-to-the-user-entity-what-does-this-mean)
  - [3. If you give permissions to the **Group** entity, what does this mean?](#3-if-you-give-permissions-to-the-group-entity-what-does-this-mean)
  - [4. If you give permissions to the **Other** entity, what does this mean?](#4-if-you-give-permissions-to-the-other-entity-what-does-this-mean)
  - [5. Example Scenario: User permissions are read-only, Group permissions are read and write, Other permissions are read, write, and execute.](#5-example-scenario-user-permissions-are-read-only-group-permissions-are-read-and-write-other-permissions-are-read-write-and-execute)
  - [6. Example from `ls -l`: -rwxr-xr-- 1 tcboony staff 123 Nov 25 18:36 keeprunning.sh](#6-example-from-ls--l--rwxr-xr---1-tcboony-staff-123-nov-25-1836-keeprunningsh)
    - [Summary of Permissions:](#summary-of-permissions)
- [Understanding Numeric File Permissions in Unix/Linux Systems](#understanding-numeric-file-permissions-in-unixlinux-systems)
  - [1. What numeric values are assigned to each permission?](#1-what-numeric-values-are-assigned-to-each-permission)
  - [2. What can you do with the values to assign read + write permissions?](#2-what-can-you-do-with-the-values-to-assign-read--write-permissions)
  - [3. What value would assign read, write, and execute permissions?](#3-what-value-would-assign-read-write-and-execute-permissions)
  - [4. What value would assign read and execute permissions?](#4-what-value-would-assign-read-and-execute-permissions)
  - [5. What do three numbers like `644` mean in file permissions?](#5-what-do-three-numbers-like-644-mean-in-file-permissions)
    - [Summary of Common Numeric Values:](#summary-of-common-numeric-values)

## 1. Why is managing file ownership important?

Managing file ownership is crucial for the following reasons:
- **Security:** Proper file ownership ensures that only authorized users have access to read, modify, or execute files and directories. It prevents unauthorized users from accessing sensitive data or performing harmful actions on critical files.
- **Accountability:** Ownership allows tracking of who created and is responsible for maintaining specific files and directories. This is particularly important in multi-user environments.
- **System Integrity:** Incorrect file ownership can compromise system stability. For instance, system files must be owned by privileged users to prevent tampering.
- **Collaboration:** In a multi-user environment, assigning correct ownership ensures that users can access shared files or directories without compromising security.

---

## 2. What is the command to view file ownership?

To view file ownership in Unix/Linux systems, the command is:
```bash
ls -l
```
- This command lists files in a directory along with their associated **owner** and **group**.
- The output shows permissions, ownership (both user and group), file size, and other attributes.

Example output:
```
-rw-r--r-- 1 alice devteam 1048 Sep 20 12:00 file.txt
```
In this case:
- The owner is `alice`
- The group is `devteam`

---

## 3. What permissions are set when a user creates a file or directory? Who does the file or directory belong to?

When a user creates a file or directory:
- **File Ownership:** By default, the user who creates the file becomes the owner. The group that the file is associated with depends on the user’s default group at the time of creation.
- **Permissions:** The default permissions for a file or directory are determined by the system’s **umask** setting.
  - For **files**, typically, the default permissions are `rw-r--r--` (644), meaning:
    - The owner has read and write (`rw-`) permissions.
    - The group and others have read-only (`r--`) permissions.
  - For **directories**, the default permissions are usually `rwxr-xr-x` (755), meaning:
    - The owner has read, write, and execute (`rwx`) permissions.
    - The group and others have read and execute (`r-x`) permissions.

---

## 4. Why does the owner, by default, not receive execute (`x`) permissions when they create a file?

The owner does not receive execute (`x`) permissions by default when creating a file because most files are created as data files (text, scripts, documents) that do not require execution. Execution permission is only meaningful for executable files like scripts or binary programs.

Granting the `x` permission automatically could pose a security risk if the file is unintentionally executed. The owner can always add the execute permission later using the `chmod` command if the file needs to be executed.

---

## 5. What command is used to change the owner of a file or directory?

To change the owner of a file or directory, the command used is:
```bash
chown new_owner file_or_directory
```
- Example:
  ```bash
  chown alice file.txt
  ```
- This command changes the ownership of `file.txt` to the user `alice`.

To change both the owner and the group, use:
```bash
chown new_owner:new_group file_or_directory
```
- Example:
  ```bash
  chown alice:devteam file.txt
  ```
- This changes the owner of `file.txt` to `alice` and the group to `devteam`. 

Only a superuser or root can change file ownership.


# Understanding File Permissions in Unix/Linux Systems

## 1. Does being the owner of a file mean you have full permissions on that file? Explain.

No, being the owner of a file does not automatically mean you have full permissions. In Unix/Linux systems, the owner of a file can have their permissions limited based on the file's permission settings. The owner can have read (`r`), write (`w`), and/or execute (`x`) permissions based on how they are set. Even if you own the file, if you don't have write permissions (`w`), for example, you won’t be able to modify the file.

## 2. If you give permissions to the **User** entity, what does this mean?

Giving permissions to the **User** entity means assigning permissions specifically to the owner of the file. The **User** refers to the specific user who owns the file. The permissions set for the **User** dictate what the owner can do with the file (i.e., read, write, or execute).

## 3. If you give permissions to the **Group** entity, what does this mean?

Giving permissions to the **Group** entity means assigning permissions to all users who belong to the group associated with the file. If a file is owned by a group, any user who is a member of that group will be subject to the **Group** permissions, regardless of their individual ownership of the file.

## 4. If you give permissions to the **Other** entity, what does this mean?

Giving permissions to the **Other** entity means assigning permissions to all users who are not the owner and do not belong to the file's group. This essentially defines the permissions for everyone else on the system who may try to access the file.

---

## 5. Example Scenario: User permissions are read-only, Group permissions are read and write, Other permissions are read, write, and execute.

**Permissions:**
- **User:** Read-only (`r--`)
- **Group:** Read and write (`rw-`)
- **Other:** Read, write, and execute (`rwx`)

If you are logged in as the user who owns the file, your permissions will be limited to **User** permissions. In this case, you will only have read access (`r--`). Even though **Group** and **Other** permissions are more permissive, those do not apply to the owner of the file. As the owner, you will not have write or execute permissions unless specifically granted to the **User** entity.

---

## 6. Example from `ls -l`: -rwxr-xr-- 1 tcboony staff 123 Nov 25 18:36 keeprunning.sh

Here’s how to break down the details from this line:

- `-rwxr-xr--`: Represents the file type and permissions.
    - **First character:** `-` indicates that this is a regular file (if it were a directory, it would show `d`).
    - **User (owner) permissions:** `rwx` - The owner (`tcboony`) has read, write, and execute permissions.
    - **Group permissions:** `r-x` - The group (`staff`) has read and execute permissions, but no write permission.
    - **Other permissions:** `r--` - All other users have read-only permissions.

- `1`: This represents the number of links to the file.

- `tcboony`: This is the owner (user) of the file.

- `staff`: This is the group that the file is associated with.

- `123`: This indicates the file size in bytes.

- `Nov 25 18:36`: The last modification date and time of the file.

- `keeprunning.sh`: The name of the file. Since it has execute (`x`) permissions for the user and group, this is likely a shell script that can be executed by the owner and group members.

### Summary of Permissions:
- **Owner (`tcboony`):** Can read, write, and execute the file.
- **Group (`staff`):** Can read and execute the file.
- **Others:** Can only read the file.

---


# Understanding Numeric File Permissions in Unix/Linux Systems

## 1. What numeric values are assigned to each permission?

In Unix/Linux, file permissions can be represented numerically using a three-digit octal system. Each permission is assigned a specific numeric value:

- **Read (`r`)**: 4
- **Write (`w`)**: 2
- **Execute (`x`)**: 1

Permissions are combined to form the total value for each entity (User, Group, and Others).

| Permission | Numeric Value |
|------------|---------------|
| Read (`r`) | 4             |
| Write (`w`) | 2            |
| Execute (`x`) | 1          |

---

## 2. What can you do with the values to assign read + write permissions?

To assign **read + write** permissions, you combine the values for read (4) and write (2):

- **Read (`r`)** = 4
- **Write (`w`)** = 2
- **Total (read + write)** = **6**

Thus, `6` represents read and write permissions.

---

## 3. What value would assign read, write, and execute permissions?

To assign **read, write, and execute** permissions, you combine the values for read (4), write (2), and execute (1):

- **Read (`r`)** = 4
- **Write (`w`)** = 2
- **Execute (`x`)** = 1
- **Total (read + write + execute)** = **7**

Thus, `7` represents read, write, and execute permissions.

---

## 4. What value would assign read and execute permissions?

To assign **read and execute** permissions, you combine the values for read (4) and execute (1):

- **Read (`r`)** = 4
- **Execute (`x`)** = 1
- **Total (read + execute)** = **5**

Thus, `5` represents read and execute permissions.

---

## 5. What do three numbers like `644` mean in file permissions?

When a file or directory's mode/permissions are represented by three numbers, each number corresponds to a different set of permissions for the **User (owner)**, **Group**, and **Others**:

- **6** = User (owner): Read + Write (4 + 2 = 6)
- **4** = Group: Read-only (4)
- **4** = Others: Read-only (4)

So, the permissions for `644` would be:
- **User (owner)**: Read and write (`rw-`)
- **Group**: Read-only (`r--`)
- **Others**: Read-only (`r--`)

This means the owner can read and modify the file, while group members and others can only read the file.

---

### Summary of Common Numeric Values:
- **7** = Read, write, and execute (`rwx`)
- **6** = Read and write (`rw-`)
- **5** = Read and execute (`r-x`)
- **4** = Read-only (`r--`)

