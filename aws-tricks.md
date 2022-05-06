# AWS tricks

## Interact cognito CLI
```bash
aws cognito-idp sign-up --region xxx --client-id yyy --username zzz --password ppp

aws cognito-idp admin-confirm-sign-up --region xxx --user-pool-id uuu --username zzz

aws cognito-idp admin-initiate-auth --region ap-northeast-1 --cli-input-json file://auth.json

{
    "UserPoolId": "uuu",
    "ClientId": "yyy",
    "AuthFlow": "ALLOW_USER_SRP_AUTH",
    "AuthParameters": {
        "USERNAME": "zzz",
        "PASSWORD": "ppp"
    }
}
```

## Connect parameter store through vpc endpoint
- Link: https://purple.telstra.com.au/blog/ssm-endpoints-a-how-to
