package main

import (
	"errors"
	"log"
	"os"

	pd "github.com/PagerDuty/go-pagerduty"
	"github.com/nlopes/slack"
)

func main() {
	pdClient := pd.NewClient(os.Getenv("PD_TOKEN"))
	slackClient := slack.New(os.Getenv("SLACK_TOKEN"))
	handleError := func(err error) {
		params := slack.NewPostMessageParameters()
		params.Username = "@oncall sync"
		_, _, err1 := slackClient.PostMessage("pager-duty", err.Error(), params)
		if err1 != nil {
			log.Println(err1.Error())
		}
		log.Panicln(err)
	}

	var primary string
	var secondary string

	if eps, err := pdClient.ListOnCalls(pd.ListOnCallOptions{}); err != nil {
		handleError(err)
	} else {
		for _, oc := range eps.OnCalls {
			if oc.Schedule.Summary == "Primary Schedule" {
				if user, err := pdClient.GetUser(oc.User.ID, pd.GetUserOptions{}); err != nil {
					handleError(err)
				} else {
					primary = user.Email
				}
			}
			if oc.Schedule.Summary == "Secondary Schedule" {
				if user, err := pdClient.GetUser(oc.User.ID, pd.GetUserOptions{}); err != nil {
					handleError(err)
				} else {
					secondary = user.Email
				}
			}
		}
	}

	if primary == "" && secondary == "" {
		handleError(errors.New("unable not find any on call users"))
	}
	log.Println(primary, "/", secondary)

	slackUsers, err := slackClient.GetUsers()
	if err != nil {
		handleError(err)
	}
	var onCallUser *slack.User
	for i, user := range slackUsers {
		if primary != "" && user.Profile.Email == primary {
			onCallUser = &(slackUsers[i])
			break
		}
		if secondary != "" && user.Profile.Email == secondary {
			onCallUser = &(slackUsers[i])
		}
	}

	if onCallUser == nil {
		handleError(errors.New("could not find on call user in Slack"))
	}

	_, err = slackClient.UpdateUserGroupMembers(os.Getenv("ONCALL_GROUP"), onCallUser.ID)
	if err != nil {
		handleError(err)
	}
}
