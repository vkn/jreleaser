# {{jreleaserCreationStamp}}
name: {{snapPackageName}}
version: {{projectVersion}}
summary: {{projectDescription}}
description: {{projectLongDescription}}

grade: {{snapGrade}}
confinement: {{snapConfinement}}
base: {{snapBase}}
type: app

{{#hasArchitectures}}
architectures:
  {{#snapArchitectures}}
  - build-on: {{buildOn}}
    {{#hasRunOn}}run-on: {{runOn}}{{/hasRunOn}}
    {{#ignoreError}}build-error: ignore{{/ignoreError}}
  {{/snapArchitectures}}
{{/hasArchitectures}}
apps:
  {{distributionExecutableName}}:
    command: ${JAVA_HOME}/bin/java -jar $SNAP/{{distributionArtifactFile}}
    environment:
      JAVA_HOME: "$SNAP/usr/lib/jvm/java/jre/"
      PATH: "$PATH:$SNAP/usr/lib/jvm/java/jre/bin"
    {{#snapHasLocalPlugs}}
    plugs:
      {{#snapLocalPlugs}}
      - {{.}}
      {{/snapLocalPlugs}}
    {{/snapHasLocalPlugs}}
    {{#snapHasLocalSlots}}
    slots:
      {{#snapLocalSlots}}
      - {{.}}
      {{/snapLocalSlots}}
    {{/snapHasLocalSlots}}

{{#snapHasPlugs}}
plugs:
  {{#snapPlugs}}
  {{name}}:
    {{#attributes}}
    {{key}}: {{value}}
    {{/attributes}}
  {{/snapPlugs}}
{{/snapHasPlugs}}
{{#snapHasSlots}}
slots:
  {{#snapSlots}}
  {{name}}:
    {{#attributes}}
    {{key}}: {{value}}
    {{/attributes}}
    {{#hasReads}}
    reads:
      {{#reads}}
      - {{.}}
      {{/reads}}
    {{/hasReads}}
    {{#hasWrites}}
    writes:
      {{#writes}}
      - {{.}}
      {{/writes}}
    {{/hasWrites}}
  {{/snapSlots }}
{{/snapHasSlots}}
parts:
  {{distributionExecutableName}}:
    plugin: nil
    override-build: |
      wget -O $SNAPCRAFT_PART_INSTALL/{{distributionArtifactFile}} {{distributionUrl}}
      snapcraftctl set-version "{{projectVersion}}"
    build-packages:
      - wget
    stage-packages:
      - openjdk-{{distributionJavaVersion}}-jre
      - ca-certificates
      - ca-certificates-java
    organize:
      'usr/lib/jvm/java-{{distributionJavaVersion}}-openjdk*': 'usr/lib/jvm/java'
    prime:
      - -usr/lib/jvm/java/lib/security/cacerts
      - -usr/lib/jvm/java/jre/lib/security/cacerts
