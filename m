Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C76450F1D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhKOS0x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 13:26:53 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:45168 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbhKOSZC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 13:25:02 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] spi: dw: Introduce Synopsys IP-core versions interface
Date:   Mon, 15 Nov 2021 21:19:15 +0300
Message-ID: <20211115181917.7521-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver currently supports two IP-core versions. It's DW APB SSI which
is older version of the controller with APB system bus interface, and DW
SSI controller with AHB bus interface. The later one is supposed to be a
new generation high-speed SSI. Even though both of these IP-cores have got
an almost identical registers space there are some differences. The driver
differentiates these distinctions by the DW_SPI_CAP_DWC_HSSI capability
flag. In addition to that each DW SSI IP-core is equipped with a Synopsys
Component version register, which encodes the IP-core release ID the has
been synthesized from. Seeing we are going to need the later one to
differentiate some controller peculiarities it would be better to have a
unified interface for both IP-core line and release versions instead of
using each of them separately.

Introduced here IP-core versioning interface consists of two parts:
1) IDs of the IP-core (virtual) and component versions.
2) a set of macro helpers to identify current IP-core and component
versions.

So the platform code is supposed to assign a proper IP-core version based
on it's platform -knowledge. The main driver initialization method reads
the IP-core release ID from the SSI component version register. That data
is used by the helpers to distinguish one IP-core release from another.
Thus the rest of the driver can use these macros to implement the
conditional code execution based on the specified IP-core and version IDs.

Collect the IP-core versions interface and the defined capabilities at the
top of the header file since they represent a common device description
data and so to immediately available for the driver hackers.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Note I intentionally haven't used the "%p4cc" format specifier due to
three reasons. First the component version 4cc string is preserved in the
little endian format in the DW SSI register thus having '*' in the least
significant byte.  Such representation do look well when you print it in
hex, but that's not what the 4cc format print implementation expects
(fourcc_string() wants to see a most-significant char at the lowest byte).
Second the 4cc format also prints some pixel-format specific info like
endiannes, which is irrelevant to the synopsys component version. Finally
a string in the "v%c.%c%c" format represents the component version better.

Changelog v2:
- Replace the ASCII-to-integer conversion with a unified IP-core versions
  interface.
---
 drivers/spi/spi-dw-core.c | 14 ++++++++++++++
 drivers/spi/spi-dw.h      | 36 ++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index b9f809989fda..42536b448ddd 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -823,6 +823,20 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
 	dw_spi_reset_chip(dws);
 
+	/*
+	 * Retrieve the Synopsys component version if it hasn't been specified
+	 * by the platform. CoreKit version ID is encoded as a 3-chars ASCII
+	 * code enclosed with '*' (typical for the most of Synopsys IP-cores).
+	 */
+	if (!dws->ver) {
+		dws->ver = dw_readl(dws, DW_SPI_VERSION);
+
+		dev_dbg(dev, "Synopsys DWC%sSSI v%c.%c%c\n",
+			(dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB ",
+			DW_SPI_GET_BYTE(dws->ver, 3), DW_SPI_GET_BYTE(dws->ver, 2),
+			DW_SPI_GET_BYTE(dws->ver, 1));
+	}
+
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 634085eadad1..2f7d77024b48 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -11,6 +11,30 @@
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
 
+/* Synopsys DW SSI IP-core virtual IDs */
+#define DW_PSSI_ID			0
+#define DW_HSSI_ID			1
+
+/* Synopsys DW SSI component versions (FourCC sequence) */
+#define DW_HSSI_102A			0x3130322a
+
+/* DW SSI IP-core ID and version check helpers */
+#define dw_spi_ip_is(_dws, _ip) \
+	((_dws)->ip == DW_ ## _ip ## _ID)
+
+#define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
+	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
+
+#define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
+
+#define dw_spi_ver_is_ge(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, >=)
+
+/* DW SPI controller capabilities */
+#define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
+#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
+#define DW_SPI_CAP_DWC_HSSI		BIT(2)
+#define DW_SPI_CAP_DFS32		BIT(3)
+
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
 #define DW_SPI_CTRLR1			0x04
@@ -113,12 +137,6 @@
 #define DW_SPI_GET_BYTE(_val, _idx) \
 	((_val) >> (BITS_PER_BYTE * (_idx)) & 0xff)
 
-/* DW SPI capabilities */
-#define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
-#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
-#define DW_SPI_CAP_DWC_HSSI		BIT(2)
-#define DW_SPI_CAP_DFS32		BIT(3)
-
 /* Slave spi_transfer/spi_mem_op related */
 struct dw_spi_cfg {
 	u8 tmode;
@@ -141,6 +159,10 @@ struct dw_spi_dma_ops {
 struct dw_spi {
 	struct spi_controller	*master;
 
+	u32			ip;		/* Synopsys DW SSI IP-core ID */
+	u32			ver;		/* Synopsys component version */
+	u32			caps;		/* DW SPI capabilities */
+
 	void __iomem		*regs;
 	unsigned long		paddr;
 	int			irq;
@@ -149,8 +171,6 @@ struct dw_spi {
 	u32			max_mem_freq;	/* max mem-ops bus freq */
 	u32			max_freq;	/* max bus freq supported */
 
-	u32			caps;		/* DW SPI capabilities */
-
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
-- 
2.33.0

