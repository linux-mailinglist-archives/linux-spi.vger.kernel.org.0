Return-Path: <linux-spi+bounces-3980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA293B428
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 17:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FE71F212F1
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639EA15E5B5;
	Wed, 24 Jul 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aEBXaWVT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7015B987;
	Wed, 24 Jul 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836095; cv=none; b=sw1KGKxk3kaL1Gq5wINa362eRaJpSnKnQz2ah9N3qs2yQ88yF1nkKKCOAu9ngRe8vJbP5QiinxuCZp8oKtUj/W3L3+A29soJskm4TR+JGmd21RMT4bvIFHKZCAYqXdrNMKAgnKJB5kbPEU3+umPKHqLRjHIgJP8+WdSRctj2RWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836095; c=relaxed/simple;
	bh=13BbAyB+MhLrZ/RAst4pg7cFayKlQOwS6KYT8yJT44I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lg8lEBIIpG7WxiQ+P8GHnii/LMn1IZrbFJNkFpp+WoBURCV9X1byepulttQGvbE0bltdASJ9n5CTl/sICvlsUUWHSzz6oBQuBAlWhU9KtgCWaDt+/hyc53/V6tRzKnq7lH1EQnqRY3DBjZiwwAZpBfU6JanFczBUIH/E6dQ2cbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aEBXaWVT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OEGNFN001424;
	Wed, 24 Jul 2024 08:47:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	jFRuhlHwNnZyquoPIAo2NWv1uDnlWUPxZDl4u49QfA=; b=aEBXaWVTYnN0/zX8G
	dCMhsPmhmb1jgmnMfcx3J85+/6PjlPn+uJIggEoWIjrAiV2G+lYy0yGRr7kVGGcp
	DAg1/6HEx3J2+3eRKpVbjXl3irbPwpakSGXFWOLDJpf6UJAvvF3/s37nx3pwyK4Y
	0EjlnSEFzm+FVAUIjW/NfPgFpdRXphSWji03qmrI64Z3LNQBaD19earAh3pvWj2m
	TYK4AW18gf6k2wFM4Nutdxj1eJo1ntrNFXRag1Gf9g+7W1uaY9JrvWAMETbY+yAN
	zQQ9khhGKWcXeeAfHjmAMfpclD5vhkoFCNaGnMPUeCUHaeh/VnMVqOGY+87BBt1R
	mN6AA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40k0yh1d6c-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 08:47:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Jul 2024 08:47:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 24 Jul 2024 08:47:55 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id EC6DD3F7071;
	Wed, 24 Jul 2024 08:47:54 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v11 2/9] spi: cadence: Add static PHY configuration in Marvell overlay
Date: Wed, 24 Jul 2024 08:47:32 -0700
Message-ID: <20240724154739.582367-3-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724154739.582367-1-wsadowski@marvell.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rBsxdr_OuFgDnGCVaDd0fsonFau51Ncu
X-Proofpoint-ORIG-GUID: rBsxdr_OuFgDnGCVaDd0fsonFau51Ncu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

This commit adds support for static PHY configuration of Cadence xSPI
block. Configuration will be applied only if Marvell overlay compatible
string will be detected. Configuration is static over the whole
frequency range.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 113 ++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 2e3eacd46b72..70b1b4a0ff13 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -193,6 +193,30 @@
 		((op)->data.dir == SPI_MEM_DATA_IN) ? \
 		CDNS_XSPI_STIG_CMD_DIR_READ : CDNS_XSPI_STIG_CMD_DIR_WRITE))
 
+/* Marvell PHY default values */
+#define MARVELL_REGS_DLL_PHY_CTRL		0x00000707
+#define MARVELL_CTB_RFILE_PHY_CTRL		0x00004000
+#define MARVELL_RFILE_PHY_TSEL			0x00000000
+#define MARVELL_RFILE_PHY_DQ_TIMING		0x00000101
+#define MARVELL_RFILE_PHY_DQS_TIMING		0x00700404
+#define MARVELL_RFILE_PHY_GATE_LPBK_CTRL	0x00200030
+#define MARVELL_RFILE_PHY_DLL_MASTER_CTRL	0x00800000
+#define MARVELL_RFILE_PHY_DLL_SLAVE_CTRL	0x0000ff01
+
+/* PHY config registers */
+#define CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL			0x1034
+#define CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL			0x0080
+#define CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL			0x0084
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING		0x0000
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING		0x0004
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL	0x0008
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL	0x000c
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL	0x0010
+#define CDNS_XSPI_DATASLICE_RFILE_PHY_DLL_OBS_REG_0		0x001c
+
+#define CDNS_XSPI_DLL_RST_N BIT(24)
+#define CDNS_XSPI_DLL_LOCK  BIT(0)
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -209,6 +233,34 @@ enum cdns_xspi_stig_cmd_dir {
 	CDNS_XSPI_STIG_CMD_DIR_WRITE,
 };
 
