Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB62C022B
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKWJT0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 04:19:26 -0500
Received: from mail.loongson.cn ([114.242.206.163]:34762 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbgKWJT0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 04:19:26 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD9OMfrtfB3wVAA--.43428S2;
        Mon, 23 Nov 2020 17:19:09 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] spi: Loongson: Add Loongson 3A+7A SPI controller driver support
Date:   Mon, 23 Nov 2020 17:19:06 +0800
Message-Id: <1606123148-315-1-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxD9OMfrtfB3wVAA--.43428S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Zw1rWFWfKr47WF1rAr48Xrb_yoW8JFy7Co
        WxZ3ZxXrW8ur18GF10vr1Fqry7Xas8Wr90yrs3A3WkXws8tryDtr9xGrW7Jr18uF1fJFnr
        JryrWrWrKF4xWF4xn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYB7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
        1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0
        I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAa
        Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
        A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402
        YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Jr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUkUKsUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This module is integrated into the Loongson-3A SoC and the LS7A bridge chip.

The SPI controller has the following characteristics:

-Full-duplex synchronous serial data transmission
-Support up to 4 variable length byte transmission
-Main mode support
-Mode failure generates an error flag and issues an interrupt request
-Double buffer receiver
-Serial clock with programmable polarity and phase
-SPI can be controlled in wait mode
-Support boot from SPI

Loongson bridge chip and SOC are connected to the nor-flash slave device,
the model is en25q32b, and the device driver under the mtd subsystem is used for testing.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 drivers/spi/Kconfig        |   6 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-loongson.c | 428 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 435 insertions(+)
 create mode 100644 drivers/spi/spi-loongson.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3fd16b7..83610be 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -968,6 +968,12 @@ config SPI_AMD
 	help
 	  Enables SPI controller driver for AMD SoC.
 
