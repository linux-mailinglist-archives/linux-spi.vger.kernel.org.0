Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD5337D71
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCKTN0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:13:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42350 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCKTM6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:12:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCjjR123950;
        Thu, 11 Mar 2021 13:12:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615489965;
        bh=TUi2WHK3M2rDM2J87pAt68xPOpINrGhVEr8Jkhg2JPY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VUA1S0pZMh49E+FybBpMjIZq0wduLyW/Uxig+WKs+4CEHMcf4Ist7B0Jw81gP7u3T
         LWhimlx5WuzQDEcB0MqTILgxo2ixiklwMRIGF3Ed9eAoAHE0kao0wpNg4RqUxkR/Mu
         F/uaTCNd7hbFfVpmFEXqRmE4o2puFwZsGcPhBmo4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BJCjZA110617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 13:12:45 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 13:12:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 13:12:45 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCHvW080816;
        Thu, 11 Mar 2021 13:12:41 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH 5/6] spi: cadence-qspi: Tune PHY to allow running at higher frequencies
Date:   Fri, 12 Mar 2021 00:42:15 +0530
Message-ID: <20210311191216.7363-6-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311191216.7363-1-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The controller can only run at 1/8 ref clock speed without PHY. With
PHY, it can run at the ref clock speed. So, to enable higher speed
operations, perform the PHY tuning algorithm and determine the RX, TX,
and read delay values for optimal performance. The details of the tuning
algorithm can be found at [0].

To allow this tuning to happen, pre-determined data must be programmed
to the flash at some location. This location is then advertised via a
nvmem cell. Without this data being available, the tuning would fail.

The tuning algorithm is a multi-variable search. The RX and TX delays
need to be found, along with the read delay that would work across a
temperature range. To do that, first the upper and lower RX values at
which the tuning pattern is readable are looked for. This is called the
passing region. The search is performed with Tx = 16 incrementing the
read delay with each iteration. If the two RX values have the same read
delay, the same search is performed with TX = 48.

Once the RX boundaries are found, the TX boundaries are searched for in
a similar fashion with RX set to 1/4 of the RX window (the difference
between the highest and lowest values). And similarly, if the TX
boundaries have the same read delay, the same search is performed with
RX set to 3/4 of the RX window.

There is a region around the boundary of the two passing regions. It is
called the failing region. PHY reads will not work in this region so the
PHY should be tuned as far from it as possible to allow for temperature
variations. This region is found using binary search where the window is
progressively narrowed down until it arrives at the final boundary's
lower and upper limits.

Once PHY is successfully tuned, mark it as usable to allow eligible
operations to run at high speeds. PHY can only be used with DAC mode
reads, and only in chunks of 16 bytes. For all other operations, PHY
mode should be turned off.

[0] https://www.ti.com/lit/pdf/spract2/

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 617 ++++++++++++++++++++++++++++++
 1 file changed, 617 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e64d8e125263..d304148a4722 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/timer.h>
+#include <linux/nvmem-consumer.h>
 
 #define CQSPI_NAME			"cadence-qspi"
 #define CQSPI_MAX_CHIPSELECT		16
