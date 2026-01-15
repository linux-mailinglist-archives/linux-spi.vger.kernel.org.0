Return-Path: <linux-spi+bounces-12390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4472D23916
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7B09314DD07
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244A3815E5;
	Thu, 15 Jan 2026 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fyJTSoCa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128336D4E7;
	Thu, 15 Jan 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469154; cv=none; b=jHwqMjOHgeAi0h7ae0MMyQqjbGYobgYbIEYCeaovt99n4Kp/Be2KXZcc+Dfcp7hDsV6Y4BWTzp/RaYZUX5GLuF5Kdh98qUAy6RFH3oyaY3mBVRkIFk+z61qgvNYDBS3fEFA0qMvvSrLQnrQdtjnabyZCl0m6Hh7xWD8k5MSAi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469154; c=relaxed/simple;
	bh=YpDz/vG3DLbjkSP8w4hH9fZsadfIh0jV+dj16U2Mki4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YaolgdmvdoFM8CaBGjFGOcecwK/S9sgMavNzgUk2hHIts9J45l6zMJMItMZQhjMINHqwgCX9dkMjwfe8Ic1lI3Hi6jjGB0YggmbV3iMO+V2LMoj27VzzUaFSIzwQ2lTF4c5tFPJbNs+NPXflAlJCnTZ+LHBqdqnug032aY/nPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fyJTSoCa; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EB9704E420F8;
	Thu, 15 Jan 2026 09:25:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE9E3606B6;
	Thu, 15 Jan 2026 09:25:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFB4710B684F6;
	Thu, 15 Jan 2026 10:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m2OlrB1WHxCAT8bt6bn0v6vCet93lc8eeCwRus+Rn4A=;
	b=fyJTSoCa/xmuWaNWYHiuD3d6R8B3Gs1Qxq+IlyvQMrpPe/xdcNHB6JzEB/KRSX36dPpiS1
	NrwAyLACwTCRLosCoW19rlJCKhCQkf+SDi6nqN287hUa9pB6mUZZ6jPqcTNNGmatVvQMLK
	/Lu3udZQrB8htsitlc2CesheJbeaSYePx39BJ6ica7XXxrSK0A5CVpEwbcFkrD/DncRkk0
	9HSa/d2yr5Zqzo73SnBE8rWU6sbjOQncCdpZtTTQskh+K3uz8om1FBk6plsX6+zSyzzSZF
	yIdJjfHOavoCba3oOGPE6QZNxVA08PZsH3VHl7HN0QrWZj6WAG0s9xkIuQ7GHQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:25:00 +0100
Subject: [PATCH v2 09/13] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-9-7e6a06e1e17b@bootlin.com>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This controller can be fed by either a main "ref" clock, or three clocks
("ref" again, "ahb", "apb"). In practice, it is likely that all
controllers have the same inputs, but a single clock feeds the three
interfaces (ref is used for controlling the external interface, ahb/apb
the internal ones). Handling these clocks is in no way SoC specific,
only the number of expected clocks may change. Plus, we will soon be
adding another controller requiring an AHB and an APB clock as well, so
it is time to align the whole clock handling.

Furthermore, the use of the cqspi_jh7110_clk_init() helper, which
specifically grabs and enables the "ahb" and "apb" clocks, is a bit
convoluted:
- only the JH7110 compatible provides the ->jh7110_clk_init() callback,
- in the probe, if the above callback is set in the driver data, the
  driver does not call the callback (!) but instead calls the helper
  directly (?),
- in the helper, the is_jh7110 boolean is set.

This logic does not make sense. Instead:
- in the probe, set the is_jh7110 boolean based on the compatible,
- collect all available clocks with the "bulk" helper,
- enable the extra clocks if they are available,
- kill the SoC specific cqspi_jh7110_clk_init() helper.

This also allows to group the clock handling instead of depending on the
driver data pointer, which further simplifies the error path and the
remove callback.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 120 ++++++++++++--------------------------
 1 file changed, 37 insertions(+), 83 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index af0ad24d8d39..e389422fe95e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -55,7 +55,8 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_OP_WIDTH(part) ((part).nbytes ? ilog2((part).buswidth) : 0)
 
 enum {
-	CLK_QSPI_APB = 0,
+	CLK_QSPI_REF = 0,
+	CLK_QSPI_APB,
 	CLK_QSPI_AHB,
 	CLK_QSPI_NUM,
 };
