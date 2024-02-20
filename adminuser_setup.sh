#! /bin/bash

DB_USER=`echo $PLATFORM_RELATIONSHIPS | base64 -d | jq -r '.database[0].username'`
DB_PASS=`echo $PLATFORM_RELATIONSHIPS | base64 -d | jq -r '.database[0].password'`
DB_HOST=`echo $PLATFORM_RELATIONSHIPS | base64 -d | jq -r '.database[0].host'`
DB_PATH=`echo $PLATFORM_RELATIONSHIPS | base64 -d | jq -r '.database[0].path'`
DB_PORT=`echo $PLATFORM_RELATIONSHIPS | base64 -d | jq -r '.database[0].port'`

admin_user=$(mysql --host=$DB_HOST --port=$DB_PORT --user=$DB_USER --password=$DB_PASS $DB_PATH -e "SELECT * FROM admin_user;")

if [[ -z "$admin_user" ]]; then
    echo "No admin user set. Creating …"
    php $PLATFORM_APP_DIR/bin/magento admin:user:create --admin-user=admin --admin-password=Admin123 --admin-email=demo_admin@example.com --admin-firstname=admin --admin-lastname=admin
else
    echo "Admin user exists. Skipping."
fi