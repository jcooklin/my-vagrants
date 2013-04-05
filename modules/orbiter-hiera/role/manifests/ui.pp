# public_hostname will be looked up in hiera as role::ui::public_hostname
class role::ui (
    $public_hostname,
    $my_var = hiera("ut_zone"),
    $project_name
) {
    notify {'role::ui::notify':
        message => "role::ui configured for ${::data_center}; hostname: $public_hostname",
    }
    notify {"get var value from orbiter ${my_var}":}
    notify {"get anothe var value from orbiter ${project_name}":}
}
