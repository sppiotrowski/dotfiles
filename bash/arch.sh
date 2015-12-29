URL_SPACE='%20'
CI_BASE_URL='http://ci-2.dev.outfittery.de/job'

alias .vertx='export JAVA_HOME=/usr/lib/jvm/java-8-oracle/ && groovysh -cp "/home/spi/Downloads/vert.x-3.0.0/lib/*"'

# grails support
.run() {
   APP="$1"
   if [ -z "$APP" ]; then
       grails run-app
   else
       .cd "$APP" && grails run-app
   fi
}

.test() {
   APP="$1"
   if [ -z "$APP" ]; then
       grails test-app
   else
       .cd "$APP" && grails test-app
   fi
}

SSH_USR='spiotrowski'
.ssh() {
   HOST="$1" 
   ARGS="$2"
   SSH_USER="$2:-$SSH_USR"
   if [ -z "$ARGS" ]; then
      ssh "$SSH_USR@$HOST"
   else
      ssh "$SSH_USR@$HOST" "$2"
   fi
}

.ssh.salt() {
    .ssh 192.168.6.9 "$@"
}

.ssh.monitoring() {
    .ssh 148.251.222.55
}

.order.create() {
    CUST_ID="$1"
    URL="http://staging-ps-app-administration.apps.outfittery.de/order/create?customer.id=$CUST_ID"
    .http "$URL"
}

.live() {
    SERVER_NAME="$1"
    CMD='curl --silent -u sebastian.piotrowski@outfittery.de:Sebar00t  "https://outfittery.atlassian.net/wiki/display/DEVOPS/Server+farm" | w3m -dump -T "text/html"| grep -E "^[a-z0-9-]+\.[a-z]+\.[a-z]+\.[a-z]+"'
    if [ -z "$SERVER_NAME" ]; then
        eval "$CMD"
    else
        eval "$CMD" | grep "$SERVER_NAME"
    fi
}

.server.staging() {
    SERVER_NAME="$1"
    CMD='curl --silent -u sebastian.piotrowski@outfittery.de:Sebar00t "https://outfittery.atlassian.net/wiki/display/IT/Stage+servers" | w3m -dump -T "text/html" | grep -E "^192"'
    #CMD='curl --silent -u sebastian.piotrowski@outfittery.de:Sebar00t  "https://outfittery.atlassian.net/wiki/display/DEVOPS/Server+farm" | w3m -dump -T "text/html"| grep -E "^[a-z0-9-]+\.[a-z]+\.[a-z]+\.[a-z]+"'
    if [ -z "$SERVER_NAME" ]; then
        eval "$CMD"
    else
        eval "$CMD" | grep "$SERVER_NAME"
    fi
}


.jenkins.cli() {
    java -jar /opt/jenkins-cli/jenkins-cli.jar -s http://ci-2.dev.outfittery.de/ "$@"
}

.build.workflow() {
    cd $TT_ROOT/ps-app-workflow/ && mvn clean package && sudo cp $TT_ROOT/ps-app-workflow/target/ps-app-workflow.war /var/lib/tomcat7/webapps/ && sudo tail -200f /var/lib/tomcat7/logs/catalina.out
}

.build.tm() {
    .cd ps-app-taskmanager && grunt dev && sudo nginx -s reload
}

.psql() {
    DB_NAME=${1:-sebastian.piotrowski.db}
    PGPASSWORD='Fsb92PV93B5ChrmWRbxUU6H2sT'
    psql -x --host=192.168.6.4 --port=5432 --dbname="$DB_NAME" \
        --username=DEJu7eMHrUH3eGph6mcCSAdkUH
}
.psql.staging() {
    .psql paul-development
}

.order.stuck() {
    .http 'https://docs.google.com/spreadsheets/d/1o0qxDgV83xJA8k_Jxg3sP8W3OB56tJ897ciMw1p2zzY/edit#gid=648739311&vpid=A1'
}

.rel.for_ci_build() {
    REL_BUILD=${1:-'CI_BUILD_HERE'}
    REL_DATE=${2:-$(date +%d.%m.%Y)}
    REL="${REL_BUILD}-release-${REL_DATE}"
    echo $REL
}

.rel.new() {
    REL_DATE=${1:-$(date +%d.%m.%Y)}
    REL="release-${REL_DATE}"
    echo $REL
}

.rel.publish() {
    # sample:
    # .rel.publish 'hotfix-26.11.2015' '70-release-26.11.2015'
    # .rel.publish 'hotfix-26.11.2015' $(.rel.for_ci_build 70)

    REMOTE_BRANCH="$1"      # last builded & deployed branch from 'jenkins'
    REL_NAME="$2"           # relase name, format: <CI_BUILD_NO>-release-<dd.MM.yyyy>
    PROJ_PART="${3-$(basename $PWD)}"
    PROJ_NAME=$(.project "$PROJ_PART")

    if _confirm "release $PROJ_NAME from $REMOTE_BRANCH with a tag $REL_NAME?"; then
        .cd "$PROJ_NAME"
        $(_confirm "git merge origin/$REMOTE_BRANCH") || return 1
        git checkout master && git pull && git merge origin/"$REMOTE_BRANCH"
        $(_confirm "git push origin master:master") || return 1
        git push origin master:master
        $(_confirm "git tag -a $REL_NAME -m $REL_DESC") || return 1
        git tag -a $REL_NAME -m "$REL_DESC"
        $(_confirm "git push origin $REL_NAME") || return 1
        git push origin $REL_NAME
        $(_confirm "git checkout develop && git merge master") || return 1
        git checkout develop && git pull && git merge master
        $(_confirm "git push origin develop:develop") || return 1
        git push origin develop:develop
        $(_confirm ".github $PROJ_NAME") || return 1
        .github "$PROJ_NAME"
    else
      echo cancelled.
      return 1
    fi
}

