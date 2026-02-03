Feature: Tenant Onboarding
In order to use the treasury management system
As a new corporate client
I want to register my company as a tenant

Scenario: Successful Tenant Registration
Given I have a company named "Acme Corp"
When I submit the registration with a valid admin email "admin@acme.com"
Then a new Tenant should be created with a unique UUID v7
And a "TenantCreated" event should be persisted to the EventStore
And the Tenant should be initialized with a default "USD" wallet
