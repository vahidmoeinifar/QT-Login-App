Welcome to the QT-Login-App!

This application manages user accounts using a single database table with fields for the user's name, a hashed password, and their email address. For password recovery, the application employs a straightforward mechanism: upon request, it generates a unique 4-digit code displayed directly in the console. This recovery code can then be used by the user to regain access to their account. The system offers flexibility in how this code is handled, allowing for potential future enhancements such as sending it to the user's registered email.

Under the hood, the application leverages QSQLite for database management, enhanced with SQLCipher to provide robust encoding and decoding of the database contents, ensuring data security. The user interface is built with Qt Quick and QML, providing a modern and responsive front-end experience. During the initial setup, new users are required to complete a signup process to create their accounts.
