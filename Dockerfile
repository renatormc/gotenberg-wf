FROM gotenberg/gotenberg:8
COPY fonts /usr/share/fonts/WindowsFonts
RUN fc-cache -fv
