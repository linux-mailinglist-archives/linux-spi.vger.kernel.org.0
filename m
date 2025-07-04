Return-Path: <linux-spi+bounces-9041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E342AF8ADD
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 10:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019C3188AF1B
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EE42F6FB3;
	Fri,  4 Jul 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSAZKIMQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E62F6FA2;
	Fri,  4 Jul 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615714; cv=none; b=L6Axufynoe41J2xZz8GHbAZM7bS9c3U86ZIu/cixVIdPR0b3I3Sd+SJGc0ug7L3oBdjvWkHW7hOyfdEx4iQ/GMPRtDeqw0BUzSmMLeQOOxvwrFHQlMYEnzMG46lrHbL1W6AQYASjvfF9xqvAnmggy8xG418R+xRbpz98mqXNLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615714; c=relaxed/simple;
	bh=qdmUiSbcVU8OwH5Ch7+z/U3eHB06Y+cXa7QkEocRcdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rF0wzXH6AUxyv1RoeyN3JfsA1Q8UuWdcfrhKoVZmHX1F4QAFInNPLsuITDJkPvflaU44S6PtNvypKGfFK3CWTTlZcrAH9ySTqgY1sZwuP8l2fv5bfqRYVwTgIWLHeG7ifijILUuNW9Aj1QqU6Pr28oAyamJUNrQRLsy4EeDEzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSAZKIMQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615711; x=1783151711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qdmUiSbcVU8OwH5Ch7+z/U3eHB06Y+cXa7QkEocRcdI=;
  b=QSAZKIMQDRI+1qa9XOLSSI/Zl1X1oF8igjlxJfwj2IuWYdRALukGXgbn
   owub1p7EXGx8bLXJFR4XUOC4rkmCYuedPrf2LcPfqf8UzTO/FSlpddcvM
   xGEC6QfxDB72f0KY3wrJdxxcbZ5Hj7vE8I3Yv44RJPKutyo92haMeCsyH
   AcFKStZX4G5TE1sKyqNYY3cR+D7sn+m2/A54F2fXzqTWRBtc/pCE8CPSx
   iorZeEjVa+PB9Ca22MpSVtekZ+vfZJwkmNV68kW7fCccCWHOULucGrP3A
   hRuxenjZ+7L6vReKAbAqJ6GUiyGdDsOL1dF30nJq1+rfKzKI+ePEGYtdV
   Q==;
X-CSE-ConnectionGUID: OHzUPzXrTyatvIU/TSJ6tA==
X-CSE-MsgGUID: aD1R6UxvQROVu1pVNR+b1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194309"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194309"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:55:03 -0700
X-CSE-ConnectionGUID: bwddRgeVRwqpKScWUZtONQ==
X-CSE-MsgGUID: k8eLgNmTQQGdFKgWydH4aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616645"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:50 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 1923F44424;
	Fri,  4 Jul 2025 10:54:48 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 61/80] spi: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:47 +0300
Message-Id: <20250704075447.3221784-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/spi/atmel-quadspi.c       | 5 -----
 drivers/spi/spi-cadence-quadspi.c | 2 --
 drivers/spi/spi-cadence.c         | 1 -
 drivers/spi/spi-fsl-espi.c        | 2 --
 drivers/spi/spi-fsl-lpspi.c       | 2 --
 drivers/spi/spi-imx.c             | 3 ---
 drivers/spi/spi-mtk-nor.c         | 1 -
 drivers/spi/spi-nxp-fspi.c        | 1 -
 drivers/spi/spi-omap2-mcspi.c     | 3 ---
 drivers/spi/spi-rockchip-sfc.c    | 3 ---
 drivers/spi/spi-s3c64xx.c         | 3 ---
 drivers/spi/spi-sprd.c            | 1 -
 drivers/spi/spi-stm32-ospi.c      | 7 -------
 drivers/spi/spi-stm32-qspi.c      | 7 -------
 drivers/spi/spi-stm32.c           | 2 --
 drivers/spi/spi-ti-qspi.c         | 2 --
 drivers/spi/spi-zynqmp-gqspi.c    | 1 -
 drivers/spi/spi.c                 | 3 ---
 18 files changed, 49 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fc555c0ce52e..4e9bfd26aa80 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -965,7 +965,6 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	err = aq->ops->transfer(mem, op, offset);
 
 pm_runtime_put:
-	pm_runtime_mark_last_busy(&aq->pdev->dev);
 	pm_runtime_put_autosuspend(&aq->pdev->dev);
 	return err;
 }
@@ -1168,7 +1167,6 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	aq->scr |= QSPI_SCR_SCBR(scbr);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
-	pm_runtime_mark_last_busy(ctrl->dev.parent);
 	pm_runtime_put_autosuspend(ctrl->dev.parent);
 
 	return 0;
@@ -1230,7 +1228,6 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
 	aq->mr |= QSPI_MR_DLYBCT(cs_hold) | QSPI_MR_DLYCS(cs_inactive);
 	atmel_qspi_write(aq->mr, aq, QSPI_MR);
 
-	pm_runtime_mark_last_busy(ctrl->dev.parent);
 	pm_runtime_put_autosuspend(ctrl->dev.parent);
 
 	return 0;
