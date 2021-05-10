Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB8378F11
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhEJNdL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:33:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:10488 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351983AbhEJNNo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:13:44 -0400
IronPort-SDR: P8je5+K4gaAsnU1dbEDEBONp3uU885e0ZFlPK0ZhEDoj4gUULLooH4NCXUofHzCr3vre7ESAB0
 y9BD5HhXCaqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199243589"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199243589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:12:11 -0700
IronPort-SDR: 1dK34HlXywKWlK8OUBdgS4JFa5nJQ8xwpk922IMg7i3LR1jhohThkirVKwBBhcIUgx8hCkmyHI
 ZqugYUwZYGAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="391916757"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 May 2021 06:12:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EDA5812A; Mon, 10 May 2021 16:12:27 +0300 (EEST)
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
Subject: [PATCH v1 2/7] spi: spidev: Use SPI_MODE_X_MASK
Date:   Mon, 10 May 2021 16:12:12 +0300
Message-Id: <20210510131217.49357-2-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index f56e0e975a46..24e9469ea35b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -59,7 +59,7 @@ static DECLARE_BITMAP(minors, N_SPI_MINORS);
  *
  * REVISIT should changing those flags be privileged?
  */
-#define SPI_MODE_MASK		(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH \
+#define SPI_MODE_MASK		(SPI_MODE_X_MASK | SPI_CS_HIGH \
 				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP \
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
 				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
-- 
2.30.2

