# SecuPayroll Virtual Private Database Setup
SecuPayroll is a small payroll services company that aims to implement a secure virtual private database (VPD) solution to manage client payroll data. This project involves the design and implementation of a VPD to ensure data privacy for multiple clients. The primary objective is to allow each client's administrator access only to their respective payroll records.


### Project Components:

1. **Database Schema Setup:**
   - Execute the provided SQL script (`P5_create_tables.txt`) to create the necessary tables and triggers for the payroll application.

2. **User Account Creation:**
   - Create separate user accounts (`JAdmin` for Nexum, `FAdmin` for Rashima, and `DBA643` for testing) with specific privileges and default tablespaces.

3. **Public Synonyms:**
   - Establish public synonyms for each table to simplify access for users.

4. **Privilege Granting:**
   - Grant appropriate privileges to each user account, including `SELECT`, `INSERT`, `UPDATE`, and `DELETE` on relevant tables.

5. **Virtual Private Database (VPD) Policy:**
   - Implement a VPD policy function to control data access based on user roles and ownership (`CTL_SEC_USER` column).

6. **Testing:**
   - Thoroughly test the system using the provided user accounts (`JAdmin`, `FAdmin`, and `DBA643`) to ensure data access restrictions are functioning correctly.

### How to Use:

1. Clone the repository.
2. Execute the SQL script to create tables and triggers.
3. Follow the provided SQL commands to create user accounts and grant privileges.
4. Test the system using the specified user accounts.

### Note:

- This project assumes one administrator per company with specific access rights.
- Ensure that the VPD policy is correctly implemented for each table.

---

This description provides a clear outline of the project, its objectives, and steps to set up and test the virtual private database for SecuPayroll. Adjust it as needed for your specific GitHub repository.
