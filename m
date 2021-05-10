Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC3378F27
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhEJNd4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:33:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:34987 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352113AbhEJNN6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:13:58 -0400
IronPort-SDR: GwiuOdu5HVi32vlQhEkq8BQG5zy4sxi+14mIyb8ckxATMM1fBgNz4nChjzuIGarAwvGzCU3qFB
 GVUUKfjrPWFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="260455814"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="260455814"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:12:29 -0700
IronPort-SDR: SEBoGOsd7HXGOK7sM3x2GPA4qSj8lyD5tn9LcErORMjswRKOZx6rTJNkTWPONTmR8JmYPkViGo
 u8daIbcG3TWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="470793122"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2021 06:12:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A2AA202; Mon, 10 May 2021 16:12:28 +0300 (EEST)
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
Subject: [PATCH v1 6/7] spi: ppc4xx: Use SPI_MODE_X_MASK
Date:   Mon, 10 May 2021 16:12:16 +0300
Message-Id: <20210510131217.49357-6-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-ppc4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index d8ee363fb714..cb6aaad73f63 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -235,7 +235,7 @@ static int spi_ppc4xx_setup(struct spi_device *spi)
 	 */
 	cs->mode = SPI_PPC4XX_MODE_SPE;
 
-	switch (spi->mode & (SPI_CPHA | SPI_CPOL)) {
+	switch (spi->mode & SPI_MODE_X_MASK) {
 	case SPI_MODE_0:
 		cs->mode |= SPI_CLK_MODE0;
 		break;
-- 
2.30.2

