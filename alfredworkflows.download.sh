workflows=(
  # gitignore
  https://github-production-release-asset-2e65be.s3.amazonaws.com/46873592/3ddd0d80-d8ec-11ea-865d-24c2f727538d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200826%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200826T145245Z&X-Amz-Expires=300&X-Amz-Signature=f0904a66b75c3efd551cf278fc6335f7fc76412b09f966abe5a69d5bea7ec8d5&X-Amz-SignedHeaders=host&actor_id=6839576&key_id=0&repo_id=46873592&response-content-disposition=attachment%3B%20filename%3Dgitignore.alfredworkflow&response-content-type=application%2Foctet-stream
  # open-in-vscode
  https://uc973e3a2fe2eb90b28648f10dc2.dl.dropboxusercontent.com/cd/0/get/A-M73XgfjhbIhJYIdwPf_b8tbQzr873cL-CXAhfL1IMmJMKF3TlaK232RAuo4lphQLlw3AYHs5yzcFaQTrATGsbGS9hlqOjUzqVmO9ioWfd0QPUgArYrwtsM-FRt7s3cXxA/file?_download_id=82193576724404044819380770320218520788343075701787451972513408331&_notify_domain=www.dropbox.com&dl=1
  # time zone
  https://raw.githubusercontent.com/jaroslawhartman/TimeZones-Alfred/master/TimeZones-v2.17.zip
  # kill-process
  https://raw.githubusercontent.com/ngreenstein/alfred-process-killer/master/Kill%20Process.alfredworkflow
  # pkg-manager
  https://raw.githubusercontent.com/willfarrell/alfred-pkgman-workflow/master/Package%20Managers.alfredworkflow
  # encode-decode
  https://raw.githubusercontent.com/willfarrell/alfred-encode-decode-workflow/master/encode-decode.alfredworkflow
  # qrcode
  https://raw.githubusercontent.com/cj1128/alfred-qrcode-workflow/master/QR-Code.alfredworkflow
  # devdocs
  https://raw.githubusercontent.com/packal/repository/master/com.yannickglt.alfred2.devdocs/devdocs.alfredworkflow
  # colors
  https://raw.githubusercontent.com/packal/repository/master/tylereich.colors/colors_v2.0.1.alfredworkflow
  # hash encode
  https://raw.githubusercontent.com/willfarrell/alfred-hash-workflow/master/Hash.alfredworkflow
  # nbbhhsh
  https://raw.githubusercontent.com/TheColdVoid/nbnhhsh/master/nbnhhsh.alfredworkflow
  # string case
  https://raw.githubusercontent.com/gillibrand/alfred-change-case/master/Change%20Case.alfredworkflow
  # toggle airpods
  https://raw.githubusercontent.com/jasonshanks/alfred-workflow-toggle-airpods/master/toggle-airpods.alfredworkflow
  # terminal-finder
  https://raw.githubusercontent.com/LeEnno/alfred-terminalfinder/master/TerminalFinder.alfredworkflow
  # switch apps
  https://github-production-release-asset-2e65be.s3.amazonaws.com/81984058/1a559a80-8496-11ea-86cf-ba21c5daf694?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200826%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200826T143937Z&X-Amz-Expires=300&X-Amz-Signature=b860ee646a1fc7008d96c2824999af85c876917fe9d24096224db59350ec2c31&X-Amz-SignedHeaders=host&actor_id=6839576&key_id=0&repo_id=81984058&response-content-disposition=attachment%3B%20filename%3DSwift.Window.Switcher.v0.3.6.alfredworkflow&response-content-type=application%2Foctet-stream
)

for workflow in ${workflows[@]}; do
  curl -s -O $workflow
done

npm install --global alfred-httpstat
npm install --global alfred-emoj
npm install -g alfred-google-translate
