Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02D27F1DA
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgI3S4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:56:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41972 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgI3S4N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:56:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A397B803073C;
        Wed, 30 Sep 2020 18:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZZG6uD7-iHxB; Wed, 30 Sep 2020 21:56:03 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 18/21] spi: dw: Introduce max mem-ops SPI bus frequency setting
Date:   Wed, 30 Sep 2020 21:55:42 +0300
Message-ID: <20200930185545.29959-19-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In some circumstances the current implementation of the SPI memory
operations may occasionally fail even though they are executed in the
atomic context. This may happen if the system bus is relatively slow in
comparison to the SPI bus frequency, or there is a concurrent access to
it, which makes the MMIO-operations occasionally stalling before
push-pulling data from the DW APB SPI FIFOs. These two problems we've
discovered on the Baikal-T1 SoC. In order to fix them we have no choice
but to set an artificial limitation on the SPI bus speed.

Note currently this limitation will be only applicable for the memory
operations, since the standard SPI core interface is implemented with an
assumption that there is no problem with the automatic CS toggling.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 4 +++-
 drivers/spi/spi-dw.h      | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index d1e8438433b8..cc217b0e588e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -629,7 +629,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * operation. Transmit-only mode is suitable for the rest of them.
 	 */
 	cfg.dfs = 8;
-	cfg.freq = mem->spi->max_speed_hz;
+	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
 	if (op->data.dir == SPI_MEM_DATA_IN) {
 		cfg.tmode = SPI_TMOD_EPROMREAD;
 		cfg.ndf = op->data.nbytes;
@@ -716,6 +716,8 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
 		dws->mem_ops.supports_op = dw_spi_supports_mem_op;
 		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
+		if (!dws->max_mem_freq)
+			dws->max_mem_freq = dws->max_freq;
 	}
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 4b08fe34a85d..dc5781236cc6 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -148,6 +148,7 @@ struct dw_spi {
 	unsigned long		paddr;
 	int			irq;
 	u32			fifo_len;	/* depth of the FIFO buffer */
+	u32			max_mem_freq;	/* max mem-ops bus freq */
 	u32			max_freq;	/* max bus freq supported */
 
 	u32			caps;		/* DW SPI capabilities */
-- 
2.27.0

