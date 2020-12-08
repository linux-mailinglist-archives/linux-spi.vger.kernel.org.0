Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54D2D24E0
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 08:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgLHHpd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 02:45:33 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42930 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbgLHHp0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 02:45:26 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_3_hLs9fTZ8aAA--.48083S2;
        Tue, 08 Dec 2020 15:44:33 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
Subject: [PATCH v2 1/4] spi: LS7A: Add Loongson LS7A SPI controller driver support
Date:   Tue,  8 Dec 2020 15:44:24 +0800
Message-Id: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx_3_hLs9fTZ8aAA--.48083S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw1xJrWUJr4xZFW8GryfJFb_yoWDZrykpF
        48W3yrta18JFyrAFZrJF48WFyYqw1Sq34Fq3ySqw1xKa4YqF4DWF1rXryfJrZxXFW7uFyU
        WFnFgrW5KF45ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
        IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JU9o7NUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI controller has the following characteristics:

- Full-duplex synchronous serial data transmission
- Support up to 4 variable length byte transmission
- Main mode support
- Mode failure generates an error flag and issues an interrupt request
- Double buffer receiver
- Serial clock with programmable polarity and phase
- SPI can be controlled in wait mode
- Support boot from SPI

Use mtd_debug tool to earse/write/read /dev/mtd0 on development.

eg:

[root@linux mtd-utils-1.0.0]# mtd_debug erase /dev/mtd0 0x20000 0x40000
Erased 262144 bytes from address 0x00020000 in flash
[root@linux mtd-utils-1.0.0]# mtd_debug write /dev/mtd0 0x20000 13 1.img
Copied 13 bytes from 1.img to address 0x00020000 in flash
[root@linux mtd-utils-1.0.0]# mtd_debug read /dev/mtd0 0x20000 13 2.img
Copied 13 bytes from address 0x00020000 in flash to 2.img
[root@linux mtd-utils-1.0.0]# cmp -l 1.img 2.img

Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v2:
- keep Kconfig and Makefile sorted
- make the entire comment a C++ one so things look more intentional
- Fix unclear indentation
- make conditional statements to improve legibility
- Don't use static inline
- the core handle message queue
- Add a new binding document
- Fix probe part mixed pdev and PCI
---
 drivers/spi/Kconfig    |   7 ++
 drivers/spi/Makefile   |   1 +
 drivers/spi/spi-ls7a.c | 324 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 drivers/spi/spi-ls7a.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index aadaea0..af7c0d4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -413,6 +413,13 @@ config SPI_LP8841_RTC
 	  Say N here unless you plan to run the kernel on an ICP DAS
 	  LP-8x4x industrial computer.
 
+config SPI_LS7A
+	tristate "Loongson LS7A SPI Controller Support"
+	depends on CPU_LOONGSON64 || COMPILE_TEST
+	help
+	  This drivers supports the Loongson LS7A SPI controller in master
+	  SPI mode.
+
 config SPI_MPC52xx
 	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
 	depends on PPC_MPC52xx
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea582..d015cf2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
 obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
