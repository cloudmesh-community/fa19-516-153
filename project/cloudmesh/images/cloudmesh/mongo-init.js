db.createUser(
    {
        user: "admin",
        pwd: "amirjancloudmesh",
        roles: [
            {
                role: "readWrite",
                db: "cloudmesh"
            }
        ]
    }
);