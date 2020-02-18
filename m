Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C516275D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgBRNtP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 08:49:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:35526 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgBRNtO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Feb 2020 08:49:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 05:49:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="268760966"
Received: from unknown (HELO srivasta-NUC7i7BNH.iind.intel.com) ([10.223.163.113])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2020 05:49:11 -0800
From:   Shobhit Srivastava <shobhit.srivastava@intel.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     furquan@google.com, rajatja@google.com, evgreen@google.com,
        andriy.shevchenko@linux.intel.com
Subject: [PATCH 1/1] spi: pxa2xx: Enable SSP controller for CS toggle
Date:   Tue, 18 Feb 2020 19:19:06 +0530
Message-Id: <20200218191752.1.I5dcc25df7fd0fda29d57f5127337348e4c447852@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218134906.25458-1-shobhit.srivastava@intel.com>
References: <20200218134906.25458-1-shobhit.srivastava@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In some circumstances on Intel LPSS controllers, toggling the LPSS
CS control register doesn't actually cause the CS line to toggle.
This ruins SPI transactions that either rely on delay_usecs,
or toggle the CS line without sending any data.
This seems to be because the SSP controller is in disabled state.
As per the spec, the controller needs to be enabled for CS change
to take effect.
This issue is not seen in cases where there is data to be
transferred because then the SSCR0 gets enabled via
pxa2xx_configure_sscr0().

Signed-off-by: Shobhit Srivastava <shobhit.srivastava@intel.com>

---

 drivers/spi/spi-pxa2xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4c7a71f0fb3e..414afc72ef44 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -370,7 +370,7 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
 	const struct lpss_config *config;
-	u32 value;
+	u32 value, sscr0;
 
 	config = lpss_get_config(drv_data);
 
@@ -382,7 +382,18 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 		value &= ~LPSS_CS_CONTROL_CS_HIGH;
 	else
 		value |= LPSS_CS_CONTROL_CS_HIGH;
+
+	/* To propagate CS value to output, the controller should
+	 * be enabled. This is needed for devices that just do
+	 * CS assert, wait and CS deassert without sending any data.
+	 */
+	sscr0 = pxa2xx_spi_read(drv_data, SSCR0);
+	pxa2xx_spi_write(drv_data, SSCR0, sscr0 | SSCR0_SSE);
+
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
+
+	/* Restore the original SSCR0 config*/
+	 pxa2xx_spi_write(drv_data, SSCR0, sscr0);
 }
 
 static void cs_assert(struct spi_device *spi)
-- 
2.17.1

