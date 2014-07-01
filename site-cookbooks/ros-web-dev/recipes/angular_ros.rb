user = node["ros_web_dev"]["user"]
repo = "angular-ros"
org = "syrnick"

git "/home/#{user}/rwt/#{repo}" do
  repository "https://github.com/#{org}/#{repo}"
  user user
end

ros_sv 'angular-ros-static' do
  user user
  setup_bash "/opt/ros/#{ros_distro}/setup.bash"
  command "cd ~/rwt/angular-ros && python -m SimpleHTTPServer 8081"
end
