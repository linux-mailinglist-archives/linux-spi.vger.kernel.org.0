Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE911A879F
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407718AbgDNRgw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 13:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407713AbgDNRgu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 13:36:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956A02054F;
        Tue, 14 Apr 2020 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586885810;
        bh=atfGXc/+cClM0GBREiTZsOZeix3ptYsx1vBG0s8Qvgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0b/WcdPVEQTjlq7Osc3ueiALOavc/xEupuRtgO7xymolTojsL7sxk4GD/t8D0txeR
         xLLvnf4+VSkaXoh/oLUmsxh5C2/Fo+xyZ0WOA97P4EOj6DSXr4iyt5gcwWaOjDWjgl
         5mGcNRLgzhtWNX5mboV07DFkEwDHPh8fBDHrMN+4=
Date:   Tue, 14 Apr 2020 18:36:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com
Subject: Applied "spi: spi-mtk-nor: make mtk_nor_exec_op() statuc" to the spi tree
In-Reply-To:  <20200409085009.44971-1-yanaijie@huawei.com>
Message-Id:  <applied-20200409085009.44971-1-yanaijie@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-mtk-nor: make mtk_nor_exec_op() statuc

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

From afedb4b7282b4c532d8aea105943e71c0efb3a6b Mon Sep 17 00:00:00 2001
From: Jason Yan <yanaijie@huawei.com>
Date: Thu, 9 Apr 2020 16:50:09 +0800
Subject: [PATCH] spi: spi-mtk-nor: make mtk_nor_exec_op() statuc

Fix the following sparse warning:

drivers/spi/spi-mtk-nor.c:394:5: warning: symbol 'mtk_nor_exec_op' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20200409085009.44971-1-yanaijie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mtk-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index c15a9910549f..7bc302b50396 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -391,7 +391,7 @@ static int mtk_nor_pp_unbuffered(struct mtk_nor *sp,
 	return mtk_nor_cmd_exec(sp, MTK_NOR_CMD_WRITE, 6 * BITS_PER_BYTE);
 }
 
-int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->master);
 	int ret;
-- 
2.20.1

