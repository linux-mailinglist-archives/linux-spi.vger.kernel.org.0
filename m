Return-Path: <linux-spi+bounces-5101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA099001E
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A41C1C23AAF
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184C14A0B7;
	Fri,  4 Oct 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a32m0FDO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3E15687D
	for <linux-spi@vger.kernel.org>; Fri,  4 Oct 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034912; cv=none; b=ZwD/+cPLCdaiXsZ/JAVsA3Bafm6nioQMbm5tkTB2RaFyT8JHp1jxVXgpZx5PVvTn8eVD8ye5VUliqHUVlGTHbH/X99vqSsYv0lXNHt7ZuOzAnIXtfP1LB6bdwILfM3BwVHuA3NqA9lkvsxKAntn2jXI+TrnOXuFqTHBSdyyMi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034912; c=relaxed/simple;
	bh=5yVm5F2XoN9+f5KmT/NbezR50s05hxWmbUcDaz+JpTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPmd3HzuisbGdAED7WJr71NoAeTZQdZqNMzVuyijZgrrUrdIJCThDPDusjdPHNxm2ONbMDB9NZkw2pQCWPqkculHjAnmNhuVDIUi8VUsianH8qs6D8tv+cQf5i0DQYoGV0oPGql1Hxftwv1lHXylWAUeACENAT+TQfkBmxHcdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a32m0FDO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034910; x=1759570910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5yVm5F2XoN9+f5KmT/NbezR50s05hxWmbUcDaz+JpTk=;
  b=a32m0FDOymzW13G9cEKhJo1eOwWFPKezltpot44vuUdCNDPn205zb2sp
   89CQdqfaXKm4gfhoNPGUIxogCoKK9O1w9FlgdsV4XOve1qwwMiJFTV/wj
   A47/xgL23tOMOSWDV4exdANckbK4dOdc9ZxrIGCmL3j/sPbk5zkdCMIfP
   CPEt+wHgdhpp1Zj3+tRr+mXkAjwT/WMHBzS8i5lhDNN1TDT0UKKZ+8zHD
   ybHZdwNvMy525+XFsYMnEqUWQUvWaQupicA4h4eeif+Aq4mDH+g2nyxhi
   lysYK5nx2N34ajo4ZKUEgQp1MLKfUzA7HlQCGIdg0H5y2ctibFA8cbyCD
   g==;
X-CSE-ConnectionGUID: d90/A25BSHOyq9rQ8LFgcQ==
X-CSE-MsgGUID: tbv8jLARQmG5wEB57nCOzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27136191"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27136191"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:48 -0700
X-CSE-ConnectionGUID: r7QWhPE+RcKLwyweXMFoWA==
X-CSE-MsgGUID: mOjlKgm3Qwelz8HWQjDKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="105492076"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:47 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E08E01203FA;
	Fri,  4 Oct 2024 12:41:44 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoi-000Tfi-2u;
	Fri, 04 Oct 2024 12:41:44 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Subject: [PATCH 41/51] spi: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:44 +0300
Message-Id: <20241004094144.114048-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/spi/atmel-quadspi.c       | 10 +++++-----
 drivers/spi/spi-cadence-quadspi.c |  4 ++--
 drivers/spi/spi-cadence.c         |  2 +-
 drivers/spi/spi-dw-pci.c          |  2 +-
 drivers/spi/spi-fsl-espi.c        |  4 ++--
 drivers/spi/spi-fsl-lpspi.c       |  4 ++--
 drivers/spi/spi-imx.c             |  6 +++---
 drivers/spi/spi-mtk-nor.c         |  2 +-
 drivers/spi/spi-omap2-mcspi.c     |  6 +++---
 drivers/spi/spi-pxa2xx-pci.c      |  2 +-
 drivers/spi/spi-s3c64xx.c         |  6 +++---
 drivers/spi/spi-sprd.c            |  2 +-
 drivers/spi/spi-stm32-qspi.c      | 14 +++++++-------
 drivers/spi/spi-stm32.c           |  4 ++--
 drivers/spi/spi-ti-qspi.c         |  4 ++--
 drivers/spi/spi-zynqmp-gqspi.c    |  2 +-
 drivers/spi/spi.c                 |  6 +++---
 17 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 91108ddfaef2..0ea46b0f9476 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -459,7 +459,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 pm_runtime_put:
 	pm_runtime_mark_last_busy(&aq->pdev->dev);
-	pm_runtime_put_autosuspend(&aq->pdev->dev);
+	__pm_runtime_put_autosuspend(&aq->pdev->dev);
 	return err;
 }
 
@@ -506,7 +506,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
 	pm_runtime_mark_last_busy(ctrl->dev.parent);
-	pm_runtime_put_autosuspend(ctrl->dev.parent);
+	__pm_runtime_put_autosuspend(ctrl->dev.parent);
 
 	return 0;
 }
