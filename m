Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467241A879C
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407707AbgDNRgs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 13:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732341AbgDNRgr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 13:36:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D142054F;
        Tue, 14 Apr 2020 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586885805;
        bh=dLeDAThV8kQoCNI/yPc4Mw2qBLn+UJUjm/c3oYisn8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gZW+wQmHQt1qRDORHekon7daC+J5AZN3hX4j7GebEVf0go2mEePNEsolKpTtqYInK
         jrVFgHZbWzL38hA8P7bA7DsAevfE+XktPGAPGL5HqVi0WNsV+mPRsilfX01hWKHwaZ
         Q5atE9v5j4dmCMOwV8wTWKbd+Q6ic9Z/SXiCrPUo=
Date:   Tue, 14 Apr 2020 18:36:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aishwarya R <aishwaryarj100@gmail.com>
Cc:     Aishwarya R <raishwar@visteon.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        raishwar@visteon.com
Subject: Applied "spi: spi-sh-msiof: Fix checkpatch error Complex macros should use ()" to the spi tree
In-Reply-To:  <20200406155301.21768-1-raishwar@visteon.com>
Message-Id:  <applied-20200406155301.21768-1-raishwar@visteon.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-sh-msiof: Fix checkpatch error Complex macros should use ()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 21fb1f41bcdf436f6969f4651dce0df62985f69a Mon Sep 17 00:00:00 2001
From: Aishwarya R <aishwaryarj100@gmail.com>
Date: Mon, 6 Apr 2020 21:23:01 +0530
Subject: [PATCH] spi: spi-sh-msiof: Fix checkpatch error Complex macros should
 use ()

Fixed checkpatch error "Macros with complex values should be enclosed
in parentheses"

Signed-off-by: Aishwarya R <raishwar@visteon.com>
Link: https://lore.kernel.org/r/20200406155301.21768-1-raishwar@visteon.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1c11a00a2c36..b2579af0e3eb 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1398,7 +1398,7 @@ static int sh_msiof_spi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
 			 sh_msiof_spi_resume);
-#define DEV_PM_OPS	&sh_msiof_spi_pm_ops
+#define DEV_PM_OPS	(&sh_msiof_spi_pm_ops)
 #else
 #define DEV_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP */
-- 
2.20.1

