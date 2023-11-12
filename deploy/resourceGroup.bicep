param location string = 'North Europe'

targetScope = 'subscription'

resource symbolicname 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-furholt-bach-bicep-ne-001'
  location: location
  tags: {
    tagName1: 'bicep-iac'
  }
  properties: {}
}