+config SPI_LOONGSON
+        tristate "Loongson SPI Controller Support"
+        depends on CPU_LOONGSON32 || CPU_LOONGSON64
+        help
+          This is the driver for Loongson spi master controller.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea582..5739c0e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
+obj-$(CONFIG_SPI_LOONGSON)		+= spi-loongson.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-loongson.c b/drivers/spi/spi-loongson.c
new file mode 100644
index 0000000..3e488fb
--- /dev/null
+++ b/drivers/spi/spi-loongson.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Loongson3A+7A SPI driver
+ *
+ * Copyright (C) 2017 Juxin Gao <gaojuxin@loongson.cn>
+ * 
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
+/*define spi register */
+#define	SPCR	0x00
+#define	SPSR	0x01
+#define FIFO	0x02
+#define	SPER	0x03
+#define	PARA	0x04
+#define	SFCS	0x05
+#define	TIMI	0x06
+
+struct loongson_spi {
+	struct work_struct work;
+	spinlock_t       lock;
+	struct workqueue_struct *wq;
+	struct	list_head	msg_queue;
+	struct	spi_master	*master;
+	void	__iomem		*base;
+	int cs_active;
+	unsigned int hz;
+	unsigned char spcr, sper;
+	unsigned int mode;
+};
+
+static inline int set_cs(struct loongson_spi *loongson_spi, struct spi_device  *spi, int val);
+
+static void loongson_spi_write_reg(struct loongson_spi *spi,
+		unsigned char reg, unsigned char data)
+{
+	writeb(data, spi->base + reg);
+}
+
+static char loongson_spi_read_reg(struct loongson_spi *spi,
+		unsigned char reg)
+{
+	return readb(spi->base + reg);
+}
+
+static int loongson_spi_update_state(struct loongson_spi *loongson_spi, struct spi_device *spi,
+		struct spi_transfer *t)
+{
+	unsigned int hz;
+	unsigned int div, div_tmp;
+	unsigned int bit;
+	unsigned long clk;
+	unsigned char val;
+	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
+
+	hz  = t ? t->speed_hz : spi->max_speed_hz;
+
+	if (!hz)
+		hz = spi->max_speed_hz;
+
+	if ((hz && loongson_spi->hz != hz) || ((spi->mode ^ loongson_spi->mode) & (SPI_CPOL | SPI_CPHA))) {
+		clk = 100000000;
+		div = DIV_ROUND_UP(clk, hz);
+
+		if (div < 2)
+			div = 2;
+
+		if (div > 4096)
+			div = 4096;
+
+		bit = fls(div) - 1;
+		if ((1<<bit) == div)
+			bit--;
+		div_tmp = rdiv[bit];
+
+		dev_dbg(&spi->dev, "clk = %ld hz = %d div_tmp = %d bit = %d\n",
+				clk, hz, div_tmp, bit);
+
+		loongson_spi->hz = hz;
+		loongson_spi->spcr = div_tmp & 3;
+		loongson_spi->sper = (div_tmp >> 2) & 3;
+
+		val = loongson_spi_read_reg(loongson_spi, SPCR);
+		val &= ~0xc;
+		if (spi->mode & SPI_CPOL)
+			val |= 8;
+		if (spi->mode & SPI_CPHA)
+			val |= 4;
+		loongson_spi_write_reg(loongson_spi, SPCR, (val & ~3) | loongson_spi->spcr);
+		val = loongson_spi_read_reg(loongson_spi, SPER);
+		loongson_spi_write_reg(loongson_spi, SPER, (val & ~3) | loongson_spi->sper);
+		loongson_spi->mode = spi->mode;
+	}
+
+	return 0;
+}
+
+
+
+static int loongson_spi_setup(struct spi_device *spi)
+{
+	struct loongson_spi *loongson_spi;
+
+	loongson_spi = spi_master_get_devdata(spi->master);
+	if (spi->bits_per_word % 8)
+		return -EINVAL;
+
+	if (spi->chip_select >= spi->master->num_chipselect)
+		return -EINVAL;
+
+	loongson_spi_update_state(loongson_spi, spi, NULL);
+
+	set_cs(loongson_spi, spi, 1);
+
+	return 0;
+}
+
+static int loongson_spi_write_read_8bit(struct spi_device *spi,
+		const u8 **tx_buf, u8 **rx_buf, unsigned int num)
+{
+	struct loongson_spi *loongson_spi;
+	loongson_spi = spi_master_get_devdata(spi->master);
+
+	if (tx_buf && *tx_buf) {
+		loongson_spi_write_reg(loongson_spi, FIFO, *((*tx_buf)++));
+		while ((loongson_spi_read_reg(loongson_spi, SPSR) & 0x1) == 1);
+        } else {
+		loongson_spi_write_reg(loongson_spi, FIFO, 0);
+		while ((loongson_spi_read_reg(loongson_spi, SPSR) & 0x1) == 1);
+        }
+
+	if (rx_buf && *rx_buf)
+		*(*rx_buf)++ = loongson_spi_read_reg(loongson_spi, FIFO);
+        else
+		loongson_spi_read_reg(loongson_spi, FIFO);
+
+	return 1;
+}
+
+
+static unsigned int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct loongson_spi *loongson_spi;
+	unsigned int count;
+	const u8 *tx = xfer->tx_buf;
+	u8 *rx = xfer->rx_buf;
+
+	loongson_spi = spi_master_get_devdata(spi->master);
+	count = xfer->len;
+
+	do {
+		if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
+			goto out;
+		count--;
+	} while (count);
+
+out:
+	return xfer->len - count;
+
+}
+
+static inline int set_cs(struct loongson_spi *loongson_spi, struct spi_device  *spi, int val)
+{
+	int cs = loongson_spi_read_reg(loongson_spi, SFCS) & ~(0x11 << spi->chip_select);
+
+        if (spi->mode  & SPI_CS_HIGH)
+		val = !val;
+	loongson_spi_write_reg(loongson_spi, SFCS,
+                        (val ? (0x11 << spi->chip_select):(0x1 << spi->chip_select)) | cs);
+	return 0;
+}
+
+static void loongson_spi_work(struct work_struct *work)
+{
+	struct loongson_spi *loongson_spi =
+		container_of(work, struct loongson_spi, work);
+	int param;
+
+	spin_lock(&loongson_spi->lock);
+	param = loongson_spi_read_reg(loongson_spi, PARA);
+	loongson_spi_write_reg(loongson_spi, PARA, param&~1);
+	while (!list_empty(&loongson_spi->msg_queue)) {
+
+		struct spi_message *m;
+		struct spi_device  *spi;
+		struct spi_transfer *t = NULL;
+
+		m = container_of(loongson_spi->msg_queue.next, struct spi_message, queue);
+
+		list_del_init(&m->queue);
+		spin_unlock(&loongson_spi->lock);
+
+		spi = m->spi;
+
+		set_cs(loongson_spi, spi, 0);
+
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+
+			loongson_spi_update_state(loongson_spi, spi, t);
+
+			if (t->len)
+				m->actual_length +=
+					loongson_spi_write_read(spi, t);
+		}
+
+		set_cs(loongson_spi, spi, 1);
+		m->complete(m->context);
+
+		spin_lock(&loongson_spi->lock);
+	}
+
+	loongson_spi_write_reg(loongson_spi, PARA, param);
+	spin_unlock(&loongson_spi->lock);
+}
+
+static int loongson_spi_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct loongson_spi	*loongson_spi;
+	struct spi_transfer *t = NULL;
+
+	m->actual_length = 0;
+	m->status = 0;
+
+	if (list_empty(&m->transfers) || !m->complete)
+		return -EINVAL;
+
+	loongson_spi = spi_master_get_devdata(spi->master);
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+
+		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
+			dev_err(&spi->dev,
+					"message rejected : "
+					"invalid transfer data buffers\n");
+			goto msg_rejected;
+		}
+	}
+
+	spin_lock(&loongson_spi->lock);
+	list_add_tail(&m->queue, &loongson_spi->msg_queue);
+	queue_work(loongson_spi->wq, &loongson_spi->work);
+	spin_unlock(&loongson_spi->lock);
+
+	return 0;
+msg_rejected:
+
+	m->status = -EINVAL;
+	if (m->complete)
+		m->complete(m->context);
+	return -EINVAL;
+}
+
+static int loongson_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master	*master;
+	struct loongson_spi     *spi;
+	int ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct loongson_spi));
+
+	if (master == NULL) {
+		dev_dbg(&pdev->dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	if (pdev->id != -1)
+		master->bus_num	= pdev->id;
+
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->setup = loongson_spi_setup;
+
+	master->transfer = loongson_spi_transfer;
+
+	master->num_chipselect = 4;
+
+	master->dev.of_node = of_node_get(pdev->dev.of_node);
+
+	dev_set_drvdata(&pdev->dev, master);
+
+	spi = spi_master_get_devdata(master);
+
+	spi->wq	= create_singlethread_workqueue(pdev->name);
+
+	spi->master = master;
+
+	spi->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(spi->base)) {
+		dev_err(&pdev->dev, "Cannot map IO\n");
+		goto free_master;
+	}
+	loongson_spi_write_reg(spi, SPCR, 0x51);
+	loongson_spi_write_reg(spi, SPER, 0x00);
+	loongson_spi_write_reg(spi, TIMI, 0x01);
+	loongson_spi_write_reg(spi, PARA, 0x40);
+	spi->mode = 0;
+
+	INIT_WORK(&spi->work, loongson_spi_work);
+
+	spin_lock_init(&spi->lock);
+	INIT_LIST_HEAD(&spi->msg_queue);
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret)
+		goto free_master;
+
+	return ret;
+
+free_master:
+	spi_master_put(master);
+	return ret;
+
+}
+
+static const struct of_device_id loongson_spi_id_table[] = {
+	{ .compatible = "loongson,loongson-spi", },
+	{ },
+};
+
+static struct platform_driver loongson_spi_driver = {
+	.probe = loongson_spi_probe,
+	.driver	= {
+		.name	= "loongson-spi",
+		.owner	= THIS_MODULE,
+		.bus = &platform_bus_type,
+		.of_match_table = of_match_ptr(loongson_spi_id_table),
+
+	},
+};
+
+static struct resource loongson_spi_resources[] = {
+	[0] = {
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device loongson_spi_device = {
+	.name           = "loongson-spi",
+	.id             = 0,
+	.num_resources  = ARRAY_SIZE(loongson_spi_resources),
+	.resource   = loongson_spi_resources,
+};
+
+
+static int loongson_spi_pci_register(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
+{
+	int ret;
+	unsigned char v8;
+
+	/* Enable device in PCI config */
+	ret = pci_enable_device(pdev);
+	if (ret) {
+                dev_err(&pdev->dev, "%s pci_enable_device failed\n", __func__);
+		goto err_out;
+	}
+	/* request the mem regions */
+	ret = pci_request_region(pdev, 0, "loongson-spi io");
+	if (ret) {
+		dev_err(&pdev->dev, "%s request_region failed\n", __func__);
+		goto err_out;
+	}
+	loongson_spi_resources[0].start = pci_resource_start(pdev, 0);
+	loongson_spi_resources[0].end = pci_resource_end(pdev, 0);
+	/* need api from pci irq */
+	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &v8);
+
+	if (ret == PCIBIOS_SUCCESSFUL) {
+		loongson_spi_resources[1].start = v8;
+		loongson_spi_resources[1].end = v8;
+		platform_device_register(&loongson_spi_device);
+	}
+
+err_out:
+	return ret;
+}
+
+static void loongson_spi_pci_unregister(struct pci_dev *pdev)
+{
+	pci_release_region(pdev, 0);
+}
+
+static struct pci_device_id loongson_spi_devices[] = {
+	{PCI_DEVICE(0x0014, 0x7a0b)},
+	{0, 0, 0, 0, 0, 0, 0}
+};
+
+static struct pci_driver loongson_spi_pci_driver = {
+	.name       = "loongson-spi-pci",
+	.id_table   = loongson_spi_devices,
+	.probe      = loongson_spi_pci_register,
+	.remove     = loongson_spi_pci_unregister,
+};
+
+static int __init loongson_spi_init(void)
+{
+	int ret;
+
+	ret =  platform_driver_register(&loongson_spi_driver);
+	if (!ret)
+		ret = pci_register_driver(&loongson_spi_pci_driver);
+	return ret;
+}
+
+static void __exit loongson_spi_exit(void)
+{
+	platform_driver_unregister(&loongson_spi_driver);
+	pci_unregister_driver(&loongson_spi_pci_driver);
+}
+
+subsys_initcall(loongson_spi_init);
+module_exit(loongson_spi_exit);
+
+MODULE_AUTHOR("Juxin Gao <gaojuxin@loongson.cn>");
+MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
+MODULE_DESCRIPTION("Loongson3A+7A SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.0