@@ -76,8 +77,7 @@ struct cqspi_flash_pdata {
 struct cqspi_st {
 	struct platform_device	*pdev;
 	struct spi_controller	*host;
-	struct clk		*clk;
-	struct clk		*clks[CLK_QSPI_NUM];
+	struct clk_bulk_data	clks[CLK_QSPI_NUM];
 	unsigned int		sclk;
 
 	void __iomem		*iobase;
@@ -121,8 +121,6 @@ struct cqspi_driver_platdata {
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
-	int (*jh7110_clk_init)(struct platform_device *pdev,
-			       struct cqspi_st *cqspi);
 };
 
 /* Operation timeout value */
@@ -1763,61 +1761,20 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 	return 0;
 }
 
-static int cqspi_jh7110_clk_init(struct platform_device *pdev, struct cqspi_st *cqspi)
-{
-	static struct clk_bulk_data qspiclk[] = {
-		{ .id = "apb" },
-		{ .id = "ahb" },
-	};
-
-	int ret = 0;
-
-	ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(qspiclk), qspiclk);
-	if (ret) {
-		dev_err(&pdev->dev, "%s: failed to get qspi clocks\n", __func__);
-		return ret;
-	}
-
-	cqspi->clks[CLK_QSPI_APB] = qspiclk[0].clk;
-	cqspi->clks[CLK_QSPI_AHB] = qspiclk[1].clk;
-
-	ret = clk_prepare_enable(cqspi->clks[CLK_QSPI_APB]);
-	if (ret) {
-		dev_err(&pdev->dev, "%s: failed to enable CLK_QSPI_APB\n", __func__);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(cqspi->clks[CLK_QSPI_AHB]);
-	if (ret) {
-		dev_err(&pdev->dev, "%s: failed to enable CLK_QSPI_AHB\n", __func__);
-		goto disable_apb_clk;
-	}
-
-	cqspi->is_jh7110 = true;
-
-	return 0;
-
-disable_apb_clk:
-	clk_disable_unprepare(cqspi->clks[CLK_QSPI_APB]);
-
-	return ret;
-}
-
-static void cqspi_jh7110_disable_clk(struct platform_device *pdev, struct cqspi_st *cqspi)
-{
-	clk_disable_unprepare(cqspi->clks[CLK_QSPI_AHB]);
-	clk_disable_unprepare(cqspi->clks[CLK_QSPI_APB]);
-}
 static int cqspi_probe(struct platform_device *pdev)
 {
 	const struct cqspi_driver_platdata *ddata;
 	struct reset_control *rstc, *rstc_ocp, *rstc_ref;
+	static const char *clk_ids[CLK_QSPI_NUM] = {
+		[CLK_QSPI_REF] = "ref",
+		[CLK_QSPI_APB] = "apb",
+		[CLK_QSPI_AHB] = "ahb",
+	};
 	struct device *dev = &pdev->dev;
 	struct spi_controller *host;
 	struct resource *res_ahb;
 	struct cqspi_st *cqspi;
-	int ret;
-	int irq;
+	int ret, i, irq;
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*cqspi));
 	if (!host)
@@ -1829,10 +1786,11 @@ static int cqspi_probe(struct platform_device *pdev)
 	host->dev.of_node = pdev->dev.of_node;
 
 	cqspi = spi_controller_get_devdata(host);
+	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi"))
+		cqspi->is_jh7110 = true;
 
 	cqspi->pdev = pdev;
 	cqspi->host = host;
-	cqspi->is_jh7110 = false;
 	cqspi->ddata = ddata = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, cqspi);
 
