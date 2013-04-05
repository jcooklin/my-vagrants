class accounts (
  $users = hiera('accounts::users')
){
  import "user.pp"
  import "ssh_key.pp"
  create_resources(add_user, $users)
}
