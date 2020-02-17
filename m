Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED1161D1B
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 23:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgBQWEe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 17:04:34 -0500
Received: from foss.arm.com ([217.140.110.172]:42262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgBQWEe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 17:04:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 388F930E;
        Mon, 17 Feb 2020 14:04:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1DA23F703;
        Mon, 17 Feb 2020 14:04:33 -0800 (PST)
Date:   Mon, 17 Feb 2020 22:04:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Tudor.Ambarus@microchip.com
Subject: Applied "spi: spi-mem: Fix typo, s/fallback/falls back" to the spi tree
In-Reply-To:  <20200216214012.1106658-1-tudor.ambarus@microchip.com>
Message-Id:  <applied-20200216214012.1106658-1-tudor.ambarus@microchip.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-mem: Fix typo, s/fallback/falls back

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

From 32a9d0545c5da9717395264de9b8e004e4b90893 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Sun, 16 Feb 2020 21:40:17 +0000
Subject: [PATCH] spi: spi-mem: Fix typo, s/fallback/falls back

"Fallback" in one word is a noun. "Fall back" is two separate words,
a verb and an adverb. Use the latter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20200216214012.1106658-1-tudor.ambarus@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e5a46f0eb93b..3c46747bacb1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -487,7 +487,7 @@ static ssize_t spi_mem_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
  * This function is creating a direct mapping descriptor which can then be used
  * to access the memory using spi_mem_dirmap_read() or spi_mem_dirmap_write().
  * If the SPI controller driver does not support direct mapping, this function
- * fallback to an implementation using spi_mem_exec_op(), so that the caller
+ * falls back to an implementation using spi_mem_exec_op(), so that the caller
  * doesn't have to bother implementing a fallback on his own.
  *
  * Return: a valid pointer in case of success, and ERR_PTR() otherwise.
-- 
2.20.1