@@ -1849,12 +1807,17 @@ static int cqspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Obtain QSPI clock. */
-	cqspi->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(cqspi->clk)) {
-		dev_err(dev, "Cannot claim QSPI clock.\n");
-		ret = PTR_ERR(cqspi->clk);
-		return ret;
+	/* Obtain QSPI clocks. */
+	for (i = 0; i < CLK_QSPI_NUM; ++i)
+		cqspi->clks[i].id = clk_ids[i];
+
+	ret = devm_clk_bulk_get_optional(dev, CLK_QSPI_NUM, cqspi->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get clocks\n");
+
+	if (!cqspi->clks[CLK_QSPI_REF].clk) {
+		dev_err(dev, "Cannot claim mandatory QSPI ref clock.\n");
+		return -ENODEV;
 	}
 
 	/* Obtain and remap controller address. */
@@ -1886,10 +1849,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-
-	ret = clk_prepare_enable(cqspi->clk);
+	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret) {
-		dev_err(dev, "Cannot enable QSPI clock.\n");
+		dev_err(dev, "Cannot enable QSPI clocks.\n");
 		goto disable_rpm;
 	}
 
@@ -1898,22 +1860,22 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
 		dev_err(dev, "Cannot get QSPI reset.\n");
-		goto disable_clk;
+		goto disable_clks;
 	}
 
 	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
 	if (IS_ERR(rstc_ocp)) {
 		ret = PTR_ERR(rstc_ocp);
 		dev_err(dev, "Cannot get QSPI OCP reset.\n");
-		goto disable_clk;
+		goto disable_clks;
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
+	if (cqspi->is_jh7110) {
 		rstc_ref = devm_reset_control_get_optional_exclusive(dev, "rstc_ref");
 		if (IS_ERR(rstc_ref)) {
 			ret = PTR_ERR(rstc_ref);
 			dev_err(dev, "Cannot get QSPI REF reset.\n");
-			goto disable_clk;
+			goto disable_clks;
 		}
 		reset_control_assert(rstc_ref);
 		reset_control_deassert(rstc_ref);
@@ -1925,7 +1887,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	reset_control_assert(rstc_ocp);
 	reset_control_deassert(rstc_ocp);
 
-	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
+	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clks[CLK_QSPI_REF].clk);
 	host->max_speed_hz = cqspi->master_ref_clk_hz;
 
 	/* write completion is supported by default */
@@ -1951,12 +1913,6 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->slow_sram = true;
 		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
 			cqspi->apb_ahb_hazard = true;
-
-		if (ddata->jh7110_clk_init) {
-			ret = cqspi_jh7110_clk_init(pdev, cqspi);
-			if (ret)
-				goto disable_clk;
-		}
 		if (ddata->quirks & CQSPI_DISABLE_STIG_MODE)
 			cqspi->disable_stig_mode = true;
 
@@ -2022,11 +1978,8 @@ static int cqspi_probe(struct platform_device *pdev)
 disable_controller:
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
-	if (cqspi->is_jh7110)
-		cqspi_jh7110_disable_clk(pdev, cqspi);
-disable_clk:
 	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_disable_unprepare(cqspi->clk);
+		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 disable_rpm:
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
@@ -2055,14 +2008,12 @@ static void cqspi_remove(struct platform_device *pdev)
 
 	cqspi_controller_enable(cqspi, 0);
 
-	if (cqspi->is_jh7110)
-		cqspi_jh7110_disable_clk(pdev, cqspi);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		ret = pm_runtime_get_sync(&pdev->dev);
 
 	if (ret >= 0)
-		clk_disable(cqspi->clk);
+		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_put_sync(&pdev->dev);
@@ -2075,15 +2026,19 @@ static int cqspi_runtime_suspend(struct device *dev)
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
 
 	cqspi_controller_enable(cqspi, 0);
-	clk_disable_unprepare(cqspi->clk);
+	clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 	return 0;
 }
 
 static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(cqspi->clk);
 	cqspi_wait_idle(cqspi);
 	cqspi_controller_enable(cqspi, 0);
 	cqspi_controller_init(cqspi);
@@ -2166,7 +2121,6 @@ static const struct cqspi_driver_platdata versal2_ospi = {
 
 static const struct cqspi_driver_platdata jh7110_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
-	.jh7110_clk_init = cqspi_jh7110_clk_init,
 };
 
 static const struct cqspi_driver_platdata pensando_cdns_qspi = {

-- 
2.51.1


