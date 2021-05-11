Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4115F37A92F
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhEKO2C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:28:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:45418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhEKO2C (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:28:02 -0400
IronPort-SDR: KhwzS/mibEInt2s73w8E0tOV/kTccCAm4h+1+I7azPDPF7uMjbSu5HZuFJ1966VMgUneMGZe6K
 mJy8Lw365dig==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="197474042"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="197474042"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:26:55 -0700
IronPort-SDR: VtRMk9mb/eLdHUBpstMBpeTTdy6MWP3kHaZZM10wqx52X4yB4fdQYKAP3dXyReOzKpidIzsYJa
 8OZVrXI8XJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609507425"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2021 07:26:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9A08338; Tue, 11 May 2021 17:27:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v4 2/8] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
Date:   Tue, 11 May 2021 17:27:05 +0300
Message-Id: <20210511142711.23244-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511142711.23244-1-andriy.shevchenko@linux.intel.com>
References: <20210511142711.23244-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It appears that pxa2xx_spi_slave_abort()almost  repeats the functionality
of the int_error_stop(). Reuse int_error_stop() in pxa2xx_spi_slave_abort().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5572eec68381..087c84e605b9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -631,7 +631,7 @@ static void int_stop_and_reset(struct driver_data *drv_data)
 	pxa2xx_spi_write(drv_data, SSTO, 0);
 }
 
-static void int_error_stop(struct driver_data *drv_data, const char *msg)
+static void int_error_stop(struct driver_data *drv_data, const char *msg, int err)
 {
 	int_stop_and_reset(drv_data);
 	pxa2xx_spi_flush(drv_data);
@@ -639,7 +639,7 @@ static void int_error_stop(struct driver_data *drv_data, const char *msg)
 
 	dev_err(drv_data->ssp->dev, "%s\n", msg);
 
-	drv_data->controller->cur_msg->status = -EIO;
+	drv_data->controller->cur_msg->status = err;
 	spi_finalize_current_transfer(drv_data->controller);
 }
 
@@ -658,12 +658,12 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	u32 irq_status = pxa2xx_spi_read(drv_data, SSSR) & irq_mask;
 
 	if (irq_status & SSSR_ROR) {
-		int_error_stop(drv_data, "interrupt_transfer: fifo overrun");
+		int_error_stop(drv_data, "interrupt_transfer: fifo overrun", -EIO);
 		return IRQ_HANDLED;
 	}
 
 	if (irq_status & SSSR_TUR) {
-		int_error_stop(drv_data, "interrupt_transfer: fifo underrun");
+		int_error_stop(drv_data, "interrupt_transfer: fifo underrun", -EIO);
 		return IRQ_HANDLED;
 	}
 
@@ -1154,14 +1154,7 @@ static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	int_stop_and_reset(drv_data);
-	pxa2xx_spi_flush(drv_data);
-	pxa2xx_spi_off(drv_data);
-
-	dev_dbg(drv_data->ssp->dev, "transfer aborted\n");
-
-	drv_data->controller->cur_msg->status = -EINTR;
-	spi_finalize_current_transfer(drv_data->controller);
+	int_error_stop(drv_data, "transfer aborted", -EINTR);
 
 	return 0;
 }
-- 
2.30.2

