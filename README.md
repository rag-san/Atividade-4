🏥 Sistema de Gestão Hospitalar – Banco de Dados

Este repositório contém a modelagem e os scripts SQL do banco de dados para um Sistema de Gestão Hospitalar, responsável por controlar usuários, pacientes, médicos, especialidades, consultas e atendimentos.

O banco foi projetado para garantir integridade referencial, segurança de acesso e bom desempenho em consultas frequentes.

📌 Visão Geral do Sistema

O sistema permite:

Gerenciamento de usuários com diferentes perfis de acesso

Cadastro de pacientes e médicos

Associação de médicos a múltiplas especialidades

Agendamento e controle de consultas

Registro de atendimentos médicos

Controle de permissões através de perfil de acesso

🗂 Estrutura do Banco de Dados
🔐 Tabela: perfil_acesso

Armazena os perfis de usuários do sistema.

Campo	Tipo	Descrição
id_perfil	SERIAL (PK)	Identificador do perfil
nome_perfil	VARCHAR(30)	Nome do perfil (Administrador, Médico, etc.)
👤 Tabela: usuario

Armazena os usuários do sistema.

Campo	Tipo	Descrição
id_usuario	SERIAL (PK)	Identificador do usuário
login	VARCHAR(50)	Login único
senha	VARCHAR(255)	Senha criptografada
id_perfil	INT (FK)	Perfil de acesso
ativo	BOOLEAN	Indica se o usuário está ativo
🧑‍🦱 Tabela: paciente

Armazena os dados dos pacientes.

Campo	Tipo	Descrição
id_paciente	SERIAL (PK)	Identificador do paciente
nome_completo	VARCHAR(100)	Nome completo
cpf	VARCHAR(11)	CPF único
telefone	VARCHAR(20)	Telefone de contato
data_nascimento	DATE	Data de nascimento
id_usuario	INT (FK)	Usuário relacionado

Cada paciente pode possuir um usuário no sistema.

👨‍⚕️ Tabela: medico

Armazena os dados dos médicos.

Campo	Tipo	Descrição
id_medico	SERIAL (PK)	Identificador do médico
nome_completo	VARCHAR(100)	Nome completo
numero_crm	VARCHAR(20)	CRM único
id_usuario	INT (FK)	Usuário vinculado
🧠 Tabela: especialidade

Armazena as especialidades médicas.

Campo	Tipo	Descrição
id_especialidade	SERIAL (PK)	Identificador
nome_especialidade	VARCHAR(60)	Nome da especialidade
🔗 Tabela: medico_especialidade

Relacionamento N:N entre médicos e especialidades.

Campo	Tipo
id_medico	INT (FK)
id_especialidade	INT (FK)
📅 Tabela: consulta

Armazena os agendamentos de consultas.

Campo	Tipo	Descrição
id_consulta	SERIAL (PK)	Identificador
id_paciente	INT (FK)	Paciente
id_medico	INT (FK)	Médico
data_consulta	DATE	Data
horario_consulta	TIME	Horário
status	VARCHAR(20)	Situação da consulta
data_agendamento	TIMESTAMP	Data do agendamento

Status padrão: Agendada

📝 Tabela: atendimento

Armazena os dados do atendimento médico.

Campo	Tipo	Descrição
id_atendimento	SERIAL (PK)	Identificador
id_consulta	INT (FK, UNIQUE)	Consulta atendida
diagnostico	TEXT	Diagnóstico
observacoes	TEXT	Observações
data_registro	TIMESTAMP	Registro do atendimento
⚡ Índices Criados

Para melhorar a performance do banco, foram criados índices nos seguintes campos:

Data e horário da consulta

Status da consulta

CPF do paciente

Nome do paciente

Nome do médico

👥 Perfis de Acesso Inseridos

Perfis cadastrados por padrão:

Administrador

Médico

Secretária

Paciente

INSERT INTO perfil_acesso (nome_perfil) VALUES 
('Administrador'), ('Médico'), ('Secretária'), ('Paciente');

🛠 Tecnologias Utilizadas

PostgreSQL

SQL padrão

Modelagem relacional com chaves primárias e estrangeiras
