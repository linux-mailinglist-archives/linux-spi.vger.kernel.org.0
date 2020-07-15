Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C46221271
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgGOQgX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 12:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgGOQgX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 12:36:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D5520658;
        Wed, 15 Jul 2020 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594830983;
        bh=vjax7ahxGdBn5nIvkGKgpkksllV5Z+xmIO6XyITIsos=;
        h=From:To:Cc:Subject:Date:From;
        b=2LossVdHtiGoxo44PEjzW81MKEHkkAfmO6bZK8okq5KqUvNOhZEQOw+JkbK5Jj/km
         CKpL/iRcFhMQjXJgX358Th/yRRmkE0YKqsgwNcFJuveCIsnAQ6G160Luw9lt8fivLO
         V54APDx5VYGlO6jS4UUBNnIxF/YJeWfpJmO54gIs=
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: Only defer to thread for cleanup when needed
Date:   Wed, 15 Jul 2020 17:36:10 +0100
Message-Id: <20200715163610.9475-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently we always defer idling of controllers to the SPI thread, the goal
being to ensure that we're doing teardown that's not suitable for atomic
context in an appropriate context and to try to batch up more expensive
teardown operations when the system is under higher load, allowing more
work to be started before the SPI thread is scheduled. However when the
controller does not require any substantial work to idle there is no need
to do this, we can instead save the context switch and immediately mark
the controller as idle. This is particularly useful for systems where there
is frequent but not constant activity.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 19a03a8d6199..6626587e77b4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1336,6 +1336,14 @@ void spi_finalize_current_transfer(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
 
+static void spi_idle_runtime_pm(struct spi_controller *ctlr)
+{
+	if (ctlr->auto_runtime_pm) {
+		pm_runtime_mark_last_busy(ctlr->dev.parent);
+		pm_runtime_put_autosuspend(ctlr->dev.parent);
+	}
+}
+
 /**
  * __spi_pump_messages - function which processes spi message queue
  * @ctlr: controller to process queue for
@@ -1380,10 +1388,17 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			return;
 		}
 
-		/* Only do teardown in the thread */
+		/* Defer any non-atomic teardown to the thread */
 		if (!in_kthread) {
-			kthread_queue_work(ctlr->kworker,
-					   &ctlr->pump_messages);
+			if (!ctlr->dummy_rx && !ctlr->dummy_tx &&
+			    !ctlr->unprepare_transfer_hardware) {
+				spi_idle_runtime_pm(ctlr);
+				ctlr->busy = false;
+				trace_spi_controller_idle(ctlr);
+			} else {
+				kthread_queue_work(ctlr->kworker,
+						   &ctlr->pump_messages);
+			}
 			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 			return;
 		}
@@ -1400,10 +1415,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		    ctlr->unprepare_transfer_hardware(ctlr))
 			dev_err(&ctlr->dev,
 				"failed to unprepare transfer hardware\n");
-		if (ctlr->auto_runtime_pm) {
-			pm_runtime_mark_last_busy(ctlr->dev.parent);
-			pm_runtime_put_autosuspend(ctlr->dev.parent);
-		}
+		spi_idle_runtime_pm(ctlr);
 		trace_spi_controller_idle(ctlr);
 
 		spin_lock_irqsave(&ctlr->queue_lock, flags);
-- 
2.20.1

