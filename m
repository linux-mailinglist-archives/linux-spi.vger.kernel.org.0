Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE0E1CF45
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfENSkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 14:40:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfENSkJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 14:40:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so7876pgb.3
        for <linux-spi@vger.kernel.org>; Tue, 14 May 2019 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCp66aV1gNxi33sE4L4kBrPzrebCfikC/mxwtWxT3pw=;
        b=Pg0FWMZIqRZLdiikvIImkxfeP3LRkBxXx/th6apFqSwURqdn63h23semFgSQmGJy6F
         lwDY5vXvHCiZV70qr4Z+Y4+b86bZf3VwvRVteFfJzUMjjLVFsEnyoqvNDPWMalvLGQ6i
         Os6I56KrF9GgyES0oR9JXF3o8a9b/ASyBEqzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCp66aV1gNxi33sE4L4kBrPzrebCfikC/mxwtWxT3pw=;
        b=BcMNBmakz+J0CzXqg9iIujVKQJh77SfJ9di/XoZX8uTfgh6GdL3k9hAricrG1vB+Xk
         dI92KQa/BE8vy9kAWlBUEIr0cLPT20NgtqFqEFFq8RNzH+qtH3Bq8YscwV6ULdF2D2Pp
         hLlbF+d423twau6OJI14wT+rmMj16/HDFqhZBpyOr6p7tnmIPzv0CHLmzofaKyVRM0Ha
         cET4caxx7zhO6EG0V2GjX6VIzpudPOl2oIGakza6+jYpLCAL15rvu0/jc07dmUazf9SC
         qlZ2mg5GG1P/7l9NLBs2jysl9zR09sxpMKVcyQzPYd3w8S7pXUATuDmL/rlWOrne+md1
         QQ1g==
X-Gm-Message-State: APjAAAUS+bVQY84f6SjycbbvFXItrvllVbGIAuMydxH8omI3RvKqCyMd
        3WwbWPTQzj6cEfa4F/FJCmhNMQ==
X-Google-Smtp-Source: APXvYqwKFFk8VbfvQdWZ//TMaT0qP/i15b1ykYA7pmCwvZ+MflxIyOjEaHAbRIib6vZAH8JiTkSiyA==
X-Received: by 2002:a63:a449:: with SMTP id c9mr3561397pgp.149.1557859208387;
        Tue, 14 May 2019 11:40:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 19sm19182454pgz.24.2019.05.14.11.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:40:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 2/3] spi: Allow SPI devices to request the pumping thread be realtime
Date:   Tue, 14 May 2019 11:39:34 -0700
Message-Id: <20190514183935.143463-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190514183935.143463-1-dianders@chromium.org>
References: <20190514183935.143463-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Right now the only way to get the SPI pumping thread bumped up to
realtime priority is for the controller to request it.  However it may
be that the controller works fine with the normal priority but
communication to a particular SPI device on the bus needs realtime
priority.

Let's add a way for devices to request realtime priority when they set
themselves up.

NOTE: this will just affect the priority of transfers that end up on
the SPI core's pumping thread.  In many cases transfers happen in the
context of the caller so if you need realtime priority for all
transfers you should ensure the calling context is also realtime
priority.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- SPI core change now like patch v1 patch #2 (with name "rt").

Changes in v2:
- Now only force transfers to the thread for devices that want it.
- Squashed patch #1 and #2 together.
- Renamed variable to "force_rt_transfers".

 drivers/spi/spi.c       | 36 ++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8eb7460dd744..466984796dd9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1364,10 +1364,32 @@ static void spi_pump_messages(struct kthread_work *work)
 	__spi_pump_messages(ctlr, true);
 }
 
-static int spi_init_queue(struct spi_controller *ctlr)
+/**
+ * spi_set_thread_rt - set the controller to pump at realtime priority
+ * @ctlr: controller to boost priority of
+ *
+ * This can be called because the controller requested realtime priority
+ * (by setting the ->rt value before calling spi_register_controller()) or
+ * because a device on the bus said that its transfers needed realtime
+ * priority.
+ *
+ * NOTE: at the moment if any device on a bus says it needs realtime then
+ * the thread will be at realtime priority for all transfers on that
+ * controller.  If this eventually becomes a problem we may see if we can
+ * find a way to boost the priority only temporarily during relevant
+ * transfers.
+ */
+static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 
+	dev_info(&ctlr->dev,
+		"will run message pump with realtime priority\n");
+	sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
+}
+
+static int spi_init_queue(struct spi_controller *ctlr)
+{
 	ctlr->running = false;
 	ctlr->busy = false;
 
@@ -1387,11 +1409,8 @@ static int spi_init_queue(struct spi_controller *ctlr)
 	 * request and the scheduling of the message pump thread. Without this
 	 * setting the message pump thread will remain at default priority.
 	 */
-	if (ctlr->rt) {
-		dev_info(&ctlr->dev,
-			"will run message pump with realtime priority\n");
-		sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
-	}
+	if (ctlr->rt)
+		spi_set_thread_rt(ctlr);
 
 	return 0;
 }
@@ -2982,6 +3001,11 @@ int spi_setup(struct spi_device *spi)
 
 	spi_set_cs(spi, false);
 
+	if (spi->rt && !spi->controller->rt) {
+		spi->controller->rt = true;
+		spi_set_thread_rt(spi->controller);
+	}
+
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..15505c2485d6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -109,6 +109,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	This may be changed by the device's driver, or left at the
  *	default (0) indicating protocol words are eight bit bytes.
  *	The spi_transfer.bits_per_word can override this for each transfer.
+ * @rt: Make the pump thread real time priority.
  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.
  * @controller_state: Controller's runtime state
@@ -143,6 +144,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
+	bool			rt;
 	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
-- 
2.21.0.1020.gf2820cf01a-goog

