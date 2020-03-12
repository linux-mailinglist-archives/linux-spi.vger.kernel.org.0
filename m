Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8418369C
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 17:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgCLQwk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 12:52:40 -0400
Received: from foss.arm.com ([217.140.110.172]:38062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLQwk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 12:52:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66D330E;
        Thu, 12 Mar 2020 09:52:39 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39AF83F6CF;
        Thu, 12 Mar 2020 09:52:39 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:52:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>, Han Xu <han.xu@nxp.com>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>
Subject: Applied "spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe" to the spi tree
In-Reply-To:  <20200312113154.GC20562@mwanda>
Message-Id:  <applied-20200312113154.GC20562@mwanda>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe

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

From 1a421ebab6bb5bf65001743ba9fef48e94fb345a Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 12 Mar 2020 14:31:54 +0300
Subject: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe

The platform_get_resource_byname() function returns NULL on error, it
doesn't return error pointers.

Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200312113154.GC20562@mwanda
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 019f40e2917c..1ccda82da206 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1019,8 +1019,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
-	if (IS_ERR(res)) {
-		ret = PTR_ERR(res);
+	if (!res) {
+		ret = -ENODEV;
 		goto err_put_ctrl;
 	}
 
-- 
2.20.1