@@ -1435,7 +1432,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
@@ -1560,7 +1556,6 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index aa1932ba17cb..82f1c4d59af8 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1469,7 +1469,6 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	ret = cqspi_mem_process(mem, op);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	if (ret)
@@ -1975,7 +1974,6 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 9e56bde87768..5ae09b21d23a 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -662,7 +662,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		/* Set to default valid value */
 		ctlr->max_speed_hz = xspi->clk_rate / 4;
 		xspi->speed_hz = ctlr->max_speed_hz;
-		pm_runtime_mark_last_busy(&pdev->dev);
 		pm_runtime_put_autosuspend(&pdev->dev);
 	} else {
 		ctlr->mode_bits |= SPI_NO_CS;
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6a73eaa34cf7..f2f1d3298e6c 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -513,7 +513,6 @@ static int fsl_espi_setup(struct spi_device *spi)
 
 	fsl_espi_setup_transfer(spi, NULL);
 
-	pm_runtime_mark_last_busy(espi->dev);
 	pm_runtime_put_autosuspend(espi->dev);
 
 	return 0;
@@ -726,7 +725,6 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 
 	dev_info(dev, "irq = %u\n", irq);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 5e3818445234..67d4000c3cef 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -233,7 +233,6 @@ static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(controller);
 
-	pm_runtime_mark_last_busy(fsl_lpspi->dev);
 	pm_runtime_put_autosuspend(fsl_lpspi->dev);
 
 	return 0;
@@ -966,7 +965,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		goto free_dma;
 	}
 
-	pm_runtime_mark_last_busy(fsl_lpspi->dev);
 	pm_runtime_put_autosuspend(fsl_lpspi->dev);
 
 	return 0;
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c93d80a4d734..155ddeb8fcd4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1748,7 +1748,6 @@ spi_imx_prepare_message(struct spi_controller *controller, struct spi_message *m
 
 	ret = spi_imx->devtype_data->prepare_message(spi_imx, msg);
 	if (ret) {
-		pm_runtime_mark_last_busy(spi_imx->dev);
 		pm_runtime_put_autosuspend(spi_imx->dev);
 	}
 
@@ -1760,7 +1759,6 @@ spi_imx_unprepare_message(struct spi_controller *controller, struct spi_message
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
-	pm_runtime_mark_last_busy(spi_imx->dev);
 	pm_runtime_put_autosuspend(spi_imx->dev);
 	return 0;
 }
@@ -1933,7 +1931,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_register_controller;
 	}
 
-	pm_runtime_mark_last_busy(spi_imx->dev);
 	pm_runtime_put_autosuspend(spi_imx->dev);
 
 	return ret;
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 85ab5ce96c4d..5cc4632e13d7 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -918,7 +918,6 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_probe;
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_info(&pdev->dev, "spi frequency: %d Hz\n", sp->spi_freq);
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e63c77e41823..c7d4827f1bf1 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -968,7 +968,6 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Invalidate the data in the AHB buffer. */
 	nxp_fspi_invalid(f);
 
-	pm_runtime_mark_last_busy(f->dev);
 	pm_runtime_put_autosuspend(f->dev);
 
 	return err;
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 70bb74b3bd9c..6dc58a30804a 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -272,7 +272,6 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 
 		mcspi_write_chconf0(spi, l);
 
-		pm_runtime_mark_last_busy(mcspi->dev);
 		pm_runtime_put_autosuspend(mcspi->dev);
 	}
 }
@@ -1102,7 +1101,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 	if (ret && initial_setup)
 		omap2_mcspi_cleanup(spi);
 
-	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
 
 	return ret;
@@ -1379,7 +1377,6 @@ static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 	ctx->wakeupenable = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 
 	omap2_mcspi_set_mode(ctlr);
-	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
 	return 0;
 }
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index f3fe10eddb6a..9eba5c0a60f2 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -565,7 +565,6 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 
 	ret = rockchip_sfc_xfer_done(sfc, 100000);
 out:
-	pm_runtime_mark_last_busy(sfc->dev);
 	pm_runtime_put_autosuspend(sfc->dev);
 
 	return ret;
@@ -712,7 +711,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_register;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -799,7 +797,6 @@ static int rockchip_sfc_resume(struct device *dev)
 
 	rockchip_sfc_init(sfc);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9c47f5741c5f..b1567243ae19 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1045,14 +1045,12 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		}
 	}
 
-	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	s3c64xx_spi_set_cs(spi, false);
 
 	return 0;
 
 setup_exit:
-	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
 	s3c64xx_spi_set_cs(spi, false);
