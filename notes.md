- To generate db schema and create controllers for it:
  mix phx.gen.json Accounts Account accounts email:string hash_password:string

Organizations - mix phx.gen.json Organizations Organization organizations name:string
Roles - mix phx.gen.json Roles Role roles name:string organization_id:references:organizations
Permissions - mix phx.gen.json Permissions Permission permissions permission_name:string organization_id:references:organizations role_id:references:roles
Locations - mix phx.gen.json Locations Location locations name:string location:map address:string organization_id:references:organizations
FormType - mix phx.gen.json FormTypes FormType form_types name:string fields:map organization_id:references:organizations
Forms - mix phx.gen.json Forms Form forms name:string data:map organization_id:references:organizations form_type_id:references:form_types
Workers - mix phx.gen.json Workers Worker workers name:string organization_id:references:organizations email:string age:integer position:string responsibility:string description:string

Events - mix phx.gen.json Events Event events title:string start:utc_datetime end:utc_datetime allDay:boolean organization_id:references:organizations user_id:references:users

LocationsWorker - mix ecto.gen.migration

Generate migrations - mix phx.gen.migrations

```mermaid
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


```
