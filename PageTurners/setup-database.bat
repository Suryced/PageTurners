@echo off
echo Setting up PageTurners Database...
echo.
echo Make sure MySQL is running on localhost:3306
echo Default username: root, password: password
echo.
pause
echo.
echo Creating database and tables...
mysql -u root -p < database\schema.sql
echo.
echo Database setup complete!
echo You can now start the PageTurners application.
pause
