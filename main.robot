*** Settings ***
Library    Browser
Library    Collections
Library    OperatingSystem
Library    String
Variables    ./config.py

*** Variables ***
@{HEADERS}=    Date    URL    Browser    Load Times    Average Load Time

*** Test Cases ***
Measure Page Load Time
    [Documentation]    This test measures the load time of a webpage and writes the results to a csv file.
    Create File For Results    ${OUTPUT_FILE}
    FOR   ${URL}    IN    @{PAGES}
        Log To Console    \nMeasuring page load time for: ${URL}
        @{load_times}=    Create List
        FOR  ${i}    IN RANGE    ${REPEAT}
            ${load_time}=    Measure Page Load Time    ${URL}
            Append To List    ${load_times}    ${load_time}
        END
        ${avg_load_time}=    Evaluate    sum(${load_times}) / len(${load_times})
        Log To Console    \nAverage page load time for ${URL}: ${avg_load_time} ms
        Write CSV Row    ${OUTPUT_FILE}    ${URL}    ${BROWSER}    ${load_times}    ${avg_load_time}
    END

*** Keywords ***
Measure Page Load Time
    [Documentation]    Measures the load time of a webpage.
    [Arguments]    ${URL}
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page
    ${start_time}=     Get Current Timestamp in Milliseconds
    Go To              ${URL}
    Wait For Load State    load
    ${end_time}=       Get Current Timestamp in Milliseconds
    ${load_time}=      Evaluate    ${end_time} - ${start_time}
    IF    ${SCREENSHOT}
        Take Screenshot    EMBED
    END
    Log To Console    \nPage load time: ${load_time} ms
    Close Browser
    RETURN    ${load_time}

Get Current Timestamp in Milliseconds
    [Documentation]    Returns the current timestamp in milliseconds.
    ${timestamp}=      Evaluate    int(__import__('time').time() * 1000)
    RETURN             ${timestamp}
    
Get Current DateTime
    [Documentation]    Returns the current date in the format 'YYYY-MM-DD HH:MM:SS'.
    ${current_date}=    Evaluate    __import__('datetime').datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    RETURN             ${current_date}

Write CSV Header
    [Documentation]    Writes the headers to the output csv file.
    [Arguments]        ${file}    @{headers}
    ${line}=           Catenate    SEPARATOR=;    @{headers}
    Append To File     ${CURDIR}/${file}    ${line}\n

Write CSV Row
    [Documentation]    Writes a row to the output csv file.
    [Arguments]        ${file}    @{row}
    Log To Console    \nWriting row to file: ${CURDIR}/${file}
    ${current_date}=    Get Current DateTime
    ${line}=           Catenate    SEPARATOR=;    @{row}
    ${line}=           Catenate    SEPARATOR=;    ${current_date}    ${line}
    Append To File     ${CURDIR}/${file}    ${line}\n

Create File For Results
    [Documentation]    Creates the output csv file and appends the headers.
    [Arguments]    ${file}
#    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file}
#    IF   not ${file_exists}
    Log To Console    \nOutput file does not exists, creating it now: ${CURDIR}/${file}
    Create File    ${CURDIR}/${file}
    Write CSV Header    ${file}    @{HEADERS}
#    ELSE
#        Log To Console    \nOutput file already exists: ${file}, appending test results
#    END
