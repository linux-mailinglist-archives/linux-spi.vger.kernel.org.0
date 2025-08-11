Return-Path: <linux-spi+bounces-9359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BA1B21561
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD45B1908701
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726202E2DE9;
	Mon, 11 Aug 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L8EouCty"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8B1F4CA1;
	Mon, 11 Aug 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940830; cv=none; b=M57pqu6UYMj6H5qjvDPmrJUOKXxtzmvmxtdL39CdZugzryfiay1ECjt48Wj3PjRbVfD/34LD2menKOfW1JWPqRn3rUS46C5mR6rcJBB9sOc39E7c6mD5eyV3WYaat9qR5Orj6u17GdIDMAfamBs4qQ9d5x4pgUBlx7g8pQFYFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940830; c=relaxed/simple;
	bh=ZYw4nGminDovyQqY/ngO8wTPS+J9Jk3bwohpsb258og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FD644CSRMbwP5v6CMyUBSw8Edv7vDoV+Tk+/pl/hTx0VghZBRt/DTTwQrfnCuXccz0O1rGez3yI+0PFIZ5Id91A/quC/v3HGkA/7y5xOdLUfFUI6LDALLr3M9Hz8IaRBGAAQKB7x+1XZhYFH8SdvUl4IHvreA5kF/JgbAHW9YOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L8EouCty; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJXStN1180229;
	Mon, 11 Aug 2025 14:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940808;
	bh=h12tTv1cWWgw4+Y3SAdANJyY08YLVg7u64X0PKlD5cM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L8EouCtyhKn37Jfq8SjDgL9LqH0kz0u+5rJzQO16hHNrwTHsOKqBggrCUSmCtAqKf
	 e3L/PA6LUWFihSvOjdO5U+gwlNcbcqvLI2uZ+WKWF2Oc04TrTiUh0Og5xwQP+SnmQR
	 YKZ4VKBKH5z1PzqExdAVPA3M5LA+XEo68JxKQA68=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJXSgx3941687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:28 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1u3690681;
	Mon, 11 Aug 2025 14:33:24 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 07/10] spi: cadence-quadspi: Enable PHY for aligned DAC reads
Date: Tue, 12 Aug 2025 01:02:16 +0530
Message-ID: <20250811193219.731851-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811193219.731851-1-s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Pratyush Yadav <pratyush@kernel.org>

PHY reads only work at an address that is 16-byte aligned and of size
that is a multiple of 16 bytes. So, enable PHY for the aligned middle
part and read the unaligned start and end part without PHY.

