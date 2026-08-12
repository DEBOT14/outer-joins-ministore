
-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: Deborah Torre
-- Fecha: 2026-08-12
-- ══════════════════════════════════════════

-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
-- Filtramos por ventas.venta_id IS NULL para aislar los productos sin ventas.

SELECT 
    p.producto_id,
    p.nombre AS producto_catalogo,
    p.categoria,
    v.venta_id,
    v.cantidad
FROM productos p
LEFT JOIN ventas v ON p.producto_id = v.producto_id
WHERE v.venta_id IS NULL;


-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo? (posible error de carga de datos)
-- Filtramos por productos.producto_id IS NULL para detectar la venta huérfana.

SELECT 
    v.venta_id,
    v.producto_id AS id_producto_en_venta,
    v.cantidad,
    v.fecha_venta,
    p.nombre AS nombre_en_catalogo
FROM productos p
RIGHT JOIN ventas v ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL;


-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre
-- todos los productos y todas las ventas sin perder ninguna fila.

SELECT 
    p.producto_id AS prod_id_catalogo,
    p.nombre AS producto,
    v.venta_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
FULL OUTER JOIN ventas v ON p.producto_id = v.producto_id;