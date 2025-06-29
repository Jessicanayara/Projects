-- VISÃO ESTRATÉGICA - DIRETORA DE PERFORMANCE

-- View de margem por produto
CREATE OR REPLACE VIEW vw_produto_margem AS
SELECT
    nome_cliente AS nome_cliente_view,
    numero_nota_fiscal AS numero_nota_fiscal_view,
    produto_name AS produto_name_view,
    valor_final AS valor_final_view,
    (valor_unitario * quantidade_produto) AS custo_total_view,
    ROUND(((valor_final - (valor_unitario * quantidade_produto)) / (valor_unitario * quantidade_produto)) * 100, 0) AS margem_view
FROM mock_data;

-- View de desempenho por cliente
CREATE OR REPLACE VIEW vw_cliente_compras AS
SELECT
    nome_cliente AS nome_cliente_view,
    COUNT(DISTINCT numero_nota_fiscal) AS total_compra_view,
    SUM(valor_final) AS valor_tot_view
FROM mock_data
GROUP BY nome_cliente;

-- Análise cruzada: clientes que compraram produtos com margem > 50%
SELECT
    pm.nome_cliente_view,
    cc.valor_tot_view,
    pm.margem_view || '%' AS margem
FROM vw_produto_margem pm
INNER JOIN vw_cliente_compras cc ON pm.nome_cliente_view = cc.nome_cliente_view
WHERE pm.margem_view > 50;
