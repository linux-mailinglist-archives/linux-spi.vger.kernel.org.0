Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3618382E31
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbhEQOE6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:04:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:23534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237730AbhEQOEw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:52 -0400
IronPort-SDR: G4lNUByrBuBn6+VCpXelSmxsiQEoB2woXpkDN/CKIK6KqcG+g8JmmKm412Jpgisc9EOPiY6A/V
 rsK9ShebqnYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200520354"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200520354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:36 -0700
IronPort-SDR: uqTErCmfac3hE9303c3MXXfxF71/YxBIhrWZOG6mRA9O8bttKuHN7LJy6CbtZay4pMf++Ml9RK
 fr3Uj9l5llcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="543710115"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2021 07:03:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2F4C0796; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 4/9] spi: pxa2xx: Drop duplicate chip_select in struct chip_data
Date:   Mon, 17 May 2021 17:03:46 +0300
Message-Id: <20210517140351.901-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The struct chip_data had been introduced in order to keep the parameters
that may be provided on stack during device allocation. There is no need
to duplicate parameters there, which are carried on by SPI device itself.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 +---
 drivers/spi/spi-pxa2xx.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1a0bcd3bac1f..fb80f6013d54 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -432,7 +432,7 @@ static void cs_assert(struct spi_device *spi)
 		spi_controller_get_devdata(spi->controller);
 
 	if (drv_data->ssp_type == CE4100_SSP) {
-		pxa2xx_spi_write(drv_data, SSSR, chip->frm);
+		pxa2xx_spi_write(drv_data, SSSR, spi->chip_select);
 		return;
 	}
 
@@ -1303,8 +1303,6 @@ static int setup(struct spi_device *spi)
 				kfree(chip);
 				return -EINVAL;
 			}
-
-			chip->frm = spi->chip_select;
 		}
 		chip->enable_dma = drv_data->controller_info->enable_dma;
 		chip->timeout = TIMOUT_DFLT;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index a91fe6edb275..db9de46110ad 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -72,7 +72,6 @@ struct chip_data {
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
 
-	unsigned int frm;
 	void (*cs_control)(u32 command);
 };
 
-- 
2.30.2

