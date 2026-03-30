-- ── CONFIGURAÇÃO DA BASE DE DADOS LIFELINK (SUPABASE) ───────────────────────────
-- Versão: 1.1 (Estável para Lançamento)
-- Aplicação: Mission Control (milestones_lifelink.html)

-- 1. Criação da Tabela de Marcos
CREATE TABLE IF NOT EXISTS milestones (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  title TEXT NOT NULL,
  category TEXT DEFAULT 'Geral',
  priority SMALLINT DEFAULT 1, -- 0: Baixa, 1: Média, 2: Alta, 3: Urgente
  status TEXT DEFAULT 'focus', -- 'focus', 'done'
  date DATE,
  author TEXT DEFAULT 'Equipa',
  "desc" TEXT
);

-- 2. Habilitação de Segurança (Row Level Security)
ALTER TABLE milestones ENABLE ROW LEVEL SECURITY;

-- 3. Criação de Política de Acesso Público (MVP/Lançamento)
-- Permite que qualquer pessoa com a 'anon key' possa ler, inserir e editar.
-- Importante para o funcionamento sem login inicial.
DROP POLICY IF EXISTS "Acesso Público" ON milestones;
CREATE POLICY "Acesso Público" ON milestones 
  FOR ALL 
  USING (true) 
  WITH CHECK (true);

-- 4. Nota sobre REALTIME (Ação Manual Obrigatória):
-- Para que as mudanças apareçam instantaneamente noutros ecrãs:
-- No Dashboard do Supabase, vai a: Database -> Replication -> supabase_realtime
-- E ativa (Toggle ON) para a tabela 'milestones'.
