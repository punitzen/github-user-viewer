## Github User Viewer
An app to view github user profile, shows user name, login, bio, repository count, followers, following, repositories and contributors. used github api to fetch user details, repositories and contributors, used TableView, CollectionView, NavigationController and CustomUI Cell through Xib. Implemented through MVVM Architecture. 

![gitDemo](gitDemo.gif)

## Github API
BASE_URL - `https://api.github.com/`

### API to Fetch Profile Info
URL - `BASE_URL/users/{username}`

EXP - `https://api.github.com/users/punitzen`

### API to Fetch User Repository List 
URL - `BASE_URL/users/{username}/repos`

EXP - `https://api.github.com/users/punitzen/repos`


### API to Fetch the Contributors
URL - `BASE_URL/repos/{username}/{reponame}/contributors`

EXP - `https://api.github.com/repos/punitzen/music-controller-jam/contributors`