+obj-$(CONFIG_SPI_LS7A)			+= spi-ls7a.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
diff --git a/drivers/spi/spi-ls7a.c b/drivers/spi/spi-ls7a.c
new file mode 100644
index 0000000..21ca1ab
--- /dev/null
+++ b/drivers/spi/spi-ls7a.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Loongson LS7A SPI Controller driver
+ *
+ * Copyright (C) 2020 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+
+/* define spi register */
+#define	SPCR	0x00
+#define	SPSR	0x01
+#define	FIFO	0x02
+#define	SPER	0x03
+#define	PARA	0x04
+#define	SFCS	0x05
+#define	TIMI	0x06
+
+struct ls7a_spi {
+	spinlock_t lock;
+	struct spi_master *master;
+	void __iomem *base;
+	int cs_active;
+	unsigned int hz;
+	unsigned char spcr, sper;
+	unsigned int mode;
+};
+
+static void ls7a_spi_write_reg(struct ls7a_spi *spi,
+			       unsigned char reg,
+			       unsigned char data)
+{
+	writeb(data, spi->base + reg);
+}
+
+static char ls7a_spi_read_reg(struct ls7a_spi *spi,
+			      unsigned char reg)
+{
+	return readb(spi->base + reg);
+}
+
+static int set_cs(struct ls7a_spi *ls7a_spi, struct spi_device  *spi, int val)
+{
+	int cs = ls7a_spi_read_reg(ls7a_spi, SFCS) & ~(0x11 << spi->chip_select);
+
+	if (spi->mode  & SPI_CS_HIGH)
+		val = !val;
+	ls7a_spi_write_reg(ls7a_spi, SFCS,
+		(val ? (0x11 << spi->chip_select):(0x1 << spi->chip_select)) | cs);
+
+	return 0;
+}
+
+static int ls7a_spi_do_transfer(struct ls7a_spi *ls7a_spi,
+				struct spi_device *spi,
+				struct spi_transfer *t)
+{
+	unsigned int hz;
+	unsigned int div, div_tmp;
+	unsigned int bit;
+	unsigned long clk;
+	unsigned char val;
+	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
+
+	if (t) {
+		hz = t->speed_hz;
+		if (!hz)
+			hz = spi->max_speed_hz;
+	} else
+		hz = spi->max_speed_hz;
+
+	if (((spi->mode ^ ls7a_spi->mode) & (SPI_CPOL | SPI_CPHA))
+		|| (hz && ls7a_spi->hz != hz)) {
+		clk = 100000000;
+
+		div = DIV_ROUND_UP(clk, hz);
+		if (div < 2)
+			div = 2;
+		if (div > 4096)
+			div = 4096;
+
+		bit = fls(div) - 1;
+		if ((1<<bit) == div)
+			bit--;
+		div_tmp = rdiv[bit];
+
+		dev_dbg(&spi->dev, "clk = %ld hz = %d div_tmp = %d bit = %d\n",
+			clk, hz, div_tmp, bit);
+
+		ls7a_spi->hz = hz;
+		ls7a_spi->spcr = div_tmp & 3;
+		ls7a_spi->sper = (div_tmp >> 2) & 3;
+
+		val = ls7a_spi_read_reg(ls7a_spi, SPCR);
+		val &= ~0xc;
+		if (spi->mode & SPI_CPOL)
+			val |= 8;
+		if (spi->mode & SPI_CPHA)
+			val |= 4;
+		ls7a_spi_write_reg(ls7a_spi, SPCR, (val & ~3) | ls7a_spi->spcr);
+		val = ls7a_spi_read_reg(ls7a_spi, SPER);
+		ls7a_spi_write_reg(ls7a_spi, SPER, (val & ~3) | ls7a_spi->sper);
+		ls7a_spi->mode = spi->mode;
+	}
+	return 0;
+}
+
+static int ls7a_spi_setup(struct spi_device *spi)
+{
+	struct ls7a_spi *ls7a_spi;
+
+	ls7a_spi = spi_master_get_devdata(spi->master);
+
+	if (spi->chip_select >= spi->master->num_chipselect)
+		return -EINVAL;
+
+	set_cs(ls7a_spi, spi, 1);
+
+	return 0;
+}
+
+static int ls7a_spi_write_read_8bit(struct spi_device *spi,
+				    const u8 **tx_buf, u8 **rx_buf,
+				    unsigned int num)
+{
+	struct ls7a_spi *ls7a_spi;
+
+	ls7a_spi = spi_master_get_devdata(spi->master);
+
+	if (tx_buf && *tx_buf) {
+		ls7a_spi_write_reg(ls7a_spi, FIFO, *((*tx_buf)++));
+
+		while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x1) == 1)
+			;
+	} else {
+		ls7a_spi_write_reg(ls7a_spi, FIFO, 0);
+
+		while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x1) == 1)
+			;
+	}
+
+	if (rx_buf && *rx_buf)
+		*(*rx_buf)++ = ls7a_spi_read_reg(ls7a_spi, FIFO);
+	else
+		ls7a_spi_read_reg(ls7a_spi, FIFO);
+
+	return 1;
+}
+
+static unsigned int ls7a_spi_write_read(struct spi_device *spi,
+					struct spi_transfer *xfer)
+{
+	struct ls7a_spi *ls7a_spi;
+	unsigned int count;
+	const u8 *tx = xfer->tx_buf;
+	u8 *rx = xfer->rx_buf;
+
+	ls7a_spi = spi_master_get_devdata(spi->master);
+	count = xfer->len;
+
+	do {
+		if (ls7a_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
+			goto out;
+		count--;
+	} while (count);
+
+out:
+	return xfer->len - count;
+}
+
+static int  ls7a_spi_transfer_one_message(struct spi_master *master,
+					  struct spi_message *m)
+{
+	struct ls7a_spi *ls7a_spi;
+	struct spi_device *spi;
+	struct spi_transfer *t = NULL;
+	int param, status, r;
+	unsigned int total_len = 0;
+	unsigned int cs_change;
+	const int nsecs = 50;
+
+	ls7a_spi = spi_master_get_devdata(master);
+	spi = m->spi;
+
+	cs_change = 1;
+
+	spin_lock(&ls7a_spi->lock);
+	param = ls7a_spi_read_reg(ls7a_spi, PARA);
+	ls7a_spi_write_reg(ls7a_spi, PARA, param&~1);
+	spin_unlock(&ls7a_spi->lock);
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (cs_change) {
+			set_cs(ls7a_spi, spi, 0);
+			ls7a_spi_do_transfer(ls7a_spi, spi, t);
+			ndelay(nsecs);
+		}
+		cs_change = t->cs_change;
+
+		r = ls7a_spi_write_read(spi, t);
+		if (r < 0) {
+			status = r;
+			goto error;
+			}
+		total_len += r;
+
+		spi_transfer_delay_exec(t);
+
+		if (cs_change) {
+			set_cs(ls7a_spi, spi, 1);
+			ndelay(nsecs);
+		}
+	}
+
+	spin_lock(&ls7a_spi->lock);
+	ls7a_spi_write_reg(ls7a_spi, PARA, param);
+	spin_unlock(&ls7a_spi->lock);
+
+	if (!cs_change) {
+		ndelay(nsecs);
+		set_cs(ls7a_spi, spi, 1);
+	}
+
+error:
+	m->status = status;
+	m->actual_length = total_len;
+	spi_finalize_current_message(master);
+	return status;
+}
+
+static int ls7a_spi_pci_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master;
+	struct ls7a_spi *spi;
+	int ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct ls7a_spi));
+	if (!master)
+		return -ENOMEM;
+
+	spi = spi_master_get_devdata(master);
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		goto err_free_master;
+
+	ret = pci_request_regions(pdev, "ls7a-spi");
+	if (ret)
+		goto err_free_master;
+
+	spi->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
+	if (!spi->base) {
+		ret = -EINVAL;
+		goto err_free_master;
+	}
+	ls7a_spi_write_reg(spi, SPCR, 0x51);
+	ls7a_spi_write_reg(spi, SPER, 0x00);
+	ls7a_spi_write_reg(spi, TIMI, 0x01);
+	ls7a_spi_write_reg(spi, PARA, 0x40);
+	spi->mode = 0;
+
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->setup = ls7a_spi_setup;
+	master->transfer_one_message  = ls7a_spi_transfer_one_message;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->num_chipselect = 4;
+	master->dev.of_node = of_node_get(pdev->dev.of_node);
+
+	spi->master = master;
+
+	pci_set_drvdata(pdev, master);
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret)
+		goto err_free_master;
+
+	return 0;
+
+err_free_master:
+	pci_release_regions(pdev);
+	spi_master_put(master);
+	return ret;
+}
+
+static void ls7a_spi_pci_remove(struct pci_dev *pdev)
+{
+	struct spi_master *master = pci_get_drvdata(pdev);
+	struct ls7a_spi *spi;
+
+	spi = spi_master_get_devdata(master);
+	if (!spi)
+		return;
+
+	pci_release_regions(pdev);
+}
+
+static const struct pci_device_id ls7a_spi_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, ls7a_spi_pci_id_table);
+
+static struct pci_driver ls7a_spi_pci_driver = {
+	.name		= "ls7a-spi",
+	.id_table	= ls7a_spi_pci_id_table,
+	.probe		= ls7a_spi_pci_probe,
+	.remove		= ls7a_spi_pci_remove,
+};
+
+module_pci_driver(ls7a_spi_pci_driver);
+
+MODULE_AUTHOR("Juxin Gao <gaojuxin@loongson.cn>");
+MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
+MODULE_DESCRIPTION("Loongson LS7A SPI controller driver");
-- 
2.1.0

