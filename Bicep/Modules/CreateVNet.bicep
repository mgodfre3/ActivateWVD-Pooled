//parameters
param nameprefix string='ActivateWVD_'

var vnets = [
  {
    name: '${nameprefix}{vnet}' 
    addressPrefix: '10.1.0.0/24'
    subnets: [
      {
        name: '${nameprefix}{SessionHosts_Default}'
        subnetPrefix: '10.1.0.0/26'
      }
      {
        name: 'SessionHost_Validation'
        subnetPrefix: '10.1.0.64/26'
      }
      {
        name: 'SessionHost_Production'
        subnetPrefix: '10.1.0.128/26'
      }
    ]
  }
 ]

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = [for vnet in vnets: {
  name: vnet.name
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet.addressPrefix
      ]
    }
    subnets: [for subnet in vnet.subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
      }
    }]
  } 
  } ]
