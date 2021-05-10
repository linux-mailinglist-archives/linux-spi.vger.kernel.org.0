Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51D1378F17
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhEJNdU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:33:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:19860 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351984AbhEJNNo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:13:44 -0400
IronPort-SDR: wjq9qYUaWBjy5/cV1Jqha2pF8az1ePAtdfJ5im+3P4mvWTpCTUqIPeo3LtpEeWj65O3QulQEIt
 SLsrTG+myFaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199261271"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199261271"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:12:15 -0700
IronPort-SDR: crr0PTD/wqg0xrIajIR5THwsMYJDeciaOCujFPoUOsxt9UYSNWFPAGgXObKqV02E0UiuaaaKih
 uCtpejFevx/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="436139440"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 May 2021 06:12:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3665B501; Mon, 10 May 2021 16:12:28 +0300 (EEST)
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
Subject: [PATCH v1 7/7] spi: uniphier: Use SPI_MODE_X_MASK
Date:   Mon, 10 May 2021 16:12:17 +0300
Message-Id: <20210510131217.49357-7-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 6a9ef8ee3cc9..8900e51e1a1c 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -142,7 +142,7 @@ static void uniphier_spi_set_mode(struct spi_device *spi)
 	 * FSTRT    start frame timing
 	 *          0: rising edge of clock, 1: falling edge of clock
 	 */
-	switch (spi->mode & (SPI_CPOL | SPI_CPHA)) {
+	switch (spi->mode & SPI_MODE_X_MASK) {
 	case SPI_MODE_0:
 		/* CKPHS=1, CKINIT=0, CKDLY=1, FSTRT=0 */
 		val1 = SSI_CKS_CKPHS | SSI_CKS_CKDLY;
-- 
2.30.2

