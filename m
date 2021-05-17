Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED11382E3D
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhEQOFF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:05:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:59405 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237707AbhEQOE4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:56 -0400
IronPort-SDR: XXT3qMGmY7si0xkGQ8oEifPXoTz4vIJVaZCNSJwvfBVGuUylBW7rK24ZgRchnP2cJnX5fp2vn8
 EQK/lbrGBlxA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197388020"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="197388020"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:38 -0700
IronPort-SDR: CGZ0qWXXvS64IY6roUax5GmpF3bx0OMfsIh9eaIUYXObbOZwS+pLSyZMzSnj5BuhcwwEbNvg0W
 9u6LRpMIng9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="629996789"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 May 2021 07:03:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51970804; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 6/9] spi: pxa2xx: Fix printf() specifiers
Date:   Mon, 17 May 2021 17:03:48 +0300
Message-Id: <20210517140351.901-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Instead of explicit casting use proper specifier in one case,
and fix specifier signness in another.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f24851b3c020..f8264771b360 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -983,8 +983,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 
 		/* warn ... we force this to PIO mode */
 		dev_warn_ratelimited(&spi->dev,
-				     "DMA disabled for transfer length %ld greater than %d\n",
-				     (long)transfer->len, MAX_DMA_LEN);
+				     "DMA disabled for transfer length %u greater than %d\n",
+				     transfer->len, MAX_DMA_LEN);
 	}
 
 	/* Setup the transfer state based on the type of transfer */
@@ -1115,8 +1115,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 
 		if (tx_level) {
 			/* On MMP2, flipping SSE doesn't to empty TXFIFO. */
-			dev_warn(&spi->dev, "%d bytes of garbage in TXFIFO!\n",
-								tx_level);
+			dev_warn(&spi->dev, "%u bytes of garbage in Tx FIFO!\n", tx_level);
 			if (tx_level > transfer->len)
 				tx_level = transfer->len;
 			drv_data->tx += tx_level;
-- 
2.30.2

