# PY_VERSION should be 3.X, not 3.X.X
ARG PY_VERSION=3.9

FROM python:$PY_VERSION-slim

ENV HOME="/DEEPTUMOUR"
ENV PATH="$HOME/src:$PATH"

# Create non-root user
RUN groupadd -r deeptumour && \
    useradd -r -g deeptumour deeptumour && \
    mkdir -m 777 $HOME

# Copy requirements & pip install
COPY --chmod=444 requirements $HOME/requirements
RUN pip install --no-cache-dir -r $HOME/requirements/requirements.txt

# Copy DeepTumour code & model
COPY --chmod=777 src $HOME/src

USER deeptumour
WORKDIR /WORKDIR
ENTRYPOINT [ "DeepTumour.py" ]
