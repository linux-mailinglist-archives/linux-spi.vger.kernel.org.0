Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC92A28F6
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 12:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgKBLXp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 06:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBLXp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Nov 2020 06:23:45 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F2C0617A6;
        Mon,  2 Nov 2020 03:23:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x13so10829455pfa.9;
        Mon, 02 Nov 2020 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhmqATifEcViK+e9MGPWvhRFN0kIxrnVQe+ipF7dQNc=;
        b=clmoZITrEvKUnP0B/bc0cWKdoBou4VKg7O2epLQNvKtPbX6OrmNf+03/tlspKl/wKn
         61FHVSNuGDFcHUvPH+ogg6G8eUAOJnM2mX6skODpJMQxYF8ZYWDnfP3eYbhhNadlkM8w
         Bbi5jaOVpLqtHTtJFq4JcKXuAuYTgOpbmx6DSBF43vQxzHcoeqNHmKrJzMzn6Wpcr0VP
         VMWORHbv2UZClNb3ttYgT7lUsWNtO0440LhiSIKH8B+1GDnTxI+br4PyNViI0Ban0FyH
         8xTyNR1ShKXWjDuuuKQLWYmH6d8z/kvPY+s2hFi1SEjxhhEgQ/D94roHcy3RLs9qGE2B
         2Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IhmqATifEcViK+e9MGPWvhRFN0kIxrnVQe+ipF7dQNc=;
        b=Q1c6DiO7oeZRietIlQ86wo9HyBn/0tnKH1T26oYyNtB5YSFzcZm5iEXepTf2gR//J9
         VWhMXdKuoPxuLhT9jd9dyJM6amGhpPNZLqohTDdB+UjgWCLdHlq/oLLhEfvqzE3jSmRX
         sorBSY/6bCyFoC+9+1A1D7It0xzkMlAOcve0RphG/yU8FGFHbQwuUA1fVEkvUfb8vL+Z
         jm1xN5w0F9Agbgk9GDMI00Ebcmw5mGwYGAwO0C7zZSJym7XufZNCiNub0ZcnncEoonCJ
         EISLFcmovuVE3PZG9A4z4FoMhyjyeu5joEC0jCwq6sYbPbgRqxhsI5C8XsgcaOIuC5+6
         LA7A==
X-Gm-Message-State: AOAM531pEFrCaaXlEYYSEPjfb5TYnQIMNp/ulkXzk77JK1X+smLyoonR
        eu/PcvY3faMVttcvZAtuJ5g=
X-Google-Smtp-Source: ABdhPJyvOJYESLJDoZaggrjuIpt4OyL+3gSC7dJWfRhNDgRqL+g41fqjKxmc5BlyM/JABx5GO7hdOA==
X-Received: by 2002:a17:90a:fb90:: with SMTP id cp16mr5693087pjb.232.1604316224427;
        Mon, 02 Nov 2020 03:23:44 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e6sm13727005pfn.190.2020.11.02.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:23:43 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bangzheng Liu <bangzheng.liu@unisoc.com>
Subject: [PATCH] spi: add runtime PM for transfer_one_message
Date:   Mon,  2 Nov 2020 19:22:39 +0800
Message-Id: <20201102112239.19218-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Before transfer message, spi devices probably have been in runtime suspended,
that would cause the kernel crash on some platforms once access spi
registers, such as on Unisoc's SoCs. The spi devices can be suspended
until message transfer completed.

Also this patch move the API spi_idle_runtime_pm() above to
spi_transfer_one_message() which need to call that API.

Fixes: b158935f70b9 ("spi: Provide common spi_message processing loop")
Reported-by: Bangzheng Liu <bangzheng.liu@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..63f7ebea7076 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1224,6 +1224,14 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 	}
 }
 
+static void spi_idle_runtime_pm(struct spi_controller *ctlr)
+{
+	if (ctlr->auto_runtime_pm) {
+		pm_runtime_mark_last_busy(ctlr->dev.parent);
+		pm_runtime_put_autosuspend(ctlr->dev.parent);
+	}
+}
+
 /*
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
@@ -1240,6 +1248,16 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 
+	if (ctlr->auto_runtime_pm) {
+		ret = pm_runtime_get_sync(ctlr->dev.parent);
+		if (ret < 0) {
+			pm_runtime_put_noidle(ctlr->dev.parent);
+			dev_err(&ctlr->dev, "Failed to power device: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	spi_set_cs(msg->spi, true);
 
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
@@ -1329,6 +1347,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 
 	spi_finalize_current_message(ctlr);
 
+	spi_idle_runtime_pm(ctlr);
+
 	return ret;
 }
 
@@ -1346,14 +1366,6 @@ void spi_finalize_current_transfer(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
 
-static void spi_idle_runtime_pm(struct spi_controller *ctlr)
-{
-	if (ctlr->auto_runtime_pm) {
-		pm_runtime_mark_last_busy(ctlr->dev.parent);
-		pm_runtime_put_autosuspend(ctlr->dev.parent);
-	}
-}
-
 /**
  * __spi_pump_messages - function which processes spi message queue
  * @ctlr: controller to process queue for
-- 
2.20.1

