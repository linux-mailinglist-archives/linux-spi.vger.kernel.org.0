Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4D179B75
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbgCDWCF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39337 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbgCDWCE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so4445263wrn.6;
        Wed, 04 Mar 2020 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xfCmZZGWdAB18EV+HiQNuzu6AWSdRAq3sYA6QBfmn3E=;
        b=QHiaPdtsX+y/kEtYgLixbatRagaO0m0P10Z/1bdpoPEj5B0oNkuF7Q8CuPtX+o0Tg+
         qFPwdzO7IaAjQ7uSpdidPJimOZ625RwMxX7WBta9i5Po/YOgM+xZafcJHPsjPV8PNUUG
         a3jpOEPYEmLa29ZH3dG4SgfT9B8pI+9u5O93HkCpXzhvGsCTl6RYGHQ9+K/uYPRjFWWk
         43q6ja0UFNVJhnTcxAYPtdL88/BdM1Kmpkm97Vs4pXTUTXGSlsaTNHF0IYfUelf6KvIV
         NkuX5dzdibCPd771wEY0zFyEA2wWfG9D6p1OfxDjTXzV8PHdYA8IrX74HpwIVuSfCv53
         JAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xfCmZZGWdAB18EV+HiQNuzu6AWSdRAq3sYA6QBfmn3E=;
        b=LmOEOqJq9y77ePbwTfzotkf/DyHUp4hDk5DE6KfUqmvwMFFlxxFo3fnLLA1X4l8xtX
         PMozYt42pm1rckIJ6QiNtDy8dgIq/SLXcUqG7rHK/TQbsV7MK8z087dGIo5cFUlEU4lr
         ABYRZUPUSlZgMlSvGpZGYg7L0MXpsDjPkua8SjofcNVAVrp3LtvtolH5MZNGMwc9fizc
         ZVU4oAEik87E5vZ1y2rWtyDYzjKbkQK2h4NPwXnrOzfWpY6M/2M4VBm7bFfJCSEBsggF
         uVL+6IoCBJHFoeJvkjjDrq9V2ZSqnCODu7wNp1pPweIDplg5CLHz4YtVWlJ61XqljWc+
         Y9zQ==
X-Gm-Message-State: ANhLgQ0PJFkA1AOjvndL232+89FaXkIMr3IzAswsj2VQQiloOWLpjF7M
        tL7QYgfEdimH9mIlBJuTpYE=
X-Google-Smtp-Source: ADFU+vvwX8MKXSjG6S/QDFTJ12SY3coIxwrF5XciysvLRS4IA4+Bru2auK//T4CG/Aj5/6vcs33VEw==
X-Received: by 2002:adf:a285:: with SMTP id s5mr6401530wra.118.1583359322372;
        Wed, 04 Mar 2020 14:02:02 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:02:01 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times as necessary
Date:   Thu,  5 Mar 2020 00:00:39 +0200
Message-Id: <20200304220044.11193-8-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

When dealing with a SPI controller driver that is sending more than 1
byte at once (or the entire buffer at once), and the SPI peripheral
driver has requested timestamping for a byte in the middle of the
buffer, we find that spi_take_timestamp_pre never records a "pre"
timestamp.

This happens because the function currently expects to be called with
the "progress" argument >= to what the peripheral has requested to be
timestamped. But clearly there are cases when that isn't going to fly.

And since we can't change the past when we realize that the opportunity
to take a "pre" timestamp has just passed and there isn't going to be
another one, the approach taken is to keep recording the "pre" timestamp
on each call, overwriting the previously recorded one until the "post"
timestamp is also taken.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi.c       | 19 +++++++------------
 include/linux/spi/spi.h |  3 +--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a8495fd3bb47..22baf204a09d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1515,17 +1515,15 @@ void spi_take_timestamp_pre(struct spi_controller *ctlr,
 	if (!xfer->ptp_sts)
 		return;
 
-	if (xfer->timestamped_pre)
+	if (xfer->timestamped)
 		return;
 
-	if (progress < xfer->ptp_sts_word_pre)
+	if (progress > xfer->ptp_sts_word_pre)
 		return;
 
 	/* Capture the resolution of the timestamp */
 	xfer->ptp_sts_word_pre = progress;
 
-	xfer->timestamped_pre = true;
-
 	if (irqs_off) {
 		local_irq_save(ctlr->irq_flags);
 		preempt_disable();
@@ -1554,7 +1552,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 	if (!xfer->ptp_sts)
 		return;
 
-	if (xfer->timestamped_post)
+	if (xfer->timestamped)
 		return;
 
 	if (progress < xfer->ptp_sts_word_post)
@@ -1570,7 +1568,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 	/* Capture the resolution of the timestamp */
 	xfer->ptp_sts_word_post = progress;
 
-	xfer->timestamped_post = true;
+	xfer->timestamped = true;
 }
 EXPORT_SYMBOL_GPL(spi_take_timestamp_post);
 
@@ -1675,12 +1673,9 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 		}
 	}
 
-	if (unlikely(ctlr->ptp_sts_supported)) {
-		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
-			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_pre);
-			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_post);
-		}
-	}
+	if (unlikely(ctlr->ptp_sts_supported))
+		list_for_each_entry(xfer, &mesg->transfers, transfer_list)
+			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped);
 
 	spi_unmap_msg(ctlr, mesg);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 600e3793303e..87105272879b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -933,8 +933,7 @@ struct spi_transfer {
 
 	struct ptp_system_timestamp *ptp_sts;
 
-	bool		timestamped_pre;
-	bool		timestamped_post;
+	bool		timestamped;
 
 	struct list_head transfer_list;
 };
-- 
2.17.1