@@ -568,7 +568,7 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
 	atmel_qspi_write(aq->mr, aq, QSPI_MR);
 
 	pm_runtime_mark_last_busy(ctrl->dev.parent);
-	pm_runtime_put_autosuspend(ctrl->dev.parent);
+	__pm_runtime_put_autosuspend(ctrl->dev.parent);
 
 	return 0;
 }
@@ -713,7 +713,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 		goto disable_qspick;
 	}
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
@@ -801,7 +801,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 0b45b7b2b3ab..fb8af087bd49 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1443,7 +1443,7 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	ret = cqspi_mem_process(mem, op);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
@@ -1936,7 +1936,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 probe_setup_failed:
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 9e56bde87768..48c4e84c085f 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -663,7 +663,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		ctlr->max_speed_hz = xspi->clk_rate / 4;
 		xspi->speed_hz = ctlr->max_speed_hz;
 		pm_runtime_mark_last_busy(&pdev->dev);
-		pm_runtime_put_autosuspend(&pdev->dev);
+		__pm_runtime_put_autosuspend(&pdev->dev);
 	} else {
 		ctlr->mode_bits |= SPI_NO_CS;
 		ctlr->target_abort = cdns_target_abort;
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 7c8279d13f31..e46353b487f8 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -140,7 +140,7 @@ static int dw_spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *en
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
 
 	return 0;
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6a73eaa34cf7..0aaf6c5028d8 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -514,7 +514,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 	fsl_espi_setup_transfer(spi, NULL);
 
 	pm_runtime_mark_last_busy(espi->dev);
-	pm_runtime_put_autosuspend(espi->dev);
+	__pm_runtime_put_autosuspend(espi->dev);
 
 	return 0;
 }
@@ -727,7 +727,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	dev_info(dev, "irq = %u\n", irq);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 40f5c8fdba76..20d0a22b921d 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -234,7 +234,7 @@ static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller)
 				spi_controller_get_devdata(controller);
 
 	pm_runtime_mark_last_busy(fsl_lpspi->dev);
-	pm_runtime_put_autosuspend(fsl_lpspi->dev);
+	__pm_runtime_put_autosuspend(fsl_lpspi->dev);
 
 	return 0;
 }
@@ -967,7 +967,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_mark_last_busy(fsl_lpspi->dev);
-	pm_runtime_put_autosuspend(fsl_lpspi->dev);
+	__pm_runtime_put_autosuspend(fsl_lpspi->dev);
 
 	return 0;
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index adfd7d74a984..5c2f64c57f78 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1671,7 +1671,7 @@ spi_imx_prepare_message(struct spi_controller *controller, struct spi_message *m
 	ret = spi_imx->devtype_data->prepare_message(spi_imx, msg);
 	if (ret) {
 		pm_runtime_mark_last_busy(spi_imx->dev);
-		pm_runtime_put_autosuspend(spi_imx->dev);
+		__pm_runtime_put_autosuspend(spi_imx->dev);
 	}
 
 	return ret;
@@ -1683,7 +1683,7 @@ spi_imx_unprepare_message(struct spi_controller *controller, struct spi_message
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
 	pm_runtime_mark_last_busy(spi_imx->dev);
-	pm_runtime_put_autosuspend(spi_imx->dev);
+	__pm_runtime_put_autosuspend(spi_imx->dev);
 	return 0;
 }
 
@@ -1856,7 +1856,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_mark_last_busy(spi_imx->dev);
-	pm_runtime_put_autosuspend(spi_imx->dev);
+	__pm_runtime_put_autosuspend(spi_imx->dev);
 
 	return ret;
 
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 85ab5ce96c4d..12a3bba77037 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -919,7 +919,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		goto err_probe;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_info(&pdev->dev, "spi frequency: %d Hz\n", sp->spi_freq);
 
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e2400a067a95..1c52157f926b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -272,7 +272,7 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 		mcspi_write_chconf0(spi, l);
 
 		pm_runtime_mark_last_busy(mcspi->dev);
-		pm_runtime_put_autosuspend(mcspi->dev);
+		__pm_runtime_put_autosuspend(mcspi->dev);
 	}
 }
 
@@ -1102,7 +1102,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		omap2_mcspi_cleanup(spi);
 
 	pm_runtime_mark_last_busy(mcspi->dev);
-	pm_runtime_put_autosuspend(mcspi->dev);
+	__pm_runtime_put_autosuspend(mcspi->dev);
 
 	return ret;
 }
@@ -1374,7 +1374,7 @@ static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 
 	omap2_mcspi_set_mode(ctlr);
 	pm_runtime_mark_last_busy(mcspi->dev);
