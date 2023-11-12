@description('The AzureWebSites name of your Web Site (some random text will be added at the end for uniqueness)')
param siteName string = 'DasBlog'

@description('The name of the hosting plan to deploy to. If the plan doesn\'t exist, it will be created')
param hostingPlan string = 'DasBlogHosting'

@description('The pricing tier for the hosting plan.')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P4'
])
param sku string = 'B1'

@description('The instance size of the hosting plan (small, medium, or large).')
@allowed([
  '0'
  '1'
  '2'
])
param workerSize string = '0'

@description('The URL for the GitHub repository that contains the project to deploy.')
param repoURL string = 'https://github.com/poppastring/dasblog-core.git'

@description('The branch of the GitHub repository to use.')
param branch string = 'main'

var siteName_var = toLower('${siteName}-${uniqueString(resourceGroup().id)}')
var hostingPlanName = hostingPlan
var location = resourceGroup().location
var netFrameworkVersion = 'v6.0'
var use32BitWorkerProcess = false

resource hostingPlan_resource 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: sku
    capacity: 0
  }
  properties: {
    name: hostingPlanName
  }
}

resource site 'Microsoft.Web/sites@2022-09-01' = {
  name: siteName_var
  location: location
  properties: {
    serverFarmId: hostingPlan_resource.id
    httpsOnly: true
    siteConfig: {
      netFrameworkVersion: netFrameworkVersion
      use32BitWorkerProcess: use32BitWorkerProcess
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
      ]
    }
  }
}

// resource siteName_web 'Microsoft.Web/sites/sourcecontrols@2022-09-01' = {
//   parent: site
//   name: 'web'
//   properties: {
//     repoUrl: repoURL
//     branch: branch
//     isManualIntegration: true
//   }
//   dependsOn: [
//     hostingPlan_resource
//   ]
// }
