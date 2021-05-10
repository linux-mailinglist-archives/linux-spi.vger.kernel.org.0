Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA5378F1D
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhEJNdj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:33:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:19656 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352063AbhEJNNy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:13:54 -0400
IronPort-SDR: kB78eF1+FfDRMsvKcZ8hs63pShJlKc0bGTnK9Ahw7J559hRZ0C3H5VvwBrQMZnscbNKfbXtFbd
 drO9wap2sIug==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199261266"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199261266"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:12:12 -0700
IronPort-SDR: cdfWr8A2AqccBATyGw3BVMyWmpt2JQ+K0F3lVLPuHtOtqNEguqvlmt+ZXmhI3myDhFKSLE2Upf
 HJX+9qMCT0KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="624279386"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2021 06:12:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11E22147; Mon, 10 May 2021 16:12:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] spi: oc-tiny: Use SPI_MODE_X_MASK
Date:   Mon, 10 May 2021 16:12:14 +0300
Message-Id: <20210510131217.49357-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510131217.49357-1-andriy.shevchenko@linux.intel.com>
References: <20210510131217.49357-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use SPI_MODE_X_MASK instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-oc-tiny.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index f3843f0ff260..38c14c4e4e21 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -86,7 +86,7 @@ static int tiny_spi_setup(struct spi_device *spi)
 		hw->speed_hz = spi->max_speed_hz;
 		hw->baud = tiny_spi_baud(spi, hw->speed_hz);
 	}
-	hw->mode = spi->mode & (SPI_CPOL | SPI_CPHA);
+	hw->mode = spi->mode & SPI_MODE_X_MASK;
 	return 0;
 }
 
-- 
2.30.2

