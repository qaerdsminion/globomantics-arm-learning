param resourceGroupName string
param location string

targetScope = 'subscription'

resource resourceGroup 'microsoft.resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
