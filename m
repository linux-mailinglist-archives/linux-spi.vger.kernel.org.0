Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC433116B
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCHO4M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhCHOzk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 09:55:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E8C06175F
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 06:55:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lr13so20975766ejb.8
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGIsP86uecOdbNP3RzEXdRJwjYXQN4lavob9ylpQnlo=;
        b=ioTX0u8DVjv5rQ6PRejkBUyjoya3UCwI32URVKD5M10y+hrFGA8Q5r0DXSuHIEEDmo
         oPPBRTnH9wDsEupl3mGZoRJ2vh718Y1GnDNeZfqyAZjEo8kIjGm2UzE1wcRvcbJyEbGy
         7O3sc0gtRdzgOq7T8KV4H0JX8OfC3obDIE0OppS9Sl62QfCirdgYHiBLAMyX5jOeEtYW
         Gmq3N54+nU/K5a4nMbWOxxP2e2ZVLsVOpz5qjJ4feOM/L7AOFg1WOQ9qH3rsKdyXkBEz
         BXtkaWNtaGd0j4FAEpjUqe/rkHZpU3GheAopKvl1/Wk2au60O+NFUxs2j2gqjTQc8LH6
         bXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGIsP86uecOdbNP3RzEXdRJwjYXQN4lavob9ylpQnlo=;
        b=KcIco1hiPszHT8K6/V1mBOKUx5nHOv39+arw95ipDlX/pkzIPi/J5ujOGxCHS9w/xy
         v/sVqiKVzd/GkmlWlKVChrfUBM5PQUjE53abmlqNBxZh24zjnfqLRAxrXA1hQS0V97Zy
         oYKg7/CYApYMGFF+HML5zXABIKPw+4eNU1VkXEZeGpS5BRAv8Sd/H57T77NCN8N7bTSi
         NfXp6KBzSaE0XD6j2QA9VBdb9dbLq2N3X54cq6if/LdxNW5IRxX8WfVTb/2wyRU3Nxyw
         e9jeAbwjKA3c4RcJuDkj4WU44/5Bc6oRwS5mg3lK9DkXEVY/y/9qsF+1g48oPmKemHNs
         TuVQ==
X-Gm-Message-State: AOAM533aVhE1834otH9kH+TRJnejzD+tLoG+Od7F7f/LmUMAF46Wb2ME
        YLq1EJOV5HfXgaypvpvuNE9WlHAacvHUAi4W
X-Google-Smtp-Source: ABdhPJztNbtWidlTaFpyoGea7LJcNkwK+Ksb+1J38vdVQrHaHxFzKw412LMQTMbUTaZZaFEz5HcZtA==
X-Received: by 2002:a17:906:6558:: with SMTP id u24mr15604493ejn.185.1615215337950;
        Mon, 08 Mar 2021 06:55:37 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:37 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 09/10] spi: core: remove 'delay_usecs' field from spi_transfer
Date:   Mon,  8 Mar 2021 16:55:01 +0200
Message-Id: <20210308145502.1075689-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'delay' field in the spi_transfer struct is meant to replace the
'delay_usecs' field. However some cleanup was required to remove the
uses of 'delay_usecs'. Now that it's been cleaned up, we can remove it
from the kernel tree.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi.c       |  1 -
 include/linux/spi/spi.h | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe88ccd6..481427780162 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3178,7 +3178,6 @@ struct spi_replaced_transfers *spi_replace_transfers(
 		/* clear cs_change and delay for all but the last */
 		if (i) {
 			xfer->cs_change = false;
-			xfer->delay_usecs = 0;
 			xfer->delay.value = 0;
 		}
 	}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 592897fa4f03..ea1784a43267 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -832,9 +832,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay: delay to be introduced after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
- * @delay_usecs: microseconds to delay after this transfer before
- *	(optionally) changing the chipselect status, then starting
- *	the next transfer or completing this @spi_message.
  * @word_delay: inter word delay to be introduced after each word size
  *	(set by bits_per_word) transmission.
  * @effective_speed_hz: the effective SCK-speed that was used to
@@ -946,7 +943,6 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
-	u16		delay_usecs;
 	struct spi_delay	delay;
 	struct spi_delay	cs_change_delay;
 	struct spi_delay	word_delay;
@@ -1060,14 +1056,6 @@ spi_transfer_del(struct spi_transfer *t)
 static inline int
 spi_transfer_delay_exec(struct spi_transfer *t)
 {
-	struct spi_delay d;
-
-	if (t->delay_usecs) {
-		d.value = t->delay_usecs;
-		d.unit = SPI_DELAY_UNIT_USECS;
-		return spi_delay_exec(&d, NULL);
-	}
-
 	return spi_delay_exec(&t->delay, t);
 }
 
-- 
2.29.2

