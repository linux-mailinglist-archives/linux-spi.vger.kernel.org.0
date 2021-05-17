Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A74382E3F
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhEQOFH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:05:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:59397 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237653AbhEQOE5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:57 -0400
IronPort-SDR: le9UCQqBnxL8ILeejqmEuSPg2MCGdevuk6gjF0UT3C/0OepT5RsxoE8pjsEOI8mhfUQ50dt/fi
 NQ2WkJ5qR/qA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197388021"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="197388021"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:38 -0700
IronPort-SDR: tYqysj2lWaiT9tzmSChSC/xpL0q8+5OXnRQrIfZdy3ivP5+KrOdgA/bx7IGRe9aDrTSYOA9sp0
 HcUJM+SLVBCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="465860558"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2021 07:03:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3AD747E6; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 5/9] spi: pxa2xx: Drop unneeded '!= 0' comparisons
Date:   Mon, 17 May 2021 17:03:47 +0300
Message-Id: <20210517140351.901-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the few places it's redundant to compare against 0.
Drop the unneeded comparisons.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fb80f6013d54..f24851b3c020 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1380,8 +1380,8 @@ static int setup(struct spi_device *spi)
 	}
 
 	chip->cr1 &= ~(SSCR1_SPO | SSCR1_SPH);
-	chip->cr1 |= (((spi->mode & SPI_CPHA) != 0) ? SSCR1_SPH : 0)
-			| (((spi->mode & SPI_CPOL) != 0) ? SSCR1_SPO : 0);
+	chip->cr1 |= ((spi->mode & SPI_CPHA) ? SSCR1_SPH : 0) |
+		     ((spi->mode & SPI_CPOL) ? SSCR1_SPO : 0);
 
 	if (spi->mode & SPI_LOOP)
 		chip->cr1 |= SSCR1_LBM;
@@ -1859,7 +1859,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
 	status = spi_register_controller(controller);
-	if (status != 0) {
+	if (status) {
 		dev_err(&pdev->dev, "problem registering spi controller\n");
 		goto out_error_pm_runtime_enabled;
 	}
@@ -1918,7 +1918,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	int status;
 
 	status = spi_controller_suspend(drv_data->controller);
-	if (status != 0)
+	if (status)
 		return status;
 
 	pxa_ssp_disable(ssp);
-- 
2.30.2

