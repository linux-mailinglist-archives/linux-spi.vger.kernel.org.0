Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48F382E32
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhEQOE6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:04:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:56630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237715AbhEQOEx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:53 -0400
IronPort-SDR: ZuKx1o0TUMvoKvXxIifibWEkytxgBh3SjYjTipbG2U+WCrKHZB8ay+VtkE7yJXSUbjlMU5Sqjf
 kHLr0iwvmvGA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="187592705"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="187592705"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:36 -0700
IronPort-SDR: M/lgSDZBPlt9P7KzUBCLBSXDjxWPHmW/lCkEkWNS5qxpilAxPDDQCO9mu0yU059ZRaBq5VODyB
 FBYFQRp+yehw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="394458581"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2021 07:03:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0C4D712F; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 1/9] spi: pxa2xx: Propagate firmware node to the child SPI controller device
Date:   Mon, 17 May 2021 17:03:43 +0300
Message-Id: <20210517140351.901-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI core may utilize properties and resources provided by the parent device.
Propagate firmware node to the child SPI controller device for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5985b39e2dd6..38eef9033468 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1718,7 +1718,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
 
-	controller->dev.of_node = pdev->dev.of_node;
+	controller->dev.of_node = dev->of_node;
+	controller->dev.fwnode = dev->fwnode;
+
 	/* the spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 
-- 
2.30.2

