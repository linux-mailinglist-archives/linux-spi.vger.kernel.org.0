Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4BA645E0
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 13:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfGJLmr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jul 2019 07:42:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:59609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJLmr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jul 2019 07:42:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 04:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="176815154"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2019 04:42:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0735512C; Wed, 10 Jul 2019 14:42:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v1] spi: dw-mmio: Clock should be shut when error occurs
Date:   Wed, 10 Jul 2019 14:42:43 +0300
Message-Id: <20190710114243.30101-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When optional clock requesting fails, the main clock is still up and running,
we should shut it down in such caee.

Fixes: 560ee7e91009 ("spi: dw: Add support for an optional interface clock")
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 1c1cac92a9de..4fa7e7a52ebd 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -170,8 +170,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	/* Optional clock needed to access the registers */
 	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
-	if (IS_ERR(dwsmmio->pclk))
-		return PTR_ERR(dwsmmio->pclk);
+	if (IS_ERR(dwsmmio->pclk)) {
+		ret = PTR_ERR(dwsmmio->pclk);
+		goto out_clk;
+	}
 	ret = clk_prepare_enable(dwsmmio->pclk);
 	if (ret)
 		goto out_clk;
-- 
2.20.1