@@ -62,6 +63,9 @@ struct cqspi_flash_pdata {
 	u8			cs;
 	bool			use_phy;
 	struct phy_setting	phy_setting;
+	struct spi_mem_op	phy_read_op;
+	u32			phy_tx_start;
+	u32			phy_tx_end;
 };
 
 struct cqspi_st {
@@ -237,6 +241,13 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_POLLING_STATUS		0xB0
 #define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
 
+#define CQSPI_REG_PHY_CONFIG			0xB4
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_LSB		0
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_LSB		16
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_RESYNC		BIT(31)
+
 #define CQSPI_REG_OP_EXT_LOWER			0xE0
 #define CQSPI_REG_OP_EXT_READ_LSB		24
 #define CQSPI_REG_OP_EXT_WRITE_LSB		16
@@ -262,6 +273,570 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_IRQ_STATUS_MASK		0x1FFFF
 
+#define CQSPI_PHY_INIT_RD		1
+#define CQSPI_PHY_MAX_RD		4
+#define CQSPI_PHY_MAX_RX		63
+#define CQSPI_PHY_MAX_TX		63
+#define CQSPI_PHY_LOW_RX_BOUND		15
+#define CQSPI_PHY_HIGH_RX_BOUND		25
+#define CQSPI_PHY_LOW_TX_BOUND		32
+#define CQSPI_PHY_HIGH_TX_BOUND		48
+#define CQSPI_PHY_TX_LOOKUP_LOW_BOUND	24
+#define CQSPI_PHY_TX_LOOKUP_HIGH_BOUND	38
+
+#define CQSPI_PHY_DEFAULT_TEMP		45
+#define CQSPI_PHY_MIN_TEMP		-45
+#define CQSPI_PHY_MAX_TEMP		130
+#define CQSPI_PHY_MID_TEMP		(CQSPI_PHY_MIN_TEMP +	\
+					 ((CQSPI_PHY_MAX_TEMP - CQSPI_PHY_MIN_TEMP) / 2))
+
+static const u8 phy_tuning_pattern[] = {
+0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01, 0x01,
+0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
+0x00, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0xFE, 0xFE, 0xFF, 0x01,
+0x01, 0x01, 0x01, 0x01, 0xFE, 0x00, 0xFE, 0xFE, 0x01, 0x01, 0x01, 0x01, 0xFE,
+0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x00, 0xFE, 0xFE,
+0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x00, 0xFE, 0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01,
+0x01, 0x00, 0xFE, 0xFE, 0xFE, 0x01, 0x01, 0x01, 0x01, 0x00, 0xFE, 0xFE, 0xFE,
+0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF,
+0xFF, 0x00, 0xFE, 0xFE, 0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0xFE, 0xFE,
+0xFE, 0xFE, 0x01, 0x01, 0x01, 0x01, 0xFE, 0xFE, 0xFE, 0xFE, 0x01,
+};
+
+static void cqspi_set_tx_dll(void __iomem *reg_base, u8 dll)
+{
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~(CQSPI_REG_PHY_CONFIG_TX_DEL_MASK <<
+		CQSPI_REG_PHY_CONFIG_TX_DEL_LSB);
+	reg |= (dll & CQSPI_REG_PHY_CONFIG_TX_DEL_MASK) <<
+		CQSPI_REG_PHY_CONFIG_TX_DEL_LSB;
+	reg |= CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+}
+
+static void cqspi_set_rx_dll(void __iomem *reg_base, u8 dll)
+{
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~(CQSPI_REG_PHY_CONFIG_RX_DEL_MASK <<
+		CQSPI_REG_PHY_CONFIG_RX_DEL_LSB);
+	reg |= (dll & CQSPI_REG_PHY_CONFIG_RX_DEL_MASK) <<
+		CQSPI_REG_PHY_CONFIG_RX_DEL_LSB;
+	reg |= CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+}
+
+/* TODO: Figure out how to get the temperature here. */
+static int cqspi_get_temp(int *temp)
+{
+	return -EOPNOTSUPP;
+}
+
+static void cqspi_phy_apply_setting(struct cqspi_flash_pdata *f_pdata,
+				    struct phy_setting *phy)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+
+	cqspi_set_rx_dll(cqspi->iobase, phy->rx);
+	cqspi_set_tx_dll(cqspi->iobase, phy->tx);
+	f_pdata->phy_setting.read_delay = phy->read_delay;
+}
+
+static int cqspi_phy_check_pattern(struct cqspi_flash_pdata *f_pdata,
+				   struct nvmem_cell *cell)
+{
+	u8 *read_data;
+	size_t len;
+	int ret;
+
+	read_data = nvmem_cell_read(cell, &len);
+	if (IS_ERR(read_data))
+		return PTR_ERR(read_data);
+	if (len != ARRAY_SIZE(phy_tuning_pattern))
+		return -EIO;
+
+	if (memcmp(read_data, phy_tuning_pattern,
+		   ARRAY_SIZE(phy_tuning_pattern))) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	kfree(read_data);
+	return ret;
+}
+
+static int cqspi_find_rx_low(struct cqspi_flash_pdata *f_pdata,
+			     struct nvmem_cell *cell, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = 0;
+		do {
+			cqspi_phy_apply_setting(f_pdata, phy);
+			ret = cqspi_phy_check_pattern(f_pdata, cell);
+			if (!ret)
+				return 0;
+
+			phy->rx++;
+		} while (phy->rx <= CQSPI_PHY_LOW_RX_BOUND);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find RX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_high(struct cqspi_flash_pdata *f_pdata,
+			      struct nvmem_cell *cell, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = CQSPI_PHY_MAX_RX;
+		do {
+			cqspi_phy_apply_setting(f_pdata, phy);
+			ret = cqspi_phy_check_pattern(f_pdata, cell);
+			if (!ret)
+				return 0;
+
+			phy->rx--;
+		} while (phy->rx >= CQSPI_PHY_HIGH_RX_BOUND);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find RX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_low(struct cqspi_flash_pdata *f_pdata,
+			     struct nvmem_cell *cell, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = 0;
+		do {
+			cqspi_phy_apply_setting(f_pdata, phy);
+			ret = cqspi_phy_check_pattern(f_pdata, cell);
+			if (!ret)
+				return 0;
+
+			phy->tx++;
+		} while (phy->tx <= CQSPI_PHY_LOW_TX_BOUND);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find TX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_high(struct cqspi_flash_pdata *f_pdata,
+			      struct nvmem_cell *cell, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = CQSPI_PHY_MAX_TX;
+		do {
+			cqspi_phy_apply_setting(f_pdata, phy);
+			ret = cqspi_phy_check_pattern(f_pdata, cell);
+			if (!ret)
+				return 0;
+
+			phy->tx--;
+		} while (phy->tx >= CQSPI_PHY_HIGH_TX_BOUND);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find TX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_phy_find_gaplow(struct cqspi_flash_pdata *f_pdata,
+				 struct nvmem_cell *cell,
+				 struct phy_setting *bottomleft,
+				 struct phy_setting *topright,
+				 struct phy_setting *gaplow)
+{
+	struct phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = left.read_delay;
+
+	do {
+		cqspi_phy_apply_setting(f_pdata, &mid);
+		ret = cqspi_phy_check_pattern(f_pdata, cell);
+		if (ret) {
+			/* The pattern was not found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		}
+
+	/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaplow = mid;
+	return 0;
+}
+
+static int cqspi_phy_find_gaphigh(struct cqspi_flash_pdata *f_pdata,
+				  struct nvmem_cell *cell,
+				  struct phy_setting *bottomleft,
+				  struct phy_setting *topright,
+				  struct phy_setting *gaphigh)
+{
+	struct phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = right.read_delay;
+
+	do {
+		cqspi_phy_apply_setting(f_pdata, &mid);
+		ret = cqspi_phy_check_pattern(f_pdata, cell);
+		if (ret) {
+			/* The pattern was not found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		}
+
+	/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaphigh = mid;
+	return 0;
+}
+
+static int cqspi_phy_calibrate(struct cqspi_flash_pdata *f_pdata,
+			       struct nvmem_cell *cell)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	struct phy_setting rxlow, rxhigh, txlow, txhigh, temp;
+	struct phy_setting bottomleft, topright, searchpoint, gaplow, gaphigh;
+	int ret, tmp;
+
+	f_pdata->use_phy = true;
+
+	/* Look for RX boundaries at lower TX range. */
+	rxlow.tx = f_pdata->phy_tx_start;
+
+	do {
+		dev_dbg(dev, "Searching for rxlow on TX = %d\n", rxlow.tx);
+		rxlow.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_rx_low(f_pdata, cell, &rxlow);
+	} while (ret && ++rxlow.tx <= CQSPI_PHY_TX_LOOKUP_LOW_BOUND);
+
+	if (ret)
+		goto out;
+	dev_dbg(dev, "rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx, rxlow.tx,
+		rxlow.read_delay);
+
+	rxhigh.tx = rxlow.tx;
+	rxhigh.read_delay = rxlow.read_delay;
+	cqspi_find_rx_high(f_pdata, cell, &rxhigh);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx, rxhigh.tx,
+		rxhigh.read_delay);
+
+	/*
+	 * Check a different point if rxlow and rxhigh are on the same read
+	 * delay. This avoids mistaking the failing region for an RX boundary.
+	 */
+	if (rxlow.read_delay == rxhigh.read_delay) {
+		dev_dbg(dev,
+			"rxlow and rxhigh at the same read delay.\n");
+
+		/* Look for RX boundaries at upper TX range. */
+		temp.tx = f_pdata->phy_tx_end;
+
+		do {
+			dev_dbg(dev, "Searching for rxlow on TX = %d\n",
+				temp.tx);
+			temp.read_delay = CQSPI_PHY_INIT_RD;
+			ret = cqspi_find_rx_low(f_pdata, cell, &temp);
+		} while (ret && --temp.tx >= CQSPI_PHY_TX_LOOKUP_HIGH_BOUND);
+
+		if (ret)
+			goto out;
+		dev_dbg(dev, "rxlow: RX: %d TX: %d RD: %d\n", temp.rx, temp.tx,
+			temp.read_delay);
+
+		if (temp.rx < rxlow.rx) {
+			rxlow = temp;
+			dev_dbg(dev, "Updating rxlow to the one at TX = 48\n");
+		}
+
+		/* Find RX max. */
+		ret = cqspi_find_rx_high(f_pdata, cell, &temp);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "rxhigh: RX: %d TX: %d RD: %d\n", temp.rx, temp.tx,
+			temp.read_delay);
+
+		if (temp.rx < rxhigh.rx) {
+			rxhigh = temp;
+			dev_dbg(dev, "Updating rxhigh to the one at TX = 48\n");
+		}
+	}
+
+	/* Look for TX boundaries at 1/4 of RX window. */
+	txlow.rx = rxlow.rx + ((rxhigh.rx - rxlow.rx) / 4);
+	txhigh.rx = txlow.rx;
+
+	txlow.read_delay = CQSPI_PHY_INIT_RD;
+	ret = cqspi_find_tx_low(f_pdata, cell, &txlow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "txlow: RX: %d TX: %d RD: %d\n", txlow.rx, txlow.tx,
+		txlow.read_delay);
+
+	txhigh.read_delay = txlow.read_delay;
+	ret = cqspi_find_tx_high(f_pdata, cell, &txhigh);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "txhigh: RX: %d TX: %d RD: %d\n", txhigh.rx, txhigh.tx,
+		txhigh.read_delay);
+
+	/*
+	 * Check a different point if txlow and txhigh are on the same read
+	 * delay. This avoids mistaking the failing region for an TX boundary.
+	 */
+	if (txlow.read_delay == txhigh.read_delay) {
+		/* Look for TX boundaries at 3/4 of RX window. */
+		temp.rx = rxlow.rx + (3 * (rxhigh.rx - rxlow.rx) / 4);
+		temp.read_delay = CQSPI_PHY_INIT_RD;
+		dev_dbg(dev,
+			"txlow and txhigh at the same read delay. Searching at RX = %d\n",
+			temp.rx);
+
+		ret = cqspi_find_tx_low(f_pdata, cell, &temp);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "txlow: RX: %d TX: %d RD: %d\n", temp.rx, temp.tx,
+			temp.read_delay);
+
+		if (temp.tx < txlow.tx) {
+			txlow = temp;
+			dev_dbg(dev, "Updating txlow with the one at RX = %d\n",
+				txlow.rx);
+		}
+
+		ret = cqspi_find_tx_high(f_pdata, cell, &temp);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "txhigh: RX: %d TX: %d RD: %d\n", temp.rx, temp.tx,
+			temp.read_delay);
+
+		if (temp.tx < txhigh.tx) {
+			txhigh = temp;
+			dev_dbg(dev, "Updating txhigh with the one at RX = %d\n",
+				txhigh.rx);
+		}
+	}
+
+	/*
+	 * Set bottom left and top right corners. These are theoretical
+	 * corners. They may not actually be "good" points. But the longest
+	 * diagonal will be between these corners.
+	 */
+	bottomleft.tx = txlow.tx;
+	bottomleft.rx = rxlow.rx;
+	if (txlow.read_delay <= rxlow.read_delay)
+		bottomleft.read_delay = txlow.read_delay;
+	else
+		bottomleft.read_delay = rxlow.read_delay;
+
+	temp = bottomleft;
+	temp.tx += 4;
+	temp.rx += 4;
+	cqspi_phy_apply_setting(f_pdata, &temp);
+	ret = cqspi_phy_check_pattern(f_pdata, cell);
+	if (ret) {
+		temp.read_delay--;
+		cqspi_phy_apply_setting(f_pdata, &temp);
+		ret = cqspi_phy_check_pattern(f_pdata, cell);
+	}
+
+	if (!ret)
+		bottomleft.read_delay = temp.read_delay;
+
+	topright.tx = txhigh.tx;
+	topright.rx = rxhigh.rx;
+	if (txhigh.read_delay >= rxhigh.read_delay)
+		topright.read_delay = txhigh.read_delay;
+	else
+		topright.read_delay = rxhigh.read_delay;
+
+	temp = topright;
+	temp.tx -= 4;
+	temp.rx -= 4;
+	cqspi_phy_apply_setting(f_pdata, &temp);
+	ret = cqspi_phy_check_pattern(f_pdata, cell);
+	if (ret) {
+		temp.read_delay++;
+		cqspi_phy_apply_setting(f_pdata, &temp);
+		ret = cqspi_phy_check_pattern(f_pdata, cell);
+	}
+
+	if (!ret)
+		topright.read_delay = temp.read_delay;
+
+	dev_dbg(dev, "topright: RX: %d TX: %d RD: %d\n", topright.rx,
+		topright.tx, topright.read_delay);
+	dev_dbg(dev, "bottomleft: RX: %d TX: %d RD: %d\n", bottomleft.rx,
+		bottomleft.tx, bottomleft.read_delay);
+
+	ret = cqspi_phy_find_gaplow(f_pdata, cell, &bottomleft, &topright,
+				    &gaplow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "gaplow: RX: %d TX: %d RD: %d\n", gaplow.rx, gaplow.tx,
+		gaplow.read_delay);
+
+	if (bottomleft.read_delay == topright.read_delay) {
+		/*
+		 * If there is only one passing region, it means that the "true"
+		 * topright is too small to find, so the start of the failing
+		 * region is a good approximation. Put the tuning point in the
+		 * middle and adjust for temperature.
+		 */
+		topright = gaplow;
+		searchpoint.read_delay = bottomleft.read_delay;
+		searchpoint.tx = bottomleft.tx +
+				 ((topright.tx - bottomleft.tx) / 2);
+		searchpoint.rx = bottomleft.rx +
+				 ((topright.rx - bottomleft.rx) / 2);
+
+		ret = cqspi_get_temp(&tmp);
+		if (ret) {
+			/*
+			 * Assume room temperature if it couldn't be obtained
+			 * from the thermal sensor.
+			 *
+			 * TODO: Change it to dev_warn once support for finding
+			 * out the temperature is added.
+			 */
+			dev_dbg(dev,
+				"Unable to get temperature. Assuming room temperature\n");
+			tmp = CQSPI_PHY_DEFAULT_TEMP;
+		}
+
+		if (tmp < CQSPI_PHY_MIN_TEMP || tmp > CQSPI_PHY_MAX_TEMP) {
+			dev_err(dev,
+				"Temperature outside operating range: %dC\n",
+				tmp);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Avoid a divide-by-zero. */
+		if (tmp == CQSPI_PHY_MID_TEMP)
+			tmp++;
+		dev_dbg(dev, "Temperature: %dC\n", tmp);
+
+		searchpoint.tx += (topright.tx - bottomleft.tx) /
+				  (330 / (tmp - CQSPI_PHY_MID_TEMP));
+		searchpoint.rx += (topright.rx - bottomleft.rx) /
+				  (330 / (tmp - CQSPI_PHY_MID_TEMP));
+	} else {
+		/*
+		 * If there are two passing regions, find the start and end of
+		 * the second one.
+		 */
+		ret = cqspi_phy_find_gaphigh(f_pdata, cell, &bottomleft,
+					     &topright, &gaphigh);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "gaphigh: RX: %d TX: %d RD: %d\n", gaphigh.rx,
+			gaphigh.tx, gaphigh.read_delay);
+
+		/*
+		 * Place the final tuning point in the corner furthest from the
+		 * failing region but leave some margin for temperature changes.
+		 */
+		if ((abs(gaplow.tx - bottomleft.tx) +
+		     abs(gaplow.rx - bottomleft.rx)) <
+		    (abs(gaphigh.tx - topright.tx) +
+		     abs(gaphigh.rx - topright.rx))) {
+			searchpoint = topright;
+			searchpoint.tx -= 16;
+			searchpoint.rx -= (16 * (topright.rx - bottomleft.rx)) /
+					   (topright.tx - bottomleft.tx);
+		} else {
+			searchpoint = bottomleft;
+			searchpoint.tx += 16;
+			searchpoint.rx += (16 * (topright.rx - bottomleft.rx)) /
+					   (topright.tx - bottomleft.tx);
+		}
+	}
+
+	/* Set the final PHY settings and check if they are working. */
+	cqspi_phy_apply_setting(f_pdata, &searchpoint);
+	dev_dbg(dev, "Final tuning point: RX: %d TX: %d RD: %d\n",
+		searchpoint.rx, searchpoint.tx, searchpoint.read_delay);
+
+	ret = cqspi_phy_check_pattern(f_pdata, cell);
+	if (ret) {
+		dev_err(dev,
+			"Failed to find pattern at final calibration point\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = 0;
+	f_pdata->phy_setting.read_delay = searchpoint.read_delay;
+out:
+	if (ret)
+		f_pdata->use_phy = false;
+	return ret;
+}
+
 static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
 {
 	u32 val;
@@ -1400,6 +1975,41 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 		return spi_mem_default_supports_op(mem, op);
 }
 
+static void cqspi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct cqspi_flash_pdata *f_pdata;
+	struct nvmem_cell *cell;
+	struct device *dev = &cqspi->pdev->dev;
+	int ret;
+
+	f_pdata = &cqspi->f_pdata[mem->spi->chip_select];
+
+	/* Check if the op is eligible for PHY mode operation. */
+	if (!cqspi_phy_op_eligible(op))
+		return;
+
+	cell = nvmem_cell_get(dev, "calibration");
+	if (IS_ERR_OR_NULL(cell)) {
+		dev_dbg(dev, "Failed to get calibration data nvmem: %ld\n",
+			PTR_ERR(cell));
+		return;
+	}
+
+	ret = cqspi_phy_check_pattern(f_pdata, cell);
+	if (ret) {
+		dev_dbg(dev, "Pattern not found. Skipping calibration.\n");
+		nvmem_cell_put(cell);
+		return;
+	}
+
+	ret = cqspi_phy_calibrate(f_pdata, cell);
+	if (ret)
+		dev_info(&cqspi->pdev->dev, "PHY calibration failed: %d\n", ret);
+
+	nvmem_cell_put(cell);
+}
+
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 				    struct cqspi_flash_pdata *f_pdata,
 				    struct device_node *np)
@@ -1434,6 +2044,12 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 		return -ENXIO;
 	}
 
+	if (of_property_read_u32(np, "cdns,phy-tx-start", &f_pdata->phy_tx_start))
+		f_pdata->phy_tx_start = 16;
+
+	if (of_property_read_u32(np, "cdns,phy-tx-end", &f_pdata->phy_tx_end))
+		f_pdata->phy_tx_end = 48;
+
 	return 0;
 }
 
@@ -1534,6 +2150,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
+	.do_calibration = cqspi_mem_do_calibration,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
-- 
2.30.0

