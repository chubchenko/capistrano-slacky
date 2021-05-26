# frozen_string_literal: true

en = {
  deployed_successfully: "Deployed successfully %{emoji}",
  reverted_successfully: "Reverted successfully %{emoji}",
  deployment_failed: "Deployment failed %{emoji}",
  rollback_failed: "Rollback failed %{emoji}",
  stage: ">*Stage:*",
  branch: ">*Branch:*",
  duration: ">*Duration:*",
  revision: "*Current* revision <%{repository_url}/commit/%{current}|%{current}> - " \
            "<%{repository_url}/compare/%{previous}...%{current}|compare> " \
            "(_previous revision was <%{repository_url}/commit/%{previous}|%{previous}>_).",
  nothing_has_changed_since_the_previous_release: "Nothing has changed since the previous release :confounded:.",
  something_went_wrong: "Something went wrong and we couldn't get the exception to display :sob:.",
  deployed_by: ":truck: Deployed By: @%{deployer}"
}

I18n.backend.store_translations(:en, capistrano: {
  slacky: en
})
