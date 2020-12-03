Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CF22CDBA5
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 17:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLCQ6e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 11:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLCQ6e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 11:58:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E937C061A4F;
        Thu,  3 Dec 2020 08:57:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q10so1695007pfn.0;
        Thu, 03 Dec 2020 08:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4RN4lDKcBCUJRe+wn8srvtMYKGE3DNBe+LKKp0gOoAk=;
        b=Gz81ipfafeXXxDWwoD7NhXxSdejww5z0emFjuapn3aVcTUxw37OKDZNqULpzdD4dj7
         q765lFPvNtmR9Omi4KGwZtJaD5KFYD2LrRMpDzdquFg92DhrxOqRcPgy9Dsdu1UrogBL
         frULSkTqRr2TmDWUV5FRAyRh4gmniAQ1o87y89moD3159GNcbT03JWVSs4cg8TT3B/18
         UdlOeGA9YKp1JPUe6/WQhZRtKsbK4FS880B9PkRP0xRhfPLo64RqQ2UUyJW95EkuqMJq
         mb5JQ1L9NhVqVjdo338dcmDxyl11FYRPCj/n5ipSlH6Xvi4M1pPqX3lu8zhpqohJMWGx
         jQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4RN4lDKcBCUJRe+wn8srvtMYKGE3DNBe+LKKp0gOoAk=;
        b=LfScWR1D/BXik/cN/0Qfq4fqZ74tQTHPlWdU6MNY9so27n634FIZWlcLtmQbMqXARP
         W386WbbFcFnARF++iAp1JuNpRLUqkR73hQckKCKuinfriiW8Ti2GI/2eNdsR/kfW581D
         PX/CohJRMnoNb66hrVQorIE/WXIBsOML6D6NBD+Nm63KvKVEWDdQqHsfnTABf++uN/6l
         gC4R1XcuEnPZNfzE6XjpkX8MG0O236Ys2mRBFdIcGjGwtL19r/qx7tNrsDiZI9BIBB37
         aIK9xcTIlzHoPBWZ4NowBqVZyA7oOeuwntfHmyz86hmnHV9g0zWPw2PJsGoj/aQIaoIg
         +Pag==
X-Gm-Message-State: AOAM5307XlUusNd6px5nkkZCZJnLoCkuW7dI+A0HkofPv09xGf77z6dT
        yF1mEYAc1LkEAH+tssDK09ki6pnF8s4TPCDaFbk=
X-Google-Smtp-Source: ABdhPJxYBKiOnIUXc4yQq5LsA65+zeEz4hHqZwFMki3dZm6SenHWuj43KDbJsAkO3zmjp+VLnL2xyEfLZo7ZCAbtFJA=
X-Received: by 2002:a63:a0b:: with SMTP id 11mr3807266pgk.21.1607014667655;
 Thu, 03 Dec 2020 08:57:47 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?0JzQsNC60YHQuNC8INCa0LjRgdC10LvRkdCy?= 
        <bigunclemax@gmail.com>
Date:   Thu, 3 Dec 2020 19:57:36 +0300
Message-ID: <CALHCpMiWdSYxzKK5dXb7AGQ1ncsXmD853g9Aq0zd5YjE5cno8w@mail.gmail.com>
Subject: 
To:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?0JzQsNC60YHQuNC8INCa0LjRgdC10LvRkdCy?= 
        <bigunclemax@gmail.com>, Maxim Kochetkov <fido_max@inbox.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From 772007b92eda50186c2e420b5bd895d4e4006ae8 Mon Sep 17 00:00:00 2001
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
