Return-Path: <linux-spi+bounces-6117-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B59F71DE
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 02:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E151F188FD70
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 01:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD664500E;
	Thu, 19 Dec 2024 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ArX75noz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com [220.197.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0CF9CB;
	Thu, 19 Dec 2024 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572496; cv=none; b=FoehFV2odceOodWc5eCeg3znD9hxN3G0oCginq3Kq3d6+NHPxyrRQYyqSadhdVw4e8oVl8ON8neeboGKduOzNY77joxmXtIe/sR1uXApyW8OCbmYoGeIESaCkyIrDvvwx63zKbCGXMC6ZrNSejlYQaStjdyCSYYAAsbbd+DjoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572496; c=relaxed/simple;
	bh=zj46V8+AlT/le+zcLhTXsZiFaoastz+/lmZ3kCeqd/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rdvvCtGnBfnNqN6cCKoP4E7i7VpE5d8Q0EiA6awr7A4IbZyjfm/GHpUkq9bEYcWyW3d48vftAzfovXwyLTMLMfET/UXEFjmYrFNyHVX/3bNjDZ2HXcdINh+67TzuqSS3bEs1B55TaHzEoEUgSPdfxJsQj5j56NYnxvnqjUuaEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ArX75noz; arc=none smtp.client-ip=220.197.32.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 62689e96;
	Thu, 19 Dec 2024 09:05:59 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: rockchip-sfc: Using normal memory for dma
Date: Thu, 19 Dec 2024 09:05:57 +0800
Message-Id: <20241219010557.333327-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08YGVYZHUgdSx0YSB8fTBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93dc733a5309d9kunm62689e96
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6ORw4DzIXDBc#Ijg8CioY
	NyxPCQFVSlVKTEhPTkxLSE1LTkpOVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFIQklPNwY+
DKIM-Signature:a=rsa-sha256;
	b=ArX75nozRt5ddukmT6M0gsKqaaaB8H4Ibjvrsb6mEpLtcJQmI9/pulkmT3xAK4vXcLUZGwOyXq2W9s+s3GaC8SGOaEew7nDDFpR2f+lBL9haHufywCZSDKRVQgiScjVGljNZBTD+aZtTRDV8LH82+Md7PWXN0YV3Syp5lZZ5c+M=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9WLo9P0p6Y1Vr7K+3r8P1YMOWdk5vWT9KA5P3lqs1TQ=;
	h=date:mime-version:subject:message-id:from;

Nornal memory CPU copy with cache invalidate is more efficient
than uncache memory copy.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 47 ++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index ca4f20283d23..36509bcccc27 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -156,10 +156,9 @@
 
 #define SFC_MAX_CHIPSELECT_NUM		2
 
-/* The SFC can transfer max 16KB - 1 at one time
- * we set it to 15.5KB here for alignment.
- */
 #define SFC_MAX_IOSIZE_VER3		(512 * 31)
+/* Although up to 4GB, 64KB is enough with less mem reserved */
+#define SFC_MAX_IOSIZE_VER4		(0x10000U)
 
 /* DMA is only enabled for large data transmission */
 #define SFC_DMA_TRANS_THRETHOLD		(0x40)
@@ -457,8 +456,10 @@ static int rockchip_sfc_xfer_data_dma(struct rockchip_sfc *sfc,
 
 	dev_dbg(sfc->dev, "sfc xfer_dma len=%x\n", len);
 
-	if (op->data.dir == SPI_MEM_DATA_OUT)
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
 		memcpy(sfc->buffer, op->data.buf.out, len);
+		dma_sync_single_for_device(sfc->dev, sfc->dma_buffer, len, DMA_TO_DEVICE);
+	}
 
 	ret = rockchip_sfc_fifo_transfer_dma(sfc, sfc->dma_buffer, len);
 	if (!wait_for_completion_timeout(&sfc->cp, msecs_to_jiffies(2000))) {
@@ -466,8 +467,11 @@ static int rockchip_sfc_xfer_data_dma(struct rockchip_sfc *sfc,
 		ret = -ETIMEDOUT;
 	}
 	rockchip_sfc_irq_mask(sfc, SFC_IMR_DMA);
-	if (op->data.dir == SPI_MEM_DATA_IN)
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dma_sync_single_for_cpu(sfc->dev, sfc->dma_buffer, len, DMA_FROM_DEVICE);
 		memcpy(op->data.buf.in, sfc->buffer, len);
+	}
 
 	return ret;
 }
@@ -633,19 +637,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node, "rockchip,sfc-no-dma");
 
-	if (sfc->use_dma) {
-		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-		if (ret) {
-			dev_warn(dev, "Unable to set dma mask\n");
-			return ret;
-		}
-
-		sfc->buffer = dmam_alloc_coherent(dev, SFC_MAX_IOSIZE_VER3,
-						  &sfc->dma_buffer, GFP_KERNEL);
-		if (!sfc->buffer)
-			return -ENOMEM;
-	}
-
 	ret = clk_prepare_enable(sfc->hclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable ahb clk\n");
@@ -676,8 +667,8 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_irq;
 
-	sfc->max_iosize = rockchip_sfc_get_max_iosize(sfc);
 	sfc->version = rockchip_sfc_get_version(sfc);
+	sfc->max_iosize = rockchip_sfc_get_max_iosize(sfc);
 
 	pm_runtime_set_autosuspend_delay(dev, ROCKCHIP_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(dev);
@@ -685,16 +676,27 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 
+	if (sfc->use_dma) {
+		sfc->buffer = (u8 *)__get_free_pages(GFP_KERNEL | GFP_DMA32,
+						     get_order(sfc->max_iosize));
+		if (!sfc->buffer) {
+			ret = -ENOMEM;
+			goto err_dma;
+		}
+		sfc->dma_buffer = virt_to_phys(sfc->buffer);
+	}
+
 	ret = devm_spi_register_controller(dev, host);
 	if (ret)
-		goto err_pm_runtime_free;
+		goto err_register;
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-
-err_pm_runtime_free:
+err_register:
+	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
+err_dma:
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
@@ -714,6 +716,7 @@ static void rockchip_sfc_remove(struct platform_device *pdev)
 	struct spi_controller *host = sfc->host;
 
 	spi_unregister_controller(host);
+	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
 
 	clk_disable_unprepare(sfc->clk);
 	clk_disable_unprepare(sfc->hclk);
-- 
2.34.1


