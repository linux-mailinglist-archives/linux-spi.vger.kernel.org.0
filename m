Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B172CDC11
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 18:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgLCRNL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgLCRNL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 12:13:11 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A98C061A4F;
        Thu,  3 Dec 2020 09:12:31 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id r9so1435186pjl.5;
        Thu, 03 Dec 2020 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3rpkGdvnJ4tE6aT83D7Bz5ZVtxLPAIcugyQgY5ZXjpg=;
        b=I4JbDRBzK0VXbI7b3GMCZ9uASF7K2g3ZYeioXxgRkFWg1mTN5AyssIIRCk9lc6hHou
         DUjhfKWGgQj0pXz7xSaZyF+la3ri9wtENrzhSOldb8ap4CILBONRyrRUCnxBrcgEl7Ga
         kyD9UTMFlIeYqE88Ls738HvWufGmiWzxefVaLKHSztHGmwW+IhQ5/9yRFfOTc6svnexu
         qt5srIsT8RyD6tznPhFa2MV3VHTadlVrYk0RJwWwv/FKsNyUOl+dPOXFSL8k1vmGqSH+
         4qnEmIj7MqFjH1a5AFByAGzDxHKZuWkBCKfqCVNkc+XRURDHqfmyUzM+E6fp6vrXcOnM
         oXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3rpkGdvnJ4tE6aT83D7Bz5ZVtxLPAIcugyQgY5ZXjpg=;
        b=rCsWBH0xzv4t0+oYEvwWxR74C2SFjAQoD5YwUulVrHVaT2p2w2EXHlF7grSrSs/9NM
         TgMT6hBg1plelyKMSMJZkfuSJkygACmA7QDV/j21ddNE2tcQHdw8R2Bd8uIDXSxLhP38
         lbQVdq5OFE9U0peOobJQin5aqvZK1UNDMucw3IIDJJv8CoMefO7xfOGnvnmJQbMBhD6J
         xfMEmT+Mu/9mEHkgDiboB/RlJ8BZsmwHijLeufbT9EVVrmUA/TV5D1QYRlIvN0l09zyc
         QO2iAIR7/RG1kkzFGp+aEPGjGSEy3a+jZ+UzzMm8mKsW3mOIuJe/c7xz/CjTOtlJ8rFT
         NI1w==
X-Gm-Message-State: AOAM533xGycuECElJ5TPp5YhYzwb6pVyDOSrN1aAGLTTItYKT1XZwjkR
        URP1scr1JhoyY8c0Ow8hoe0SlBXdQehdGYJ9iIg=
X-Google-Smtp-Source: ABdhPJwP1zhIo5Uk4+obLh3K1XwnBsU+iNME4g7Q13mocnpdKMjFKFo/6GiAPEi/2Zs3lo3UGf7vCWZJZnyjksZ+IgI=
X-Received: by 2002:a17:90b:224e:: with SMTP id hk14mr111426pjb.98.1607015550757;
 Thu, 03 Dec 2020 09:12:30 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?0JzQsNC60YHQuNC8INCa0LjRgdC10LvRkdCy?= 
        <bigunclemax@gmail.com>
Date:   Thu, 3 Dec 2020 20:12:19 +0300
Message-ID: <CALHCpMgQPDqV1tB6v0sA0imwfZGkoG_j84NZCehOT1pf8MTuCA@mail.gmail.com>
Subject: [PATCH] spi: spi-fsl-dspi: Add GPIO chip select support
To:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?0JzQsNC60YHQuNC8INCa0LjRgdC10LvRkdCy?= 
        <bigunclemax@gmail.com>, Maxim Kochetkov <fido_max@inbox.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Thu, 3 Dec 2020 18:56:12 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Add GPIO chip select support

This patch allows use of GPIO for the chip select.
Because dSPI controller can't send transactions without hardware chip
selects, so first unused native CS will be set in SPI_PUSHR_CMD_PCS

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 028736687488..d5fba34de740 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -913,9 +913,14 @@ static int dspi_transfer_one_message(struct
spi_controller *ctlr,
         dspi->cur_transfer = transfer;
         dspi->cur_msg = message;
         dspi->cur_chip = spi_get_ctldata(spi);
+
+        if (spi->cs_gpiod)
+            gpiod_set_value(spi->cs_gpiod, 1);
+
         /* Prepare command word for CMD FIFO */
         dspi->tx_cmd = SPI_PUSHR_CMD_CTAS(0) |
-                   SPI_PUSHR_CMD_PCS(spi->chip_select);
+                   SPI_PUSHR_CMD_PCS(spi->cs_gpiod ?
+                         ctlr->unused_native_cs : spi->chip_select);
         if (list_is_last(&dspi->cur_transfer->transfer_list,
                  &dspi->cur_msg->transfers)) {
             /* Leave PCS activated after last transfer when
@@ -1240,6 +1245,7 @@ static int dspi_probe(struct platform_device *pdev)
     dspi->pdev = pdev;
     dspi->ctlr = ctlr;

+    ctlr->use_gpio_descriptors = true;
     ctlr->setup = dspi_setup;
     ctlr->transfer_one_message = dspi_transfer_one_message;
     ctlr->dev.of_node = pdev->dev.of_node;
-- 
2.27.0
