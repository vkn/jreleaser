= AppImage for {{projectName}}

:linkattrs:
:executable:      {{distributionExecutableName}}
:project-owner:   {{appImageRepositoryOwner}}
:project-name:    {{appImageRepositoryName}}
:project-version: {{projectVersion}}
:project-tag:     {{tagName}}

image:https://img.shields.io/github/actions/workflow/status/{project-owner}/{project-name}/release.yml?branch=main&logo=github&label=Build["Build Status", link="https://github.com/{project-owner}/{project-name}/actions"]
image:https://img.shields.io/github/downloads/{project-owner}/{project-name}/total[GitHub Release Total]

---

Follow these instructions to run {{projectName}} as an AppImage:

* Download the latest AppImage from the release page

[source]
[subs="attributes"]
----
$ curl https://github.com/{project-owner}/{project-name}/releases/download/{project-tag}/{executable}-{project-version}-x86_64.AppImage --output {executable}
----

* Make it executable

[source]
[subs="attributes"]
----
$ chmod +x {executable}
----

* Run it

[source]
[subs="attributes"]
----
$ ./{executable} --help
----
