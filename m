Return-Path: <linux-spi+bounces-11612-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74639C8BD65
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 21:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB103B1FB7
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215F3126B1;
	Wed, 26 Nov 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvjfJq78"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB4342158;
	Wed, 26 Nov 2025 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188709; cv=none; b=S+A9FxF+dPJXloOrDt5Br++1bHvkS5ZBe61sPk85pDGIry5gKu4YBKtowIQyDYaLcmpODlHs1KfrULd9Jl+DNzvKuMbaz37k0EZiLQgQjYL0xZQ90I1iBTXqL4znyVaDmBZs93Fl/okxsRV1M6t4UqByQ01n7J9pUSmgUX8uYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188709; c=relaxed/simple;
	bh=9d7Oz1hbQEzdVTDKOgIac/ceVdRR1oz2iFLX9Q1uZzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfoo2NicwwCUleH5Sf/AVQs7xYKj8nhgNjXsBGX5+75TA+Rv9b/4Zmwo+05K56eny0Ftij66Sah0PpvvCji2MyXtnEPubKDymoPMG0IVUnZ3IBEvVv52Izi+jC/02RhROershI92wZku1uA+DrRFArMTrzzAT1UbduyqW0F5upA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvjfJq78; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764188707; x=1795724707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9d7Oz1hbQEzdVTDKOgIac/ceVdRR1oz2iFLX9Q1uZzA=;
  b=MvjfJq78SV1q0FGL1MiQM7xS2IpeN5zKBxpG8soUR7g297XgF3SShl0s
   HeMqbJjrYu2WkL5gw2Iew0QIjQ21Kq3myWRVlSseAG4hFiRRP0RpAA1hs
   Em4HtAHL3DWIGc6Gt+rppvabEyzDCa/Qi3YD1NHIGd1IpvG+FnqIKrqU0
   /yZ4cyN/wJxV/KxHcyyliqPBSHB9imHqFLIUhf6f+aPI38YoByHwxAQiX
   6B7WIbcJiiRbV2pS6G1XIsGrgTNTZNrCIX0Hqg16omYPf5ExpeTWXGr2A
   5LpG2wgjJrrBttkE/LM2MqInS7KGlW94pvxLWB/XtgZ/NCgo/dGVpJ50e
   w==;
X-CSE-ConnectionGUID: JmyQYVJvQk6NsBs8fUtEcA==
X-CSE-MsgGUID: vkyQGAYNQSq5HRSnZgtCWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70096996"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="70096996"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 12:25:06 -0800
X-CSE-ConnectionGUID: 6pKi7k5pRaClI3ou6FA7ww==
X-CSE-MsgGUID: hLhB7k7ESsGPRVip5CIWsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="224001183"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2025 12:25:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E998E9F; Wed, 26 Nov 2025 21:25:03 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: nxp-fspi: Propagate fwnode in ACPI case as well
Date: Wed, 26 Nov 2025 21:25:01 +0100
Message-ID: <20251126202501.2319679-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate fwnode of the ACPI device to the SPI controller Linux device.
Currently only OF case propagates fwnode to the controller.

While at it, replace several calls to dev_fwnode() with a single one
cached in a local variable, and unify checks for fwnode type by using
is_*_node() APIs.

Fixes: 55ab8487e01d ("spi: spi-nxp-fspi: Add ACPI support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-nxp-fspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index b6c79e50d842..50a7e4916a60 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1287,7 +1287,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct resource *res;
 	struct nxp_fspi *f;
 	int ret, irq;
@@ -1309,7 +1309,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, f);
 
 	/* find the resources - configuration register address space */
-	if (is_acpi_node(dev_fwnode(f->dev)))
+	if (is_acpi_node(fwnode))
 		f->iobase = devm_platform_ioremap_resource(pdev, 0);
 	else
 		f->iobase = devm_platform_ioremap_resource_byname(pdev, "fspi_base");
@@ -1317,7 +1317,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		return PTR_ERR(f->iobase);
 
 	/* find the resources - controller memory mapped space */
-	if (is_acpi_node(dev_fwnode(f->dev)))
+	if (is_acpi_node(fwnode))
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	else
 		res = platform_get_resource_byname(pdev,
@@ -1330,7 +1330,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	f->memmap_phy_size = resource_size(res);
 
 	/* find the clocks */
-	if (dev_of_node(&pdev->dev)) {
+	if (is_of_node(fwnode)) {
 		f->clk_en = devm_clk_get(dev, "fspi_en");
 		if (IS_ERR(f->clk_en))
 			return PTR_ERR(f->clk_en);
@@ -1383,7 +1383,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	else
 		ctlr->mem_caps = &nxp_fspi_mem_caps;
 
-	ctlr->dev.of_node = np;
+	device_set_node(&ctlr->dev, fwnode);
 
 	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);
 	if (ret)
-- 
2.50.1


