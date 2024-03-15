# *Primeiro estágio*: definir imagem base
FROM golang:1.22 as build

# Definir diretório de trabalho/destino
WORKDIR /go/src/app

# Transferir dependências para o diretório de trabalho
COPY go.mod ./
COPY main.go ./

# Build da aplicação (gera binário e executa (-o -> executável))
RUN go build -o /first-app

# *Segundo estágio*: criar o container final

# scratch sendo utilizada como base apenas para deixar a imagem o mais leve possível.
# outra possibilidade: https://github.com/GoogleContainerTools/distroless

FROM scratch

WORKDIR /

COPY --from=build /first-app /first-app

ENTRYPOINT ["/first-app" ]