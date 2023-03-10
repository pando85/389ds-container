389 Directory Server is a fully featured LDAP server, capable of handling millions of entries and scaling from small home installations all the way to some of the largest distributed databases in the world.

This is a containerised version of the Directory Server project, which is aimed to be easy to deploy and run.

To try it out: `docker run pando85/389ds:latest`

To make your data persistent: `docker run -v dirsrv:/data pando85/389ds:latest`. All data for your instance is placed into `/data`, and supports in-place upgrades between versions.

You can administer your instance with `docker exec -i -t CONTAINER_NAME dsconf --help`. This will automatically connect internally inside the container as `cn=Directory Manager`.

Environment Variables:

- `DS_ERRORLOG_LEVEL` - Override the errorlog level during startup to assist with debugging.
- `DS_DM_PASSWORD` - The password of the cn=Directory Manager user. Randomly generated by default.
- `DS_MEMORY_PERCENTAGE` - The percentage of container memory to use for DB caches. You should not need to change this value.
- `DS_REINDEX` - If set to true, a DB reindex will be performed before the instance starts.
- `DS_SUFFIX_NAME` - Set the default database suffix name in some config files for dsidm.
- `DS_STARTUP_TIMEOUT` - Change the amount of time to wait for the instance to start. May be useful with large instances.

Configuration Files:

- `/data/config/container.inf` - Administration tool connection settings for the instance
- `/data/tls/{server.key, server.crt, ca/*.crt}` - PEM files to import and use at startup. server.{key,crt} are the private key/certificate for TLS listening. ca is a folder with PEM format CA's that should be added to the trust root for this instance.

Advisories:

- 2022-05-31 - A CRITICAL security issue (CVE-2022-1949) was identified in all versions of 389-ds - this has necessitated the removal of the older image streams. You MUST update to 2.1/latest ASAP. For more see: https://bugzilla.suse.com/show_bug.cgi?id=1199889
- 2022-02-18 - Instances now support running dirsrv as non-root when the uid/gid number are not defined in /etc/passwd or similar.
- 2020-06-03 - An issue with container restarts has been resolved in 1.4/1.4.4 and latest. Please update when possible.

This docker image is build in the opensuse buildservice as part of a release pipeline. To view the dockerfile used to make this image, please visit: https://build.opensuse.org/package/view_file/home:firstyear/389-ds-container/Dockerfile?expand=1
