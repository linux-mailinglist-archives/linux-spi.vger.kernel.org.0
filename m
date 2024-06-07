Return-Path: <linux-spi+bounces-3352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41760900893
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A219E1F2502A
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBDF199258;
	Fri,  7 Jun 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cptwJDWE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55A19597A;
	Fri,  7 Jun 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773525; cv=none; b=iGBrg9hU0XtmXblwOee8FU+5NAPsi7LtbZ/s+ki7RKzJ1VAHjnNao/cKkplaGaT9vy/i+rt2WawKYQvEDLtgUuOlyZzwAeu63jZgm6sUJBPbbaWjO5DG/6/DaK8YA0zEFL95uTtaPB5M3XBPPMlyYaScnfLMJrk058sHT2BEmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773525; c=relaxed/simple;
	bh=WKGecMdldqWMEcgIBZFsOLxE2veITfkt7GrgS/wJKTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsE+zsmfZnCFXciaUtM1MEoxbD5rv3s8sRPIPo/DyCsVR+/eOo4lse+cd8KPnX7DhRGUsyubdOc7sW28nU/If+nr16owh4mQ1MEXy/eUrNQqSElUXuxlmF4RRJujzzLa6KXDvdJMmFNDIHFWgS1qQCBtce3SlZpWgVgkfh4fbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cptwJDWE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457AEqoP014883;
	Fri, 7 Jun 2024 08:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	nDa5a2dbGgiMcGKCBGkN9Ue3tnQljIpSGrdAtZZrs0=; b=cptwJDWEfiLALuVrQ
	rllpHbxmdci9jqZOWaYazueb7b5qO595QdcGT4fs8a4gcQlJoLYMcIHXmf9fv/q+
	iOQpvWEh6NOzdeCk245IcwyaOhtVgoG3PvsYiNbElzyxCdq3sH/ykwmmc3ONyvLi
	+F84MgQv9XcouFyF+t8gx6cAt3YtSEMm0GguNdc3WBXHPG+meTmtgpsAdjRmC3fD
	8EmEfUbfGICWbH38cTO/edhZzShx8AS7FIvTdFaRPuibTVMIoOdrkAGsmmTIkVn2
	lZ29N6l1PP9fO1XTZ39gxskYVWL4DmGmUj1M0yJ1KVOyJ9XpFsqtQNPIX9bWfd1G
	AJQxQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ym09ngx2u-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:18:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 7 Jun 2024 08:18:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Jun 2024 08:18:36 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 153F43F7097;
	Fri,  7 Jun 2024 08:18:36 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v8 4/4] spi: cadence: Add MRVL overlay xfer operation support
Date: Fri, 7 Jun 2024 08:18:31 -0700
Message-ID: <20240607151831.3858304-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607151831.3858304-1-wsadowski@marvell.com>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xOWxgSmA3Gl6k_t44i8enqQBbXQlacg1
X-Proofpoint-ORIG-GUID: xOWxgSmA3Gl6k_t44i8enqQBbXQlacg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01

MRVL Xfer overlay extends xSPI capabilities to support non-memory SPI
operations. The Marvell overlay, combined with a generic command, allows
for full-duplex SPI transactions. It also enables transactions with
undetermined lengths using the cs_hold parameter and the ability to
extend CS signal assertion, even if the xSPI block requests CS signal
de-assertion.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 245 +++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 36c6c25aaea0..186a781371a9 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -219,6 +219,7 @@
 #define CDNS_XSPI_DLL_RST_N BIT(24)
 #define CDNS_XSPI_DLL_LOCK  BIT(0)
 
+
 /* Marvell overlay registers - clock */
 #define MRVL_XSPI_CLK_CTRL_AUX_REG   0x2020
 #define MRVL_XSPI_CLK_ENABLE	     BIT(0)
@@ -232,6 +233,22 @@
 #define MRVL_XSPI_SPIX_INTR_AUX	0x2000
 #define MRVL_MSIX_CLEAR_IRQ	0x01
 
