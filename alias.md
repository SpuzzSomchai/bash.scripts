# Aliasing commands

Sometimes I want to get my IP Address but it gives me so much info when I enter `ifconfig` that the part with the IP Address that I want is out of view.

## Craete Alias

```bash
alias myip="echo $(ifconfig | grep broadcast | awk '{print $2}')"
```