+struct cdns_xspi_driver_data {
+	bool mrvl_hw_overlay;
+	u32 dll_phy_ctrl;
+	u32 ctb_rfile_phy_ctrl;
+	u32 rfile_phy_tsel;
+	u32 rfile_phy_dq_timing;
+	u32 rfile_phy_dqs_timing;
+	u32 rfile_phy_gate_lpbk_ctrl;
+	u32 rfile_phy_dll_master_ctrl;
+	u32 rfile_phy_dll_slave_ctrl;
+};
+
+static struct cdns_xspi_driver_data marvell_driver_data = {
+	.mrvl_hw_overlay = true,
+	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
+	.ctb_rfile_phy_ctrl = MARVELL_CTB_RFILE_PHY_CTRL,
+	.rfile_phy_tsel = MARVELL_RFILE_PHY_TSEL,
+	.rfile_phy_dq_timing = MARVELL_RFILE_PHY_DQ_TIMING,
+	.rfile_phy_dqs_timing = MARVELL_RFILE_PHY_DQS_TIMING,
+	.rfile_phy_gate_lpbk_ctrl = MARVELL_RFILE_PHY_GATE_LPBK_CTRL,
+	.rfile_phy_dll_master_ctrl = MARVELL_RFILE_PHY_DLL_MASTER_CTRL,
+	.rfile_phy_dll_slave_ctrl = MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
+};
+
+static struct cdns_xspi_driver_data cdns_driver_data = {
+	.mrvl_hw_overlay = false,
+};
+
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct device *dev;
@@ -230,8 +282,55 @@ struct cdns_xspi_dev {
 	const void *out_buffer;
 
 	u8 hw_num_banks;
+
+	const struct cdns_xspi_driver_data *driver_data;
 };
 
+static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_cntrl = readl(cdns_xspi->iobase +
+			      CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+
+	/* Reset DLL */
+	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
+	writel(dll_cntrl, cdns_xspi->iobase +
+			  CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+}
+
+static bool cdns_xspi_is_dll_locked(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_lock;
+
+	return !readl_relaxed_poll_timeout(cdns_xspi->iobase +
+		CDNS_XSPI_INTR_STATUS_REG,
+		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);
+}
+
+/* Static configuration of PHY */
+static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
+{
+	writel(cdns_xspi->driver_data->dll_phy_ctrl,
+	       cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+	writel(cdns_xspi->driver_data->ctb_rfile_phy_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL);
+	writel(cdns_xspi->driver_data->rfile_phy_tsel,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL);
+	writel(cdns_xspi->driver_data->rfile_phy_dq_timing,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING);
+	writel(cdns_xspi->driver_data->rfile_phy_dqs_timing,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING);
+	writel(cdns_xspi->driver_data->rfile_phy_gate_lpbk_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
+	writel(cdns_xspi->driver_data->rfile_phy_dll_master_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL);
+	writel(cdns_xspi->driver_data->rfile_phy_dll_slave_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL);
+
+	cdns_xspi_reset_dll(cdns_xspi);
+
+	return cdns_xspi_is_dll_locked(cdns_xspi);
+}
+
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_stat;
@@ -544,13 +643,17 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL |
 		SPI_MODE_0  | SPI_MODE_3;
 
+	cdns_xspi = spi_controller_get_devdata(host);
+	cdns_xspi->driver_data = of_device_get_match_data(dev);
+	if (!cdns_xspi->driver_data)
+		return -ENODEV;
+
 	host->mem_ops = &cadence_xspi_mem_ops;
 	host->dev.of_node = pdev->dev.of_node;
 	host->bus_num = -1;
 
 	platform_set_drvdata(pdev, host);
 
-	cdns_xspi = spi_controller_get_devdata(host);
 	cdns_xspi->pdev = pdev;
 	cdns_xspi->dev = &pdev->dev;
 	cdns_xspi->cur_cs = 0;
@@ -592,6 +695,9 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (cdns_xspi->driver_data->mrvl_hw_overlay)
+		cdns_xspi_configure_phy(cdns_xspi);
+
 	cdns_xspi_print_phy_config(cdns_xspi);
 
 	ret = cdns_xspi_controller_init(cdns_xspi);
@@ -616,6 +722,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",
+		.data = &cdns_driver_data,
+	},
+	{
+		.compatible = "marvell,cn10-xspi-nor",
+		.data = &marvell_driver_data,
 	},
 	{ /* end of table */}
 };
-- 
2.43.0