+/* Marvell overlay registers - xfer */
+#define MRVL_XFER_FUNC_CTRL		 0x210
+#define MRVL_XFER_FUNC_CTRL_READ_DATA(i) (0x000 + 8 * (i))
+#define MRVL_XFER_SOFT_RESET		 BIT(11)
+#define MRVL_XFER_CS_N_HOLD		 GENMASK(9, 6)
+#define MRVL_XFER_RECEIVE_ENABLE	 BIT(4)
+#define MRVL_XFER_FUNC_ENABLE		 BIT(3)
+#define MRVL_XFER_CLK_CAPTURE_POL	 BIT(2)
+#define MRVL_XFER_CLK_DRIVE_POL		 BIT(1)
+#define MRVL_XFER_FUNC_START		 BIT(0)
+#define MRVL_XFER_QWORD_COUNT		 32
+#define MRVL_XFER_QWORD_BYTECOUNT	 8
+
+#define MRVL_XSPI_POLL_TIMEOUT_US	1000
+#define MRVL_XSPI_POLL_DELAY_US		10
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -256,6 +273,7 @@ struct cdns_xspi_dev {
 	void __iomem *iobase;
 	void __iomem *auxbase;
 	void __iomem *sdmabase;
+	void __iomem *xferbase;
 
 	int irq;
 	int cur_cs;
@@ -270,6 +288,9 @@ struct cdns_xspi_dev {
 	const void *out_buffer;
 
 	u8 hw_num_banks;
+
+	bool xfer_in_progress;
+	int current_xfer_qword;
 };
 
 struct cdns_xspi_driver_data {
@@ -841,6 +862,220 @@ static int cdns_xspi_setup(struct spi_device *spi_dev)
 	return 0;
 }
 
+static int cdns_xspi_prepare_generic(int cs, const void *dout, int len, int glue, u32 *cmd_regs)
+{
+	u8 *data = (u8 *)dout;
+	int i;
+	int data_counter = 0;
+
+	memset(cmd_regs, 0x00, 6*4);
+
+	if (len > 7) {
+		for (i = (len >= 10 ? 2 : len - 8); i >= 0 ; i--)
+			cmd_regs[3] |= data[data_counter++] << (8*i);
+	}
+	if (len > 3) {
+		for (i = (len >= 7 ? 3 : len - 4); i >= 0; i--)
+			cmd_regs[2] |= data[data_counter++] << (8*i);
+	}
+	for (i = (len >= 3 ? 2 : len - 1); i >= 0 ; i--)
+		cmd_regs[1] |= data[data_counter++] << (8 + 8*i);
+
+	cmd_regs[1] |= 96;
+	cmd_regs[3] |= len << 24;
+	cmd_regs[4] |= cs << 12;
+
+	if (glue == 1)
+		cmd_regs[4] |= 1 << 28;
+
+	return 0;
+}
+
+static unsigned char reverse_bits(unsigned char num)
+{
+	unsigned int count = sizeof(num) * 8 - 1;
+	unsigned int reverse_num = num;
+
+	num >>= 1;
+	while (num) {
+		reverse_num <<= 1;
+		reverse_num |= num & 1;
+		num >>= 1;
+		count--;
+	}
+	reverse_num <<= count;
+	return reverse_num;
+}
+
+static void cdns_xspi_read_single_qword(struct cdns_xspi_dev *cdns_xspi, u8 **buffer)
+{
+	u64 d = readq(cdns_xspi->xferbase +
+		      MRVL_XFER_FUNC_CTRL_READ_DATA(cdns_xspi->current_xfer_qword));
+	u8 *ptr = (u8 *)&d;
+	int k;
+
+	for (k = 0; k < 8; k++) {
+		u8 val = reverse_bits((ptr[k]));
+		**buffer = val;
+		*buffer = *buffer + 1;
+	}
+
+	cdns_xspi->current_xfer_qword++;
+	cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
+}
+
+static void cdns_xspi_finish_read(struct cdns_xspi_dev *cdns_xspi, u8 **buffer, u32 data_count)
+{
+	u64 d = readq(cdns_xspi->xferbase +
+		      MRVL_XFER_FUNC_CTRL_READ_DATA(cdns_xspi->current_xfer_qword));
+	u8 *ptr = (u8 *)&d;
+	int k;
+
+	for (k = 0; k < data_count % MRVL_XFER_QWORD_BYTECOUNT; k++) {
+		u8 val = reverse_bits((ptr[k]));
+		**buffer = val;
+		*buffer = *buffer + 1;
+	}
+
+	cdns_xspi->current_xfer_qword++;
+	cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
+}
+
+static int cdns_xspi_prepare_transfer(int cs, int dir, int len, u32 *cmd_regs)
+{
+	memset(cmd_regs, 0x00, 6*4);
+
+	cmd_regs[1] |= 127;
+	cmd_regs[2] |= len << 16;
+	cmd_regs[4] |= dir << 4; //dir = 0 read, dir =1 write
+	cmd_regs[4] |= cs << 12;
+
+	return 0;
+}
+
+static bool cdns_xspi_is_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return !readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_CTRL_STATUS_REG,
+		ctrl_stat,
+		((ctrl_stat & BIT(3)) == 0),
+		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+}
+
+static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return !readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+		ctrl_stat,
+		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
+		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
+		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+}
+
+static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
+					   struct spi_message *m)
+{
+	struct cdns_xspi_dev *cdns_xspi = spi_controller_get_devdata(controller);
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t = NULL;
+
+	const int max_len = MRVL_XFER_QWORD_BYTECOUNT * MRVL_XFER_QWORD_COUNT;
+	int current_cycle_count;
+	int cs = spi_get_chipselect(spi, 0);
+	int cs_change = 0;
+
+	/* Enable xfer state machine */
+	if (!cdns_xspi->xfer_in_progress) {
+		u32 xfer_control = readl(cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+
+		cdns_xspi->current_xfer_qword = 0;
+		cdns_xspi->xfer_in_progress = true;
+		xfer_control |= (MRVL_XFER_RECEIVE_ENABLE |
+				 MRVL_XFER_CLK_CAPTURE_POL |
+				 MRVL_XFER_FUNC_START |
+				 MRVL_XFER_SOFT_RESET |
+				 FIELD_PREP(MRVL_XFER_CS_N_HOLD, (1 << cs)));
+		xfer_control &= ~(MRVL_XFER_FUNC_ENABLE | MRVL_XFER_CLK_DRIVE_POL);
+		writel(xfer_control, cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+	}
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		u8 *txd = (u8 *) t->tx_buf;
+		u8 *rxd = (u8 *) t->rx_buf;
+		u8 data[10];
+		u32 cmd_regs[6];
+
+		if (!txd)
+			txd = data;
+
+		cdns_xspi->in_buffer = txd + 1;
+		cdns_xspi->out_buffer = txd + 1;
+
+		while (t->len) {
+
+			current_cycle_count = t->len > max_len ? max_len : t->len;
+
+			if (current_cycle_count < 10) {
+				cdns_xspi_prepare_generic(cs, txd, current_cycle_count,
+							  false, cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
+					return -EIO;
+			} else {
+				cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				cdns_xspi_prepare_transfer(cs, 1, current_cycle_count - 1,
+							   cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				if (!cdns_xspi_is_sdma_ready(cdns_xspi, true))
+					return -EIO;
+				cdns_xspi_sdma_handle(cdns_xspi);
+				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
+					return -EIO;
+
+				cdns_xspi->in_buffer += current_cycle_count;
+				cdns_xspi->out_buffer += current_cycle_count;
+			}
+
+			if (rxd) {
+				int j;
+
+				for (j = 0; j < current_cycle_count / 8; j++)
+					cdns_xspi_read_single_qword(cdns_xspi, &rxd);
+				cdns_xspi_finish_read(cdns_xspi, &rxd, current_cycle_count);
+			} else {
+				cdns_xspi->current_xfer_qword += current_cycle_count /
+								 MRVL_XFER_QWORD_BYTECOUNT;
+				if (current_cycle_count % MRVL_XFER_QWORD_BYTECOUNT)
+					cdns_xspi->current_xfer_qword++;
+
+				cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
+			}
+			cs_change = t->cs_change;
+			t->len -= current_cycle_count;
+		}
+	}
+
+	if (!cs_change) {
+		u32 xfer_control = readl(cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+
+		xfer_control &= ~(MRVL_XFER_RECEIVE_ENABLE |
+				  MRVL_XFER_SOFT_RESET);
+		writel(xfer_control, cdns_xspi->xferbase + MRVL_XFER_FUNC_CTRL);
+		cdns_xspi->xfer_in_progress = false;
+	}
+
+	m->status = 0;
+	spi_finalize_current_message(controller);
+
+	return 0;
+}
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -908,6 +1143,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_xspi->auxbase);
 	}
 
+	if (cdns_xspi->mrvl_hw_overlay) {
+		cdns_xspi->xferbase = devm_platform_ioremap_resource(pdev, 3);
+		if (IS_ERR(cdns_xspi->xferbase)) {
+			dev_info(dev, "XFER register base not found, set it\n");
+			// For compatibility with older firmware
+			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
+		}
+	}
+
 	cdns_xspi->irq = platform_get_irq(pdev, 0);
 	if (cdns_xspi->irq < 0)
 		return -ENXIO;
@@ -922,6 +1166,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (drv_data->mrvl_hw_overlay) {
 		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
 		cdns_xspi_configure_phy(cdns_xspi);
+		host->transfer_one_message = cdns_xspi_transfer_one_message_b0;
 	}
 
 	cdns_xspi_print_phy_config(cdns_xspi);
-- 
2.43.0


