@secure()
param adminPassword string

@description('Enter the loaction to deploy to')
param location string

resource ubuntuVM1_VirtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'ubuntuVM1-VirtualNetwork'
  location: location
  tags: {
    displayName: 'ubuntuVM1-VirtualNetwork'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'ubuntuVM1-VirtualNetwork-Subnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

resource ubuntuVM1_NetworkInterface 'Microsoft.Network/networkInterfaces@2019-11-01' = {
  name: 'ubuntuVM1-NetworkInterface'
  location: location
  tags: {
    displayName: 'ubuntuVM1-NetworkInterface'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'ubuntuVM1-VirtualNetwork', 'ubuntuVM1-VirtualNetwork-Subnet')
          }
        }
      }
    ]
  }
  dependsOn: [
    ubuntuVM1_VirtualNetwork
  ]
}

resource ubuntuVM1 'Microsoft.Compute/virtualMachines@2019-07-01' = {
  name: 'ubuntuVM1'
  location: location
  tags: {
    displayName: 'ubuntuVM1'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_A2_v2'
    }
    osProfile: {
      computerName: 'ubuntuVM1'
      adminUsername: 'azureadmin'
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        name: 'ubuntuVM1-OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: ubuntuVM1_NetworkInterface.id
        }
      ]
    }
  }
}