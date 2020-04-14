Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4D1A87A9
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440432AbgDNRhR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 13:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440297AbgDNRhL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 13:37:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330592054F;
        Tue, 14 Apr 2020 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586885830;
        bh=LpwviLsVNM9P2b0C2NQOinyd32vuFV2xrpFIULefpQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IYI6FBrfzydQucos+PkX8TQl/lmtqZfZNerWvB2UXCzjDNUtZEsPYqbvTWKlmdRBX
         XpQXmRf5gqsfhiseZSTzjHYny6zbPI/IT1n54atQQUt8ioZp78QYfcbto5MXgQNFC4
         YzfAoYXSe2pGWoFvmu6KnhAtxLPn9J9CHCTyxlwA=
Date:   Tue, 14 Apr 2020 18:37:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Applied "spi: spidev_test: Remove hidden temporary file when make clean" to the spi tree
In-Reply-To:  <1586230512-5507-1-git-send-email-yangtiezhu@loongson.cn>
Message-Id:  <applied-1586230512-5507-1-git-send-email-yangtiezhu@loongson.cn>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spidev_test: Remove hidden temporary file when make clean

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

From 0b93dd98d6d5ba93f834113994dbc8f291447dae Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 7 Apr 2020 11:35:12 +0800
Subject: [PATCH] spi: spidev_test: Remove hidden temporary file when make
 clean

In the current code, it only removes *.o and .*.o.d file when make clean,
there still exists useless .*.o.cmd file, just remove it.

Without this patch:

[yangtiezhu@linux spi]$ make
[yangtiezhu@linux spi]$ make clean
[yangtiezhu@linux spi]$ ls -1 .*.o.cmd
.spidev_fdx-in.o.cmd
.spidev_fdx.o.cmd
.spidev_test-in.o.cmd
.spidev_test.o.cmd

With this patch:

[yangtiezhu@linux spi]$ make
[yangtiezhu@linux spi]$ make clean
[yangtiezhu@linux spi]$ ls -1 .*.o.cmd
ls: cannot access .*.o.cmd: No such file or directory

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/1586230512-5507-1-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index 2249a1546cc1..ada881afb489 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -52,7 +52,9 @@ $(OUTPUT)spidev_fdx: $(SPIDEV_FDX_IN)
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/
-	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '\.*.o.d' -delete
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '\.*.o.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-- 
2.20.1

