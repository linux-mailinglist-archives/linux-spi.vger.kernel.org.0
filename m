Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9032211B943
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 17:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfLKQzQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 11:55:16 -0500
Received: from foss.arm.com ([217.140.110.172]:39450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfLKQzQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Dec 2019 11:55:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AEA930E;
        Wed, 11 Dec 2019 08:55:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4CF3F52E;
        Wed, 11 Dec 2019 08:55:14 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:55:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        pakki001@umn.edu
Subject: Applied "spi: dw: Avoid BUG_ON() in case of host failure" to the spi tree
In-Reply-To: <20191205231421.9333-1-pakki001@umn.edu>
Message-Id: <applied-20191205231421.9333-1-pakki001@umn.edu>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw: Avoid BUG_ON() in case of host failure

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 169f9acae08685d4f2a6fd32983958d44e10905d Mon Sep 17 00:00:00 2001
From: Aditya Pakki <pakki001@umn.edu>
Date: Thu, 5 Dec 2019 17:14:21 -0600
Subject: [PATCH] spi: dw: Avoid BUG_ON() in case of host failure

If dws is NULL in dw_spi_host_add(), we return the error to the
upper callers instead of crashing. The patch replaces BUG_ON by
returning -EINVAL to the caller.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Link: https://lore.kernel.org/r/20191205231421.9333-1-pakki001@umn.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe..a160d9a141ea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -460,7 +460,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	struct spi_controller *master;
 	int ret;
 
-	BUG_ON(dws == NULL);
+	if (!dws)
+		return -EINVAL;
 
 	master = spi_alloc_master(dev, 0);
 	if (!master)
-- 
2.20.1

