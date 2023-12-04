Return-Path: <linux-spi+bounces-141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32A8803BBB
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E061C20AD2
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAD22E82B;
	Mon,  4 Dec 2023 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O1qGjQQc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A79A1
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:21 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58cecfb4412so3228568eaf.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711321; x=1702316121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1aIuy5SeTUs79mZ/Wgm37bPfpq27TGELbh2YCbKj2w=;
        b=O1qGjQQck8KBKxrN+E+zcvz1ey3tVvMplHwzsPj/sAaJ5e9Jlwjk29KqZXVOwrKb86
         kpCyhXxANfZxfXq5fAVe3M+t+dYGISKCqNmicmeV+qP3W1tmy+gc38NYLh1BmSpCcrhc
         Vb23jW7qlq4K7HkQHy5/KN95UZaZYj4BRigdXLhbpjs4feCjQY+ZSCFbRPO4ZZ/NBMj5
         2omL9KaxxEEWxAh8xgdTtM8E3U9rRowfIcE9n5GwEKslzu3s1GEAV3fzOdDJ3DdKOXAq
         EO3wignavy4RQ7VjCVxMtaIdvrvxCgeWVdHr35zpBDm94h8p+jSo2CUwZP/qeXpx7/zf
         PaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711321; x=1702316121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1aIuy5SeTUs79mZ/Wgm37bPfpq27TGELbh2YCbKj2w=;
        b=FQTZFyFnzR/wF2xhm2+lfvVAuZ+8Vhn7zNFWE6Ah8X/VSraFijCrzg04dZaWc1Dqnh
         bCIvPyCYy4W6iEaGp23uRfFVxbdDvq03dLw+Is/IIDmO9h2jOXTXQho7t3MVj5SoOqNA
         srEeCfK5/yC6+l5gAbWnl7KRAcVu2PRJYmU9QnWHQbKz3vIlsyCFwqRNCoVIrdI6fuL9
         XXF3HVC8HqpgF+HPbEneoef92i7PWxwfpPFgxen7fOOXZGr6AjEaapQR1UDbvWU/NABQ
         NpThpXjgRr4SJPqaoorBKk8s+CFNMBWUqcCkE0nzDitsQPeYBptowGigsUyeYwnsB8UP
         /7/Q==
X-Gm-Message-State: AOJu0Yx55GEPVfysNuV4SERjDiDbo5eagLiX2FhJody/UQU0gY/B/3UH
	h/DAt/0kyHwZJcBQX2+jBU96vt7s/HI5b/kyPzs=
X-Google-Smtp-Source: AGHT+IHXDcDPc2B0XlNkOLtuhxBFl/ugWTs/NVcBkSAXUlvE/EH+riGhVdxMKsBfxh4ipH0a9WeQ7A==
X-Received: by 2002:a4a:a74d:0:b0:58e:1c48:1edc with SMTP id h13-20020a4aa74d000000b0058e1c481edcmr3597527oom.14.1701711320804;
        Mon, 04 Dec 2023 09:35:20 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:20 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 9/9] spi: axi-spi-engine: add watchdog timer
Date: Mon,  4 Dec 2023 11:33:35 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-9-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

If there is an issue with the AXI SPI Engine hardware a scheduled
transfer might never be completed and spi_sync() will block forever.
This due to the uninterruptible wait for completion waiting for the
spi_finalize_current_message() that never comes.

Add a watchdog timer that will abort a transfer 5 seconds after it has
been started. This will potentially leave the hardware in a broken state
but it allows software to recover and allow to better diagnose the
underlying issue.

Co-developed-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 78221715ba81..58280dd1c901 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/timer.h>
 
 #define SPI_ENGINE_VERSION_MAJOR(x)	((x >> 16) & 0xff)
 #define SPI_ENGINE_VERSION_MINOR(x)	((x >> 8) & 0xff)
@@ -114,6 +115,8 @@ struct spi_engine {
 
 	void __iomem *base;
 	struct ida sync_ida;
+	struct timer_list watchdog_timer;
+	struct spi_controller *controller;
 
 	unsigned int int_enable;
 };
@@ -488,9 +491,11 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 		struct spi_engine_message_state *st = msg->state;
 
 		if (completed_id == st->sync_id) {
-			msg->status = 0;
-			msg->actual_length = msg->frame_length;
-			spi_finalize_current_message(host);
+			if (timer_delete_sync(&spi_engine->watchdog_timer)) {
+				msg->status = 0;
+				msg->actual_length = msg->frame_length;
+				spi_finalize_current_message(host);
+			}
 			disable_int |= SPI_ENGINE_INT_SYNC;
 		}
 	}
@@ -573,6 +578,8 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	unsigned int int_enable = 0;
 	unsigned long flags;
 
+	mod_timer(&spi_engine->watchdog_timer, jiffies + msecs_to_jiffies(5000));
+
 	spin_lock_irqsave(&spi_engine->lock, flags);
 
 	if (spi_engine_write_cmd_fifo(spi_engine, msg))
@@ -596,6 +603,20 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	return 0;
 }
 
+static void spi_engine_timeout(struct timer_list *timer)
+{
+	struct spi_engine *spi_engine = from_timer(spi_engine, timer, watchdog_timer);
+	struct spi_controller *host = spi_engine->controller;
+
+	if (WARN_ON(!host->cur_msg))
+		return;
+
+	dev_err(&host->dev,
+		"Timeout occurred while waiting for transfer to complete. Hardware is probably broken.\n");
+	host->cur_msg->status = -ETIMEDOUT;
+	spi_finalize_current_message(host);
+}
+
 static void spi_engine_release_hw(void *p)
 {
 	struct spi_engine *spi_engine = p;
@@ -625,6 +646,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spi_engine->lock);
 	ida_init(&spi_engine->sync_ida);
+	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout, TIMER_IRQSAFE);
+	spi_engine->controller = host;
 
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))

-- 
2.43.0