@@ -1384,7 +1382,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
 		mem_res, sdd->fifo_depth);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index ae794058b381..ad75f5f0f2bf 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -982,7 +982,6 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_rpm_put;
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 4ab7e86f4bd5..2829535e5cd4 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -547,7 +547,6 @@ static int stm32_ospi_poll_status(struct spi_mem *mem,
 	ret = stm32_ospi_send(mem->spi, op);
 	mutex_unlock(&ospi->lock);
 
-	pm_runtime_mark_last_busy(ospi->dev);
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return ret;
@@ -571,7 +570,6 @@ static int stm32_ospi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	ret = stm32_ospi_send(mem->spi, op);
 	mutex_unlock(&ospi->lock);
 
-	pm_runtime_mark_last_busy(ospi->dev);
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return ret;
@@ -628,7 +626,6 @@ static ssize_t stm32_ospi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	ret = stm32_ospi_send(desc->mem->spi, &op);
 	mutex_unlock(&ospi->lock);
 
-	pm_runtime_mark_last_busy(ospi->dev);
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return ret ?: len;
@@ -713,7 +710,6 @@ static int stm32_ospi_transfer_one_message(struct spi_controller *ctrl,
 	msg->status = ret;
 	spi_finalize_current_message(ctrl);
 
-	pm_runtime_mark_last_busy(ospi->dev);
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return ret;
@@ -750,7 +746,6 @@ static int stm32_ospi_setup(struct spi_device *spi)
 
 	mutex_unlock(&ospi->lock);
 
-	pm_runtime_mark_last_busy(ospi->dev);
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return 0;
@@ -953,7 +948,6 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 		goto err_pm_resume;
 	}
 
-	pm_runtime_mark_last_busy(ospi->dev);
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return 0;
@@ -1032,7 +1026,6 @@ static int __maybe_unused stm32_ospi_resume(struct device *dev)
 
 	writel_relaxed(ospi->cr_reg, regs_base + OSPI_CR);
 	writel_relaxed(ospi->dcr_reg, regs_base + OSPI_DCR1);
-	pm_runtime_mark_last_busy(ospi->dev);
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return 0;
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 9691197bbf5a..f2d19f1c5ab1 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -463,7 +463,6 @@ static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *
 	ret = stm32_qspi_send(mem->spi, op);
 	mutex_unlock(&qspi->lock);
 
-	pm_runtime_mark_last_busy(qspi->dev);
 	pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret;
@@ -487,7 +486,6 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	ret = stm32_qspi_send(mem->spi, op);
 	mutex_unlock(&qspi->lock);
 
-	pm_runtime_mark_last_busy(qspi->dev);
 	pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret;
@@ -543,7 +541,6 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	ret = stm32_qspi_send(desc->mem->spi, &op);
 	mutex_unlock(&qspi->lock);
 
-	pm_runtime_mark_last_busy(qspi->dev);
 	pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret ?: len;
@@ -627,7 +624,6 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 	msg->status = ret;
 	spi_finalize_current_message(ctrl);
 
-	pm_runtime_mark_last_busy(qspi->dev);
 	pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret;
@@ -684,7 +680,6 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
 	mutex_unlock(&qspi->lock);
 
-	pm_runtime_mark_last_busy(qspi->dev);
 	pm_runtime_put_autosuspend(qspi->dev);
 
 	return 0;
@@ -858,7 +853,6 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_runtime_free;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -938,7 +932,6 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3d20f09f1ae7..e8f3eff71b0e 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2469,7 +2469,6 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_info(&pdev->dev, "driver initialized (%s mode)\n",
@@ -2588,7 +2587,6 @@ static int __maybe_unused stm32_spi_resume(struct device *dev)
 
 	spi->cfg->config(spi);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index a284d2794586..0b7eaccbc797 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -158,7 +158,6 @@ static int ti_qspi_setup(struct spi_device *spi)
 		return ret;
 	}
 
-	pm_runtime_mark_last_busy(qspi->dev);
 	ret = pm_runtime_put_autosuspend(qspi->dev);
 	if (ret < 0) {
 		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
@@ -195,7 +194,6 @@ static void ti_qspi_setup_clk(struct ti_qspi *qspi, u32 speed_hz)
 		ctx_reg->clkctrl = clk_ctrl_new;
 	}
 
-	pm_runtime_mark_last_busy(qspi->dev);
 	pm_runtime_put_autosuspend(qspi->dev);
 }
 
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 595b6dc10845..502fd5eccc83 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1330,7 +1330,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1bc0fdbb1bd7..91413cc0936a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1723,7 +1723,6 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
 static void spi_idle_runtime_pm(struct spi_controller *ctlr)
 {
 	if (ctlr->auto_runtime_pm) {
-		pm_runtime_mark_last_busy(ctlr->dev.parent);
 		pm_runtime_put_autosuspend(ctlr->dev.parent);
 	}
 }
@@ -3856,7 +3855,6 @@ static int spi_set_cs_timing(struct spi_device *spi)
 			}
 
 			status = spi->controller->set_cs_timing(spi);
-			pm_runtime_mark_last_busy(parent);
 			pm_runtime_put_autosuspend(parent);
 		} else {
 			status = spi->controller->set_cs_timing(spi);
@@ -3991,7 +3989,6 @@ int spi_setup(struct spi_device *spi)
 		status = 0;
 
 		spi_set_cs(spi, false, true);
-		pm_runtime_mark_last_busy(spi->controller->dev.parent);
 		pm_runtime_put_autosuspend(spi->controller->dev.parent);
 	} else {
 		spi_set_cs(spi, false, true);
-- 
2.39.5


