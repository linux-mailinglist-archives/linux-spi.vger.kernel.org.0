Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373CF7F5ED
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2019 13:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfHBLWS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Aug 2019 07:22:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392351AbfHBLWP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Aug 2019 07:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/0utpff7Aq7Pr1XYXi2joLJCHy84GZ7jgMJz+VSBcWQ=; b=TSj3c1mTizB8
        zUuJLE4dXE/0AVlESUUAtDxCuZzODlJBUM/ELNcuwEB55bJ+ACQi9F6J/kKoU2N7mCKVUApN9OPhh
        vy0Ou9pEx/gGKq0+u0rJSTU7W4DtpkKw5xLc/QlV9/rA6CQZnZa/G5S4Vj2iJRqLgPfUGZVVMlqAy
        xzYHQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htVdS-0007S8-0W; Fri, 02 Aug 2019 11:22:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5A97A2742E8F; Fri,  2 Aug 2019 12:22:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mingo@kernel.org,
        Peter Zijlstra (Intel) <peterz@infradead.org>,
        peterz@infradead.org
Subject: Applied "spi: Reduce kthread priority" to the spi tree
In-Reply-To: <20190801111541.917256884@infradead.org>
X-Patchwork-Hint: ignore
Message-Id: <20190802112209.5A97A2742E8F@ypsilon.sirena.org.uk>
Date:   Fri,  2 Aug 2019 12:22:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Reduce kthread priority

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 4ff13d00ebd5533947b083c66d44da3243a2d559 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 1 Aug 2019 13:13:53 +0200
Subject: [PATCH] spi: Reduce kthread priority

The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.

FIFO-99 is the very highest priority available to SCHED_FIFO and
it not a suitable default; it would indicate the SPI work is the
most important work on the machine.

Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20190801111541.917256884@infradead.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 2 +-
 drivers/spi/spi.c                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 006a8ff64057..714306bc3f79 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 					   struct cros_ec_spi *ec_spi)
 {
 	struct sched_param sched_priority = {
-		.sched_priority = MAX_RT_PRIO - 1,
+		.sched_priority = MAX_RT_PRIO / 2,
 	};
 	int err;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9fd7926e80c0..8e83c9567353 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1434,7 +1434,7 @@ static void spi_pump_messages(struct kthread_work *work)
  */
 static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
 
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");
-- 
2.20.1

