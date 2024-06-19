Return-Path: <linux-spi+bounces-3479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A6590F011
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBCE1C21FEE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383271DA4C;
	Wed, 19 Jun 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="X/Vr6q4T"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82A1865B;
	Wed, 19 Jun 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806651; cv=none; b=jOgEH9oE8v1lHR62Y8prqH3fvJ0qezWD5aD6JAXaq7h6skdDWreFXHowh4ax51DcBE7svy1kM9sin/JR40eWzXCeGLggj2fqYZUkwh40DlScXWTcuRbf5t8Fq9o1w/aiXC+ksWvHjt79gS7v8Dlv4zk5P8oFBWmYLmtzRoVoa4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806651; c=relaxed/simple;
	bh=G+MwUlz3RHrLKR0a3mkyOZ7XrXFLQPsNMW6+F4Mbhzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPE4sxBeADCZfD3RHFD1IBeeinV9Hw9ciSn1EL2fJIk/cy7RcJMmhdMMiPIQlm+DAk5Vcyxx7VtmC038QUXvmvdBIL9P/wYsscr0V5QphKv+aGohhva2vSy1YpDZnX23vL6kur9QOz1exBuGt+cpi868erVeElhW4vuUIVzwRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=X/Vr6q4T; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9l8if011743;
	Wed, 19 Jun 2024 07:17:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	xAEFIqcyGY9uedGaEFmK20S3ClxyXWNKF0WXtq/g/M=; b=X/Vr6q4T4AnYg/aM3
	8FPJ77jJA/wchzsa7JhpjGfe/EqFujkLjdd4jdTG8B9LJ3DY+QoLxb5rjk28A2Ao
	7hN1R89tka/g99JCDvHZjlPEyCwwnD6PQ55yzbn/7lv8zcSOEss+DGTM6MS87AA6
	FJieCcvDvsjwGVEqSVr6lbeUnZSuzFTdFXIqqxB+SvcTCFPJR9U1LpTithmmtZ6m
	MHB0e+jY2qWL9YW6qc7WGHRzwMDzbr2dTLKpuaJm+fXkxRwP1MTWFQlzZK4fxY4I
	HKwBIkvd9rB7n48vpe2mNw1bpWmKgzeuoAGtEeUuu2/0SOrswhOkodorimUZjiMb
	sMinA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jrudr-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:21 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 04FC63F7081;
	Wed, 19 Jun 2024 07:17:21 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v9 3/9] spi: cadence: Add clock configuration for Marvell xSPI overlay
Date: Wed, 19 Jun 2024 07:17:09 -0700
Message-ID: <20240619141716.1785467-4-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619141716.1785467-1-wsadowski@marvell.com>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DkMVrhdbctBDLK979EX7Lq5YRF7ryPXB
X-Proofpoint-ORIG-GUID: DkMVrhdbctBDLK979EX7Lq5YRF7ryPXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

Add support for clock divider. Divider block can disable, enable and
divide clock signal. Only 14 different divide ratios are avalible, from
6.25 up to 200MHz. For calculations use default Marvell system clock
value(800MHz).

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 97 +++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 70b1b4a0ff13..d0222284c507 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -217,6 +217,15 @@
 #define CDNS_XSPI_DLL_RST_N BIT(24)
 #define CDNS_XSPI_DLL_LOCK  BIT(0)
 
+/* Marvell overlay registers - clock */
+#define MRVL_XSPI_CLK_CTRL_AUX_REG   0x2020
+#define MRVL_XSPI_CLK_ENABLE	     BIT(0)
+#define MRVL_XSPI_CLK_DIV	     GENMASK(4, 1)
+#define MRVL_XSPI_IRQ_ENABLE	     BIT(6)
+#define MRVL_XSPI_CLOCK_IO_HZ	     800000000
+#define MRVL_XSPI_CLOCK_DIVIDED(div) ((MRVL_XSPI_CLOCK_IO_HZ) / (div))
+#define MRVL_DEFAULT_CLK	     25000000
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -261,6 +270,23 @@ static struct cdns_xspi_driver_data cdns_driver_data = {
 	.mrvl_hw_overlay = false,
 };
 