-	pm_runtime_put_autosuspend(mcspi->dev);
+	__pm_runtime_put_autosuspend(mcspi->dev);
 	return 0;
 }
 
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cc8dcf782399..b06716edc274 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -304,7 +304,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
-	pm_runtime_put_autosuspend(&dev->dev);
+	__pm_runtime_put_autosuspend(&dev->dev);
 	pm_runtime_allow(&dev->dev);
 
 	return 0;
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 389275dbc003..08cf10eaa4ee 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1044,14 +1044,14 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	}
 
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
-	pm_runtime_put_autosuspend(&sdd->pdev->dev);
+	__pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	s3c64xx_spi_set_cs(spi, false);
 
 	return 0;
 
 setup_exit:
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
-	pm_runtime_put_autosuspend(&sdd->pdev->dev);
+	__pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
 	s3c64xx_spi_set_cs(spi, false);
 
@@ -1383,7 +1383,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		mem_res, sdd->fifo_depth);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index ae794058b381..e380981e12f3 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -983,7 +983,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 		goto err_rpm_put;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 540b6948b24d..823da8ec4fd8 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -469,7 +469,7 @@ static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *
 	mutex_unlock(&qspi->lock);
 
 	pm_runtime_mark_last_busy(qspi->dev);
-	pm_runtime_put_autosuspend(qspi->dev);
+	__pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret;
 }
@@ -493,7 +493,7 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	mutex_unlock(&qspi->lock);
 
 	pm_runtime_mark_last_busy(qspi->dev);
-	pm_runtime_put_autosuspend(qspi->dev);
+	__pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret;
 }
@@ -549,7 +549,7 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	mutex_unlock(&qspi->lock);
 
 	pm_runtime_mark_last_busy(qspi->dev);
-	pm_runtime_put_autosuspend(qspi->dev);
+	__pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret ?: len;
 }
@@ -633,7 +633,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 	spi_finalize_current_message(ctrl);
 
 	pm_runtime_mark_last_busy(qspi->dev);
-	pm_runtime_put_autosuspend(qspi->dev);
+	__pm_runtime_put_autosuspend(qspi->dev);
 
 	return ret;
 }
@@ -690,7 +690,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	mutex_unlock(&qspi->lock);
 
 	pm_runtime_mark_last_busy(qspi->dev);
-	pm_runtime_put_autosuspend(qspi->dev);
+	__pm_runtime_put_autosuspend(qspi->dev);
 
 	return 0;
 }
@@ -864,7 +864,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 		goto err_pm_runtime_free;
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
@@ -944,7 +944,7 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index f2dd8ab12df8..6f8549bdd198 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2233,7 +2233,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_info(&pdev->dev, "driver initialized (%s mode)\n",
 		 STM32_SPI_HOST_MODE(spi) ? "host" : "device");
@@ -2342,7 +2342,7 @@ static int __maybe_unused stm32_spi_resume(struct device *dev)
 	spi->cfg->config(spi);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index dfd4a7948c03..5ec4413304db 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -159,7 +159,7 @@ static int ti_qspi_setup(struct spi_device *spi)
 	}
 
 	pm_runtime_mark_last_busy(qspi->dev);
-	ret = pm_runtime_put_autosuspend(qspi->dev);
+	ret = __pm_runtime_put_autosuspend(qspi->dev);
 	if (ret < 0) {
 		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
 		return ret;
@@ -196,7 +196,7 @@ static void ti_qspi_setup_clk(struct ti_qspi *qspi, u32 speed_hz)
 	}
 
 	pm_runtime_mark_last_busy(qspi->dev);
-	pm_runtime_put_autosuspend(qspi->dev);
+	__pm_runtime_put_autosuspend(qspi->dev);
 }
 
 static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 84cce78e4f2e..da771e4153aa 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1345,7 +1345,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 073ffae97767..987e3d582740 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1726,7 +1726,7 @@ static void spi_idle_runtime_pm(struct spi_controller *ctlr)
 {
 	if (ctlr->auto_runtime_pm) {
 		pm_runtime_mark_last_busy(ctlr->dev.parent);
-		pm_runtime_put_autosuspend(ctlr->dev.parent);
+		__pm_runtime_put_autosuspend(ctlr->dev.parent);
 	}
 }
 
@@ -3860,7 +3860,7 @@ static int spi_set_cs_timing(struct spi_device *spi)
 
 			status = spi->controller->set_cs_timing(spi);
 			pm_runtime_mark_last_busy(parent);
-			pm_runtime_put_autosuspend(parent);
+			__pm_runtime_put_autosuspend(parent);
 		} else {
 			status = spi->controller->set_cs_timing(spi);
 		}
@@ -3995,7 +3995,7 @@ int spi_setup(struct spi_device *spi)
 
 		spi_set_cs(spi, false, true);
 		pm_runtime_mark_last_busy(spi->controller->dev.parent);
-		pm_runtime_put_autosuspend(spi->controller->dev.parent);
+		__pm_runtime_put_autosuspend(spi->controller->dev.parent);
 	} else {
 		spi_set_cs(spi, false, true);
 	}
-- 
2.39.5