.app() {
    PROJ_PART="$1"
    ENVIRON="${2:-staging}"
    PROJ_NAME=$(.project "$PROJ_PART")
    URL="http://${ENVIRON}.${PROJ_NAME}.apps.outfittery.de"
    echo $URL
    .http "$URL"
}

.minion() {
    PROJ_PART="$1"
    ENVIRON="${2:-staging}"
    PROJ_NAME=$(.project "$PROJ_PART")
    APP_NAME="${PROJ_NAME#ps-app-}"
    MINION_POSTFIX=$([ "$ENVIRON" == staging ] && echo 'local' || echo 'de')
    MINION="${ENVIRON}-${APP_NAME}-1.apps.outfittery.${MINION_POSTFIX}"
    echo "$MINION"
}

.salt() {
    PROJ_PART="$1"
    CMD="${2:-bluegreen.info}"
    ENVIRON="${3:-staging}"
    MINION=$(.minion "$PROJ_PART" "$ENVIRON")
    echo "salt $MINION $CMD"
    .ssh.salt "salt $MINION $CMD"
}

.salt.deploy() {
    PROJ_PART="$1"
    ENVIRON="${2:-staging}"
    MINION=$(.minion "$PROJ_PART" "$ENVIRON")
    ssh "${SSH_USR}@148.251.249.168" 'bash -s' <<EOF
    salt $MINION bluegreen.deploy && \
    salt $MINION bluegreen.switch && \
    salt $MINION bluegreen.deploy && \
    salt $MINION bluegreen.switch && \
    salt $MINION bluegreen.info
EOF
}

.eclipse.grep() {
    "$ECLIPSE" $(git grep -l "$@")
}

.git.all.do() {
    for PROJ in $(find $TT_ROOT -maxdepth 1 -type d); do
        echo "processing: $PROJ"
        cd "$PROJ"
        [ ! -d './.git' ] && continue;
        bash -cl "$*"
    done;
}

.jenkins() {
    PROJ_PART="$1"
    PROJ_NAME=$(.project "$PROJ_PART")
    .http 'http://ci-2.dev.outfittery.de/view/STAGE%201/job/deploy%20on%20stage%20'"$PROJ_NAME"
}

.jenkins.prod() {
    PROJ_PART="$1"
    PROJ_NAME=$(.project "$PROJ_PART")
    'http://ci-2.dev.outfittery.de/view/APPS/job/build%20'"$PROJ_NAME"'%20release'
}

.url.info() {
    .http 'https://docs.google.com/document/d/1UI9dwswUL55fMOxhf3EIRXO_yA570TDHvKHncxeiLFQ/edit'
}
alias .ui=.url.info

.ci() {
    local PROJ_PART="${1-$(basename $PWD)}"
    local BUILD_ENV="${2:-stage}"
    local PROJ_NAME=$(.project "$PROJ_PART")
    if [ "$BUILD_ENV" == 'stage' ]; then
        local URL="${CI_BASE_URL}/deploy${URL_SPACE}on${URL_SPACE}stage${URL_SPACE}${PROJ_NAME}"
    else
        local URL="${CI_BASE_URL}/build${URL_SPACE}${PROJ_NAME}${URL_SPACE}release"
    fi
    .http $URL
}

.ci.build() {
    local TO_BUILD="${1:-$(.git.branch.current)}"
    local PROJ_PART="${2-$(basename $PWD)}"
    local BUILD_ENV="${3:-stage}"
    local PROJ_NAME=$(.project "$PROJ_PART")
    local URL='http://ci-2.dev.outfittery.de/job/deploy%20on%20stage%20'"$PROJ_NAME"'/buildWithParameters?TO_BUILD='"$TO_BUILD"

    local URL='http://ci-2.dev.outfittery.de/job/build%20'"$PROJ_NAME"'/buildWithParameters?TO_BUILD='"$TO_BUILD"
    if _confirm "ci: build $PROJ_NAME with $TO_BUILD?"; then
        .url $URL
        #curl -X POST $URL
    fi
}
alias .cib=.ci.build

.git.branch.current() {
    local PROJ_PART="${2-$(basename $PWD)}"
    .cd "$PROJ_PART"
    git rev-parse --abbrev-ref HEAD
}

alias .gbc=.git.branch.current

.zabbix.sms.count() {
    local PORT=${1:-8080}
    local URL="http://148.251.222.56:$PORT/monitoring.check?checks=SendErrorsCheck"
    local RES=$(curl --silent "$URL")
    echo "$URL $RES"
}

.zabbix.sms.clean() {
    for PORT in 8080 8081; do
        local URL="http://148.251.222.56:$PORT/stats/errors/reset"
        local RES=$(curl --silent "$URL")
        echo "$URL $RES"
    done
}

