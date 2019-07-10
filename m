Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E540645DF
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGJLme (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jul 2019 07:42:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:47113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJLme (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jul 2019 07:42:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 04:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="166050211"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2019 04:42:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B0F5112C; Wed, 10 Jul 2019 14:42:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: dw-mmio: Use devm_platform_ioremap_resource()
Date:   Wed, 10 Jul 2019 14:42:30 +0300
Message-Id: <20190710114230.30047-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 18c06568805e..1c1cac92a9de 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -138,7 +138,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 			 struct dw_spi_mmio *dwsmmio);
 	struct dw_spi_mmio *dwsmmio;
 	struct dw_spi *dws;
-	struct resource *mem;
 	int ret;
 	int num_cs;
 
@@ -150,8 +149,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	dws = &dwsmmio->dws;
 
 	/* Get basic io resource and map it */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dws->regs = devm_ioremap_resource(&pdev->dev, mem);
+	dws->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dws->regs)) {
 		dev_err(&pdev->dev, "SPI region map failed\n");
 		return PTR_ERR(dws->regs);
-- 
2.20.1

