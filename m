Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E382315BF67
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgBMNcb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 08:32:31 -0500
Received: from foss.arm.com ([217.140.110.172]:46694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgBMNcb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 13 Feb 2020 08:32:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E3E81063;
        Thu, 13 Feb 2020 05:32:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5DD83F6CF;
        Thu, 13 Feb 2020 05:32:30 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:32:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev_test: Use perror() only if errno is not 0" to the spi tree
In-Reply-To: <1581567368-8055-3-git-send-email-yangtiezhu@loongson.cn>
Message-Id: <applied-1581567368-8055-3-git-send-email-yangtiezhu@loongson.cn>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spidev_test: Use perror() only if errno is not 0

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

From 470a072e12200576788dc622d58894609feae2d7 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Thu, 13 Feb 2020 12:16:07 +0800
Subject: [PATCH] spi: spidev_test: Use perror() only if errno is not 0

It is better to use perror() only if errno is not 0, it should use printf()
when errno is 0, otherwise there exists redudant ": Success".

E.g. without this patch:

$ ./spidev_test -p 1234 --input test.bin
only one of -p and --input may be selected: Success
Aborted (core dumped)

With this patch:

$ ./spidev_test -p 1234 --input test.bin
only one of -p and --input may be selected
Aborted (core dumped)

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1581567368-8055-3-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/spidev_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 5866178cdcc9..27967dd90f8f 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 #include <getopt.h>
 #include <fcntl.h>
 #include <time.h>
@@ -26,7 +27,11 @@
 
 static void pabort(const char *s)
 {
-	perror(s);
+	if (errno != 0)
+		perror(s);
+	else
+		printf("%s\n", s);
+
 	abort();
 }
 
-- 
2.20.1

