# gawk-log-analyzer
- Analyzes logs using [`gawk`](https://www.gnu.org/software/gawk/)

### Requirements
See: https://roadmap.sh/projects/nginx-log-analyser

### Running the script
##### 0. Install `gawk`
```bash
brew install gawk
```

##### 1. Download the sample log file

```bash
curl -X GET \
https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log \
-o resources/nginx-access.log
```

##### 2. Run the script
```bash
gawk
```
