// file: create-ea-subscription.bicep
targetScope = 'tenant'

@description('Friendly name of the new subscription')
param subscriptionDisplayName string

@description('EA Enrollment Account GUID (from `az billing enrollment-account list`)')
param enrollmentAccountName string

resource subAlias 'Microsoft.Subscription/aliases@2024-08-01-preview' = {
  name: subscriptionDisplayName
  properties: {
    displayName: subscriptionDisplayName
    workload: 'Production' // or 'DevTest'
    billingScope: '/providers/Microsoft.Billing/enrollmentAccounts/${enrollmentAccountName}'
  }
}

output subscriptionId string = subAlias.properties.subscriptionId