Also, in 8D mode an odd number of bytes cannot be read from the flash
since they would result in half a cycle being left over. memcpy_fromio()
doesn't guarantee of access width size. So, replace memcpy_fromio() with
cqspi_memcpy_fromio().

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 235 +++++++++++++++++++++++++++---
 1 file changed, 215 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1d86a7bc405e..2096027bca4c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -61,15 +61,23 @@ enum {
 
 struct cqspi_st;
 
+struct phy_setting {
+	u8	rx;
+	u8	tx;
+	u8	read_delay;
+};
+
 struct cqspi_flash_pdata {
-	struct cqspi_st	*cqspi;
-	u32		clk_rate;
-	u32		read_delay;
-	u32		tshsl_ns;
-	u32		tsd2d_ns;
-	u32		tchsh_ns;
-	u32		tslch_ns;
-	u8		cs;
+	struct cqspi_st		*cqspi;
+	u32			clk_rate;
+	u32			read_delay;
+	u32			tshsl_ns;
+	u32			tsd2d_ns;
+	u32			tchsh_ns;
+	u32			tslch_ns;
+	u8			cs;
+	bool			use_phy;
+	struct phy_setting	phy_setting;
 };
 
 struct cqspi_st {
@@ -126,6 +134,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
+#define CQSPI_PHY_FREQUENCY			166000000
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -139,12 +148,14 @@ struct cqspi_driver_platdata {
 /* Register map */
 #define CQSPI_REG_CONFIG			0x00
 #define CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
+#define CQSPI_REG_CONFIG_PHY_EN			BIT(3)
 #define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL	BIT(7)
 #define CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
 #define CQSPI_REG_CONFIG_BAUD_LSB		19
 #define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_PHY_PIPELINE		BIT(25)
 #define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
@@ -472,6 +483,65 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi,
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
+static void cqspi_phy_enable(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+
+	if (enable) {
+		cqspi_readdata_capture(cqspi, true,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * Reduce dummy cycle by 1. This is a requirement of PHY mode
+		 * operation for correctly reading the data.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	} else {
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+				       f_pdata->read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+			 CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * Dummy cycles were decremented when enabling PHY. Increment
+		 * dummy cycle by 1 to restore the original value.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy++;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	}
+
+	cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1346,6 +1416,35 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
 }
 
+static bool cqspi_phy_op_eligible_sdr(struct cqspi_flash_pdata *f_pdata,
+				      const struct spi_mem_op *op)
+{
+	if (f_pdata->clk_rate != CQSPI_PHY_FREQUENCY)
+		return false;
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+	if (!(op->addr.nbytes) || op->addr.buswidth < 1)
+		return false;
+	if (!(op->dummy.nbytes) || op->dummy.buswidth < 1)
+		return false;
+	if (!(op->data.nbytes) || op->data.buswidth < 1)
+		return false;
+
+	return true;
+}
+
+static bool cqspi_use_phy(struct cqspi_flash_pdata *f_pdata,
+			  const struct spi_mem_op *op)
+{
+	if (!f_pdata->use_phy)
+		return false;
+
+	if (op->data.nbytes < 16)
+		return false;
+
+	return cqspi_phy_op_eligible_sdr(f_pdata, op);
+}
+
 static void cqspi_rx_dma_callback(void *param)
 {
 	struct cqspi_st *cqspi = param;
@@ -1353,8 +1452,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1366,19 +1465,14 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
 		dev_err(dev, "dma mapping failed\n");
 		return -ENOMEM;
 	}
-	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
-				       len, flags);
+	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src, len,
+				       flags);
 	if (!tx) {
 		dev_err(dev, "device_prep_dma_memcpy error\n");
 		ret = -EIO;
@@ -1398,8 +1492,9 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	}
 
 	dma_async_issue_pending(cqspi->rx_chan);
-	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
-					 msecs_to_jiffies(max_t(size_t, len, 500)))) {
+	if (!wait_for_completion_timeout(
+		    &cqspi->rx_dma_complete,
+		    msecs_to_jiffies(max_t(size_t, len, 500)))) {
 		dmaengine_terminate_sync(cqspi->rx_chan);
 		dev_err(dev, "DMA wait_for_completion_timeout\n");
 		ret = -ETIMEDOUT;
@@ -1412,6 +1507,106 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		/*
+		 * 8D-8D-8D ops with odd length should be rejected by
+		 * supports_op() so no need to worry about that.
+		 */
+		if (count && !IS_ALIGNED((unsigned long)from, 4)) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/*
+		 * The controller can work with both 32-bit and 64-bit
+		 * platforms. 32-bit platforms won't have a readq. So use a
+		 * readl instead.
+		 */
+		if (count >= 4) {
+			int len = round_down(count, 4);
+
+			memcpy_fromio(to, from, len);
+			from += len;
+			to += len;
+			count -= len;
+		}
+
+		if (count) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	loff_t from_aligned, to_aligned;
+	size_t len = op->data.nbytes;
+	size_t len_aligned;
+	u_char *buf = op->data.buf.in;
+	int ret;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) || len <= 16) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	if (!cqspi_use_phy(f_pdata, op))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	/*
+	 * PHY reads must be 16-byte aligned, and they must be a multiple of 16
+	 * bytes.
+	 */
+	from_aligned = (from + 0xF) & ~0xF;
+	to_aligned = (from + len) & ~0xF;
+	len_aligned = to_aligned - from_aligned;
+
+	/* Read the unaligned part at the start. */
+	if (from != from_aligned) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, from,
+					    from_aligned - from);
+		if (ret)
+			return ret;
+		buf += from_aligned - from;
+	}
+
+	if (len_aligned) {
+		cqspi_phy_enable(f_pdata, true);
+		ret = cqspi_direct_read_dma(f_pdata, buf, from_aligned,
+					    len_aligned);
+		cqspi_phy_enable(f_pdata, false);
+		if (ret)
+			return ret;
+		buf += len_aligned;
+	}
+
+	/* Now read the remaining part, if any. */
+	if (to_aligned != (from + len)) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, to_aligned,
+					    (from + len) - to_aligned);
+		if (ret)
+			return ret;
+		buf += (from + len) - to_aligned;
+	}
+
+	return 0;
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 			  const struct spi_mem_op *op)
 {
@@ -1428,7 +1623,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 		return ret;
 
 	if (cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
-- 
2.34.1


