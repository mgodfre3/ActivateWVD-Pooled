//Define Log Analytics parameters
param logAnalyticsWorkspaceName string
param logAnalyticslocation string = resourceGroup().location
param logAnalyticsWorkspaceSku string = 'pergb2018'
param hostpoolName string
param workspaceName string
param logAnalyticsResourceGroup string= resourceGroup().name
param wvdBackplaneResourceGroup string= resourceGroup().name

//Create Log Analytics Workspace
resource wvdla 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name : logAnalyticsWorkspaceName
  location : logAnalyticslocation
  properties : {
    sku: {
      name : logAnalyticsWorkspaceSku
    }
  }
}
