Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581143A0DA1
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhFIHVk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 03:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237250AbhFIHVj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Jun 2021 03:21:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AA3561361;
        Wed,  9 Jun 2021 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623223169;
        bh=I55EZUDspXTzWZV8NDrfytGqVmsJsokg7NgjMjvlhfg=;
        h=From:To:Cc:Subject:Date:From;
        b=VWaCjlSvB8JIK6eTl5gbNGWb8maZ7qpPj6m8AT+AIf49hnaITX68OUSKCFSwyhZTm
         b+RvPTWRrj+Ch8Io0mriXukncJfAgudgJzlULfS9bqvdCF/TYRui7uh5KX8D8iPqhB
         YmCUT0LxKp1IXGICcS/AIYsmCwWpoXwbRkzrNK7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] spi: remove spi_set_cs_timing()
Date:   Wed,  9 Jun 2021 09:19:18 +0200
Message-Id: <20210609071918.2852069-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; h=from:subject; bh=I55EZUDspXTzWZV8NDrfytGqVmsJsokg7NgjMjvlhfg=; b=owGbwMvMwCRo6H6F97bub03G02pJDAkHsvPve5YGlKj6/jrF8rg1yObo1rMMa/a6qtqzG7AmaO00 b37WEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABN5wcowP6Ipd9O/cM/d71SbN2ks01 K7fuZ4OsNcIfE0XtYvX75e3id+//o2gT6r+jlzAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

No one seems to be using this global and exported function, so remove it
as it is no longer needed.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi.c       | 73 -----------------------------------------
 include/linux/spi/spi.h |  5 ---
 2 files changed, 78 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e353b7a9e54e..86965c1d7ad0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3453,79 +3453,6 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
-/**
- * spi_set_cs_timing - configure CS setup, hold, and inactive delays
- * @spi: the device that requires specific CS timing configuration
- * @setup: CS setup time specified via @spi_delay
- * @hold: CS hold time specified via @spi_delay
- * @inactive: CS inactive delay between transfers specified via @spi_delay
- *
- * Return: zero on success, else a negative error code.
- */
-int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
-		      struct spi_delay *hold, struct spi_delay *inactive)
-{
-	struct device *parent = spi->controller->dev.parent;
-	size_t len;
-	int status;
-
-	if (spi->controller->set_cs_timing &&
-	    !(spi->cs_gpiod || gpio_is_valid(spi->cs_gpio))) {
-		mutex_lock(&spi->controller->io_mutex);
-
-		if (spi->controller->auto_runtime_pm) {
-			status = pm_runtime_get_sync(parent);
-			if (status < 0) {
-				mutex_unlock(&spi->controller->io_mutex);
-				pm_runtime_put_noidle(parent);
-				dev_err(&spi->controller->dev, "Failed to power device: %d\n",
-					status);
-				return status;
-			}
-
-			status = spi->controller->set_cs_timing(spi, setup,
-								hold, inactive);
-			pm_runtime_mark_last_busy(parent);
-			pm_runtime_put_autosuspend(parent);
-		} else {
-			status = spi->controller->set_cs_timing(spi, setup, hold,
-							      inactive);
-		}
-
-		mutex_unlock(&spi->controller->io_mutex);
-		return status;
-	}
-
-	if ((setup && setup->unit == SPI_DELAY_UNIT_SCK) ||
-	    (hold && hold->unit == SPI_DELAY_UNIT_SCK) ||
-	    (inactive && inactive->unit == SPI_DELAY_UNIT_SCK)) {
-		dev_err(&spi->dev,
-			"Clock-cycle delays for CS not supported in SW mode\n");
-		return -ENOTSUPP;
-	}
-
-	len = sizeof(struct spi_delay);
-
-	/* copy delays to controller */
-	if (setup)
-		memcpy(&spi->controller->cs_setup, setup, len);
-	else
-		memset(&spi->controller->cs_setup, 0, len);
-
-	if (hold)
-		memcpy(&spi->controller->cs_hold, hold, len);
-	else
-		memset(&spi->controller->cs_hold, 0, len);
-
-	if (inactive)
-		memcpy(&spi->controller->cs_inactive, inactive, len);
-	else
-		memset(&spi->controller->cs_inactive, 0, len);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(spi_set_cs_timing);
-
 static int _spi_xfer_word_delay_update(struct spi_transfer *xfer,
 				       struct spi_device *spi)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 74239d65c7fd..f924160e995f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1108,11 +1108,6 @@ static inline void spi_message_free(struct spi_message *m)
 	kfree(m);
 }
 
-extern int spi_set_cs_timing(struct spi_device *spi,
-			     struct spi_delay *setup,
-			     struct spi_delay *hold,
-			     struct spi_delay *inactive);
-
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_async_locked(struct spi_device *spi,
-- 
2.32.0

