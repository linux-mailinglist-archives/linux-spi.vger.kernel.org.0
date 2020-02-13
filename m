Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57ACE15BF6A
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 14:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgBMNcg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 08:32:36 -0500
Received: from foss.arm.com ([217.140.110.172]:46706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgBMNcg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 13 Feb 2020 08:32:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3147106F;
        Thu, 13 Feb 2020 05:32:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B343F6CF;
        Thu, 13 Feb 2020 05:32:35 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:32:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev_test: Remove break after exit statement" to the spi tree
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Message-Id: <applied-1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spidev_test: Remove break after exit statement

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

From 020bd6c48ebd864d42b5b551a87a323e443918a6 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Thu, 13 Feb 2020 12:16:05 +0800
Subject: [PATCH] spi: spidev_test: Remove break after exit statement

When call print_usage() in parse_opts(), it will exit directly.
Since break is not useful after exit statement, remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/spidev_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 3559e7646256..113b1e1d62ca 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -283,7 +283,6 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		default:
 			print_usage(argv[0]);
-			break;
 		}
 	}
 	if (mode & SPI_LOOP) {
-- 
2.20.1

