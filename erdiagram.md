erDiagram
ORGANIZATIONS {
integer id
string name
}
ACCOUNTS {
uuid id
string email
string hash_password
}
USERS {
uuid id
string full_name
string gender
text biography
uuid account_id
integer organization_id
}
ORGANIZATIONS ||--|| ACCOUNTS : "has"
ORGANIZATIONS ||..|| USERS : "has"
ACCOUNTS ||--|| USERS : "is linked to"

    EVENTS {
        uuid id
        string title
        timestamp start
        timestamp end
        boolean allDay
        integer organization_id
        uuid user_id
    }
    ORGANIZATIONS ||..|| EVENTS : "has"
    USERS ||..|| EVENTS : "participates in"

    FORM_TYPES {
        uuid id
        string name
        jsonb fields
        integer organization_id
        string label
    }
    FORMS {
        uuid id
        string name
        jsonb data
        integer organization_id
        uuid form_type_id
    }
    ORGANIZATIONS ||..|| FORM_TYPES : "has"
    FORM_TYPES ||..|| FORMS : "can have"

    LOCATIONS {
        uuid id
        string name
        jsonb location
        string address
        string type
        integer organization_id
    }
    ORGANIZATIONS ||..|| LOCATIONS : "has"

    ROLES {
        uuid id
        string name
        integer organization_id
    }
    PERMISSIONS {
        uuid id
        string permission_name
        integer organization_id
        uuid role_id
    }
    ORGANIZATIONS ||..|| ROLES : "has"
    ORGANIZATIONS ||..|| PERMISSIONS : "has"
    ROLES ||..|| PERMISSIONS : "has"

    WORKERS {
        uuid id
        string name
        string email
        integer age
        string position
        string responsibility
        string description
        integer organization_id
    }
    ORGANIZATIONS ||..|| WORKERS : "has"

    LOCATIONS_FORMS {
        uuid id
        uuid form_id
        uuid location_id
        integer organization_id
    }
    LOCATIONS ||..|| LOCATIONS_FORMS : "can have"
    FORMS ||..|| LOCATIONS_FORMS : "can have"

    LOCATIONS_WORKERS {
        uuid id
        uuid location_id
        uuid worker_id
    }
    LOCATIONS ||..|| LOCATIONS_WORKERS : "can have"
    WORKERS ||..|| LOCATIONS_WORKERS : "can have"

    USERS_ROLES {
        uuid id
        uuid role_id
        uuid user_id
    }
    USERS ||..|| USERS_ROLES : "can have"
    ROLES ||..|| USERS_ROLES : "can have"
