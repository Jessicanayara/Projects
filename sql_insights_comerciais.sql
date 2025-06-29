-- CENÁRIOS - GERENTE COMERCIAL

-- 1. Top 5 produtos mais vendidos
SELECT * FROM (
    SELECT produto_name, SUM(quantidade_produto) AS quantidade_produto
    FROM mock_data
    GROUP BY produto_name
    ORDER BY quantidade_produto DESC
)
WHERE ROWNUM <= 5;

-- 2. Clientes com mais de R$10.000
SELECT nome_cliente, SUM(valor_final) AS valor_final
FROM mock_data
GROUP BY nome_cliente
HAVING SUM(valor_final) > 10000
ORDER BY valor_final DESC;

-- 3. Maiores descontos aplicados
SELECT produto_name, valor_desconto,
       TO_CHAR(ROUND((valor_desconto / valor_unitario) * 100)) || '%' AS percentual_desc
FROM mock_data
ORDER BY valor_desconto DESC;

-- 4. Produtos vencidos
SELECT produto_name, produto_expiration_date,
       CASE WHEN produto_expiration_date < TO_DATE('01/01/2023', 'DD/MM/YYYY') THEN 'VENCEU'
            ELSE 'NÃO VENCEU' END AS produto_vencido
FROM mock_data
ORDER BY produto_vencido DESC;

-- 5. Categoria com maior receita
SELECT produto_category, TRUNC(ROUND(SUM(valor_final), 2), 1) AS valor
FROM mock_data
GROUP BY produto_category
ORDER BY valor DESC;

-- 6. Clientes com mais de uma compra
SELECT * FROM (
    SELECT COUNT(numero_nota_fiscal) AS quant_compra, nome_cliente
    FROM mock_data
    GROUP BY nome_cliente
)
WHERE quant_compra > 1;

-- 7. Produtos vendidos abaixo do custo
SELECT produto_name, valor_final
FROM (
    SELECT (valor_unitario * quantidade_produto) AS total, produto_name, valor_final
    FROM mock_data
)
WHERE total > valor_final;

-- 8. Dados de vendas do mês passado
SELECT nome_cliente, SUM(valor_final) AS total_cliente
FROM mock_data
WHERE data_emissao BETWEEN TO_DATE('01/01/2022', 'DD/MM/YYYY') AND TO_DATE('30/01/2022', 'DD/MM/YYYY')
GROUP BY nome_cliente
ORDER BY total_cliente DESC
FETCH FIRST 1 ROWS ONLY;