+const int cdns_mrvl_xspi_clk_div_list[] = {
+	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
+	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
+	8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
+	10,	//0x3 = Divide by 10.  SPI clock is 80 MHz.
+	12,	//0x4 = Divide by 12.  SPI clock is 66.666 MHz.
+	16,	//0x5 = Divide by 16.  SPI clock is 50 MHz.
+	18,	//0x6 = Divide by 18.  SPI clock is 44.44 MHz.
+	20,	//0x7 = Divide by 20.  SPI clock is 40 MHz.
+	24,	//0x8 = Divide by 24.  SPI clock is 33.33 MHz.
+	32,	//0x9 = Divide by 32.  SPI clock is 25 MHz.
+	40,	//0xA = Divide by 40.  SPI clock is 20 MHz.
+	50,	//0xB = Divide by 50.  SPI clock is 16 MHz.
+	64,	//0xC = Divide by 64.  SPI clock is 12.5 MHz.
+	128	//0xD = Divide by 128. SPI clock is 6.25 MHz.
+};
+
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct device *dev;
@@ -331,6 +357,48 @@ static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
 	return cdns_xspi_is_dll_locked(cdns_xspi);
 }
 
+static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
+				       int requested_clk)
+{
+	int i = 0;
+	int clk_val;
+	u32 clk_reg;
+	bool update_clk = false;
+
+	while (i < ARRAY_SIZE(cdns_mrvl_xspi_clk_div_list)) {
+		clk_val = MRVL_XSPI_CLOCK_DIVIDED(
+				cdns_mrvl_xspi_clk_div_list[i]);
+		if (clk_val <= requested_clk)
+			break;
+		i++;
+	}
+
+	dev_dbg(cdns_xspi->dev, "Found clk div: %d, clk val: %d\n",
+		cdns_mrvl_xspi_clk_div_list[i],
+		MRVL_XSPI_CLOCK_DIVIDED(
+		cdns_mrvl_xspi_clk_div_list[i]));
+
+	clk_reg = readl(cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
+
+	if (FIELD_GET(MRVL_XSPI_CLK_DIV, clk_reg) != i) {
+		clk_reg &= ~MRVL_XSPI_CLK_ENABLE;
+		writel(clk_reg,
+		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
+		clk_reg = FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
+		clk_reg &= ~MRVL_XSPI_CLK_DIV;
+		clk_reg |= FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
+		clk_reg |= MRVL_XSPI_CLK_ENABLE;
+		clk_reg |= MRVL_XSPI_IRQ_ENABLE;
+		update_clk = true;
+	}
+
+	if (update_clk)
+		writel(clk_reg,
+		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
+
+	return update_clk;
+}
+
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_stat;
@@ -536,6 +604,21 @@ static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
 	return ret;
 }
 
+static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
+				    const struct spi_mem_op *op)
+{
+	struct cdns_xspi_dev *cdns_xspi =
+		spi_controller_get_devdata(mem->spi->controller);
+	int ret = 0;
+
+	cdns_mrvl_xspi_setup_clock(cdns_xspi, mem->spi->max_speed_hz);
+
+	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
+
+	return ret;
+}
+
+
 static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct cdns_xspi_dev *cdns_xspi =
@@ -551,6 +634,11 @@ static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
 
+static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
+	.exec_op = marvell_xspi_mem_op_execute,
+	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
+};
+
 static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 {
 	struct cdns_xspi_dev *cdns_xspi = dev;
@@ -648,7 +736,10 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (!cdns_xspi->driver_data)
 		return -ENODEV;
 
-	host->mem_ops = &cadence_xspi_mem_ops;
+	if (cdns_xspi->driver_data->mrvl_hw_overlay)
+		host->mem_ops = &marvell_xspi_mem_ops;
+	else
+		host->mem_ops = &cadence_xspi_mem_ops;
 	host->dev.of_node = pdev->dev.of_node;
 	host->bus_num = -1;
 
@@ -695,8 +786,10 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (cdns_xspi->driver_data->mrvl_hw_overlay)
+	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
 		cdns_xspi_configure_phy(cdns_xspi);
+	}
 
 	cdns_xspi_print_phy_config(cdns_xspi);
 
-- 
2.43.0


