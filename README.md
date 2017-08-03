## Getting Started With Azure Domain Transfer from registrar

## Prerequisites

The domain must be older than 60 days and unlocked.

## Get the authorization code from your registrar

Go to yout regsitrar and get the transfer authorization code.
:bulb Check that the domain is unlocked for transfer.

## Execute the transfer

* Close all other PowerShell windows and start a new one as an administrator.
* Navigate to the script directory and run the PS script:
```
cd "C:\...\azure-domain-transfer"
.\DomainTransfer.ps1
```

## Confirm the transfer

When you get the confirmation email. Click the confirmation button
Now you have to wait up to 5-7 days for the transfer to be complete.

## Accept the transfer from your registrar (if you can)

Some registrar let the owner of the domain cancel or confirm the transfer. It allows the operation to be completed before the 5-7 days.

## Wait for the transfer to be complete 

Wait and check the resource to be fullly available in you Azure portal.

