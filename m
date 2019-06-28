Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F97759D79
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2019 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF1OHY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jun 2019 10:07:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:12272 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfF1OHY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Jun 2019 10:07:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 07:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="173486306"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.56])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2019 07:07:20 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Set minimum transfer speed
Date:   Fri, 28 Jun 2019 17:07:17 +0300
Message-Id: <20190628140717.7552-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is possible to request a transfer with a speed lower than supported
by the HW. This causes silent divider calculation underflow in
ssp_get_clk_div() which leads to a frequency higher than requested. Up to
maximum speed of the controller.

Set the minimum supported transfer speed and let the SPI core to
validate no transfers have speed lower than supported.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index af3f37ba82c8..259c20f7a542 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1704,6 +1704,16 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		goto out_error_dma_irq_alloc;
 
 	controller->max_speed_hz = clk_get_rate(ssp->clk);
+	/*
+	 * Set minimum speed for all other platforms than Intel Quark which is
+	 * able do under 1 Hz transfers.
+	 */
+	if (!pxa25x_ssp_comp(drv_data))
+		controller->min_speed_hz =
+			DIV_ROUND_UP(controller->max_speed_hz, 4096);
+	else if (!is_quark_x1000_ssp(drv_data))
+		controller->min_speed_hz =
+			DIV_ROUND_UP(controller->max_speed_hz, 512);
 
 	/* Load default SSP configuration */
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
-- 
2.20.1

