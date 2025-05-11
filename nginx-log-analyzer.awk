BEGIN {
    ip_pattern        = "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}"
    date_pattern      = "\\[[^]]+\\]"
    quotes_pattern    = "\"[^\"]+\""
    number_pattern    = "[0-9]+"

    # Ref: https://www.gnu.org/software/gawk/manual/html_node/Splitting-By-Content.html
    FPAT = ip_pattern "|" date_pattern "|" quotes_pattern "|" number_pattern

    extracted_fields[1] = "IP address"
    extracted_fields[2] = "Date and time"
    extracted_fields[3] = "Request method and path"
    extracted_fields[4] = "Response status code"
    extracted_fields[5] = "Response size"
    extracted_fields[6] = "Referrer"
    extracted_fields[7] = "User agent"
}

{
    # Uncomment for debugging:
    # print("NF = ", NF)
    # for (i = 1; i <= NF; i++) {
    #     printf("%s: %s\n", extracted_fields[i], $i)
    # }
    # print("---")

    ip_count[$1]++
    request_path_count[$3]++
    response_status_code_count[$4]++
    user_agent_count[$7]++
}

END {
    print_top_5("IP addresses", ip_count)
    print_top_5("requested paths", request_path_count)
    print_top_5("response status codes", response_status_code_count)
    print_top_5("user agents", user_agent_count)
}

function print_top_5(subject, subject_count) {
    printf("Top 5 %s:\n", subject)

    # https://www.gnu.org/software/gawk/manual/html_node/Controlling-Scanning.html
    n = asorti(subject_count, sorted_subject, "@val_num_desc")
    for (i = 1; i <= (n > 5 ? 5 : n); i++) {
        printf("%s - %s requests\n", sorted_subject[i], subject_count[sorted_subject[i]])
    }
    print("\n")
}
