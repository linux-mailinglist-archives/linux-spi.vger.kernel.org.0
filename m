Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043391E741C
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 06:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgE2EAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 00:00:15 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45410 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389579AbgE2D7o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B29FE8029EA1;
        Fri, 29 May 2020 03:59:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W0w-AkINMplP; Fri, 29 May 2020 06:59:42 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 15/16] spi: dw: Use regset32 DebugFS method to create regdump file
Date:   Fri, 29 May 2020 06:59:13 +0300
Message-ID: <20200529035915.20790-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DebugFS kernel interface provides a dedicated method to create the
registers dump file. Use it instead of creating a generic DebugFS
file with manually written read callback function.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v3:
- Add commas in the debugfs_reg32 structure initializer and after the last
  item of the array dw_spi_dbgfs_regs.
---
 drivers/spi/spi-dw-core.c | 86 ++++++++++++---------------------------
 drivers/spi/spi-dw.h      |  2 +
 2 files changed, 28 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 4d1849699a12..323c66c5db50 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -29,66 +29,29 @@ struct chip_data {
 };
 
 #ifdef CONFIG_DEBUG_FS
-#define SPI_REGS_BUFSIZE	1024
-static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
-		size_t count, loff_t *ppos)
-{
-	struct dw_spi *dws = file->private_data;
-	char *buf;
-	u32 len = 0;
-	ssize_t ret;
-
-	buf = kzalloc(SPI_REGS_BUFSIZE, GFP_KERNEL);
-	if (!buf)
-		return 0;
-
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"%s registers:\n", dev_name(&dws->master->dev));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"=================================\n");
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"CTRLR0: \t0x%08x\n", dw_readl(dws, DW_SPI_CTRLR0));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"CTRLR1: \t0x%08x\n", dw_readl(dws, DW_SPI_CTRLR1));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"SSIENR: \t0x%08x\n", dw_readl(dws, DW_SPI_SSIENR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"SER: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SER));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"BAUDR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_BAUDR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"TXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_TXFTLR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"RXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_RXFTLR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"TXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_TXFLR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"RXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_RXFLR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"SR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"IMR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_IMR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"ISR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_ISR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"DMACR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_DMACR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"DMATDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMATDLR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"DMARDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMARDLR));
-	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
-			"=================================\n");
-
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
-	kfree(buf);
-	return ret;
+
+#define DW_SPI_DBGFS_REG(_name, _off)	\
+{					\
+	.name = _name,			\
+	.offset = _off,			\
 }
 
-static const struct file_operations dw_spi_regs_ops = {
-	.owner		= THIS_MODULE,
-	.open		= simple_open,
-	.read		= dw_spi_show_regs,
-	.llseek		= default_llseek,
+static const struct debugfs_reg32 dw_spi_dbgfs_regs[] = {
+	DW_SPI_DBGFS_REG("CTRLR0", DW_SPI_CTRLR0),
+	DW_SPI_DBGFS_REG("CTRLR1", DW_SPI_CTRLR1),
+	DW_SPI_DBGFS_REG("SSIENR", DW_SPI_SSIENR),
+	DW_SPI_DBGFS_REG("SER", DW_SPI_SER),
+	DW_SPI_DBGFS_REG("BAUDR", DW_SPI_BAUDR),
+	DW_SPI_DBGFS_REG("TXFTLR", DW_SPI_TXFTLR),
+	DW_SPI_DBGFS_REG("RXFTLR", DW_SPI_RXFTLR),
+	DW_SPI_DBGFS_REG("TXFLR", DW_SPI_TXFLR),
+	DW_SPI_DBGFS_REG("RXFLR", DW_SPI_RXFLR),
+	DW_SPI_DBGFS_REG("SR", DW_SPI_SR),
+	DW_SPI_DBGFS_REG("IMR", DW_SPI_IMR),
+	DW_SPI_DBGFS_REG("ISR", DW_SPI_ISR),
+	DW_SPI_DBGFS_REG("DMACR", DW_SPI_DMACR),
+	DW_SPI_DBGFS_REG("DMATDLR", DW_SPI_DMATDLR),
+	DW_SPI_DBGFS_REG("DMARDLR", DW_SPI_DMARDLR),
 };
 
 static int dw_spi_debugfs_init(struct dw_spi *dws)
@@ -100,8 +63,11 @@ static int dw_spi_debugfs_init(struct dw_spi *dws)
 	if (!dws->debugfs)
 		return -ENOMEM;
 
-	debugfs_create_file("registers", S_IFREG | S_IRUGO,
-		dws->debugfs, (void *)dws, &dw_spi_regs_ops);
+	dws->regset.regs = dw_spi_dbgfs_regs;
+	dws->regset.nregs = ARRAY_SIZE(dw_spi_dbgfs_regs);
+	dws->regset.base = dws->regs;
+	debugfs_create_regset32("registers", 0400, dws->debugfs, &dws->regset);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 0b2cd7994513..151ba316619e 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -3,6 +3,7 @@
 #define DW_SPI_HEADER_H
 
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
@@ -152,6 +153,7 @@ struct dw_spi {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
+	struct debugfs_regset32 regset;
 #endif
 };
 
-- 
2.26.2

