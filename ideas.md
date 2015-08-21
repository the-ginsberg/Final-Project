# Token workflow

- Someone has a token.
- Someone visits the app using the token.
- App takes the token and searches for a dashboard.
- A dashboard is found.
    - `@dashboard.members << current_user`
- The token is expired so it cannot be used again.

- Add a new unique token to the Dashboard. Share one token for each member.
    - `@dashboard.tokens << Token.create(value: "kjdfkljsdflkj")`
- Search for the Dashboard with the token:
    - `@token = Token.find_by(value: params[:search])`
    - Check to make sure it isn't expired: `@token.expired?`
        - `@dashboard = @token.dashboard`21-=qwerrrrrr
- Expire the token using a method you define in the model:
        - @token.expire!
        def expire!
          expired = true
          save
        end




## Classes

### User
  - has_many :dashboards
  - has_many :dashboard_memberships
  - has_many :memberships, through: :dashboard_memberships, source: :member

### Dashboard
  - has_many :tokens
  - belongs_to :user
  - has_many :dashboard_memberships
  - has_many :members, through: :dashboard_memberships
  <!-- HOW DO I MAKE MEMBERS REFERENCE MEMBER_ID? -->
  - attributes: member:references (member_id on the dashboards table)

### Token
  - belongs_to :dashboard
  - attributes: value:string, expired:boolean

### DashboardMemberships
  - belongs_to :dashboard
  - belongs_to :member, class_name: 'User'
  - attributes: member_id, dashboard_id, role/title/whatever
