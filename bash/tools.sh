export ECLIPSE='eclipse-luna'
export JAVA_OPTS='-Xmx2024m -Xms512m -XX:MaxPermSize=256m'

alias xmind='XMind'
alias xclip='xclip -selection clipboard'

# git support
. ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\u:\W$(__git_ps1 "(%s)")\$ '

# vert.x
export PATH="$PATH:$HOME/dev/vert.x-2.1.6/bin"

.camunda.build() {
    .cd app-workflow && mvn clean package
}

.camunda.deploy() {
    sudo cp /home/spi/tt_projects/ps-app-workflow/target/*.war /var/lib/tomcat7/webapps/ps-app-workflow.war
}

.camunda.clean() {
    sudo service tomcat7 stop
    sudo rm -rf /var/lib/tomcat7/webapps/ps-app-workflow*
    sudo service tomcat7 start
}

.camunda.cleanbuilddeploy() {
    .camunda.clean && .camunda.build && .camunda.deploy
}
