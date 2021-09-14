targetScope = 'subscription'

@description('Enter the location of the Resource Group')
param location string = 'West Europe'

@description('Enter the name of the Resource Group')
param resourceGroupName string = 'AxelDevOpsTesting'

resource resourceGroupName_resource 'Microsoft.Resources/resourceGroups@2019-10-01' = {
  name: resourceGroupName
  location: location
  tags: {}
  dependsOn: []
}