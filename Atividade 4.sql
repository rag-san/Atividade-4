
CREATE TABLE perfil_acesso (
    id_perfil SERIAL PRIMARY KEY,
    nome_perfil VARCHAR(30) UNIQUE NOT NULL

);
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL, 
    id_perfil INT NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_perfil) REFERENCES perfil_acesso(id_perfil)
);
CREATE TABLE paciente (
    id_paciente SERIAL PRIMARY KEY,
    nome_completo VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    id_usuario INT UNIQUE, 
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);
CREATE TABLE medico (
    id_medico SERIAL PRIMARY KEY,
    nome_completo VARCHAR(100) NOT NULL,
    numero_crm VARCHAR(20) UNIQUE NOT NULL,
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);
CREATE TABLE especialidade (
    id_especialidade SERIAL PRIMARY KEY,
    nome_especialidade VARCHAR(60) UNIQUE NOT NULL
);
CREATE TABLE medico_especialidade (
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    PRIMARY KEY (id_medico, id_especialidade),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico) ON DELETE CASCADE,
    FOREIGN KEY (id_especialidade) REFERENCES especialidade(id_especialidade) ON DELETE CASCADE
);
CREATE TABLE consulta (
    id_consulta SERIAL PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_consulta DATE NOT NULL,
    horario_consulta TIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Agendada',
    data_agendamento TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);
CREATE TABLE atendimento (
    id_atendimento SERIAL PRIMARY KEY,
    id_consulta INT UNIQUE NOT NULL,
    diagnostico TEXT,
    observacoes TEXT,
    data_registro TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta) ON DELETE CASCADE
);
CREATE INDEX idx_consulta_data ON consulta(data_consulta, horario_consulta);
CREATE INDEX idx_consulta_status ON consulta(status);
CREATE INDEX idx_paciente_cpf ON paciente(cpf);
CREATE INDEX idx_paciente_nome ON paciente(nome_completo);
CREATE INDEX idx_medico_nome ON medico(nome_completo);

INSERT INTO perfil_acesso (nome_perfil) VALUES 
('Administrador'), ('Médico'), ('Secretária'), ('Paciente');