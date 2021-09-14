param resourceGroupName string
param location string

targetscope = 'subscription'

resource subscription 'microsoft.resources/subscription@2021-04-01' = {
  name: resourceGroupName
  location: location
}
