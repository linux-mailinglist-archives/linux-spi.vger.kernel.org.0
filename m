Return-Path: <linux-spi+bounces-10433-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85DBB68CF
	for <lists+linux-spi@lfdr.de>; Fri, 03 Oct 2025 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 306494E2067
	for <lists+linux-spi@lfdr.de>; Fri,  3 Oct 2025 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291CE2EBDC7;
	Fri,  3 Oct 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bLI9SSOC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD11DB13A
	for <linux-spi@vger.kernel.org>; Fri,  3 Oct 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491777; cv=none; b=jwf/mqca5ropB15/SNuQQ4J9m5KLSsqkEAyJIWy6l9rO7Xbsdbei+PYPWNqraGO9QmEoWoZtKZUa9yqRvSzfhIRb3RC48kBcgVA4q67OK/8LYF147DipeMCsi29TadhVMewZiMzoozC4EnMfvmsyQRMjl13wEWPWxPxSJt0RmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491777; c=relaxed/simple;
	bh=0Qmg6uf0BC6NZIuR3bHbPpX6UvepUdyb9wdG+LHu9/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=FVbafnprbfuMPnjkzjul1fV5SJGZ78tvFAM14FY/jTWGlq+UlUCI2acm9U1F6L+nF95rXJme2mLVZjo4JiNgYbWdKvhm4RYuCkgX9Y+U1q/d3RIPS3P37Yx0EaqL5ihYcwE1Gr/Fndz8pVYy/12QIFGDeVsbny6hQfYuSkY29Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bLI9SSOC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251003114251euoutp02ed11bb5cec0ea6644515bba959a41fc2~q_HGjjzZe2807728077euoutp02g
	for <linux-spi@vger.kernel.org>; Fri,  3 Oct 2025 11:42:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251003114251euoutp02ed11bb5cec0ea6644515bba959a41fc2~q_HGjjzZe2807728077euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759491771;
	bh=PSPKO6aO7ye5SMU/Cz/s6DweIfGwewM6svTXvz8YrzQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=bLI9SSOCv2Mtj5k+03vvSn8vDuxWubNoKyJKL0iJpdRpmqUU4v38+LlwBbwK6aDu/
	 UBhvvtRoT+Ez5QTH809oA4fBcf1i2cyPf9veykx3AFYRjoOruQjjecumUSpbT0UihV
	 hTiAE1vEJGQil4WiQa/IMmCVbGA3MvzKI45ZwKus=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251003114250eucas1p1b3729827b9136128dc25c7858a303286~q_HGJtU5f2437524375eucas1p1S;
	Fri,  3 Oct 2025 11:42:50 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251003114250eusmtip1b2ffa410b8912e19c19e4d400834b195~q_HF1MMaT0967009670eusmtip19;
	Fri,  3 Oct 2025 11:42:50 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown
	<broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jon Lin
	<jon.lin@rock-chips.com>
Subject: [PATCH] spi: rockchip-sfc: Fix DMA-API usage
Date: Fri,  3 Oct 2025 13:42:39 +0200
Message-Id: <20251003114239.431114-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251003114250eucas1p1b3729827b9136128dc25c7858a303286
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251003114250eucas1p1b3729827b9136128dc25c7858a303286
X-EPHeader: CA
X-CMS-RootMailID: 20251003114250eucas1p1b3729827b9136128dc25c7858a303286
References: <CGME20251003114250eucas1p1b3729827b9136128dc25c7858a303286@eucas1p1.samsung.com>

Use DMA-API dma_map_single() call for getting the DMA address of the
transfer buffer instead of hacking with virt_to_phys().

This fixes the following DMA-API debug warning:
------------[ cut here ]------------
DMA-API: rockchip-sfc fe300000.spi: device driver tries to sync DMA memory it has not allocated [device address=0x000000000cf70000] [size=288 bytes]
WARNING: kernel/dma/debug.c:1106 at check_sync+0x1d8/0x690, CPU#2: systemd-udevd/151
Modules linked in: ...
Hardware name: Hardkernel ODROID-M1 (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_sync+0x1d8/0x690
lr : check_sync+0x1d8/0x690
..
Call trace:
 check_sync+0x1d8/0x690 (P)
 debug_dma_sync_single_for_cpu+0x84/0x8c
 __dma_sync_single_for_cpu+0x88/0x234
 rockchip_sfc_exec_mem_op+0x4a0/0x798 [spi_rockchip_sfc]
 spi_mem_exec_op+0x408/0x498
 spi_nor_read_data+0x170/0x184
 spi_nor_read_sfdp+0x74/0xe4
 spi_nor_parse_sfdp+0x120/0x11f0
 spi_nor_sfdp_init_params_deprecated+0x3c/0x8c
 spi_nor_scan+0x690/0xf88
 spi_nor_probe+0xe4/0x304
 spi_mem_probe+0x6c/0xa8
 spi_probe+0x94/0xd4
 really_probe+0xbc/0x298
 ...

Fixes: b69386fcbc60 ("spi: rockchip-sfc: Using normal memory for dma")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/spi/spi-rockchip-sfc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 9eba5c0a60f2..b3c2b03b1153 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -704,7 +704,12 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 			ret = -ENOMEM;
 			goto err_dma;
 		}
-		sfc->dma_buffer = virt_to_phys(sfc->buffer);
+		sfc->dma_buffer = dma_map_single(dev, sfc->buffer,
+					    sfc->max_iosize, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev, sfc->dma_buffer)) {
+			ret = -ENOMEM;
+			goto err_dma_map;
+		}
 	}
 
 	ret = devm_spi_register_controller(dev, host);
@@ -715,6 +720,9 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	return 0;
 err_register:
+	dma_unmap_single(dev, sfc->dma_buffer, sfc->max_iosize,
+			 DMA_BIDIRECTIONAL);
+err_dma_map:
 	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
 err_dma:
 	pm_runtime_get_sync(dev);
@@ -736,6 +744,8 @@ static void rockchip_sfc_remove(struct platform_device *pdev)
 	struct spi_controller *host = sfc->host;
 
 	spi_unregister_controller(host);
+	dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
+			 DMA_BIDIRECTIONAL);
 	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
 
 	clk_disable_unprepare(sfc->clk);
-- 
2.34.1


