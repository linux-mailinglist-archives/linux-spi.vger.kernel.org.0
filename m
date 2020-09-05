Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781D125E8A2
	for <lists+linux-spi@lfdr.de>; Sat,  5 Sep 2020 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgIEPTt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Sep 2020 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIEPTs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Sep 2020 11:19:48 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54354C061244
        for <linux-spi@vger.kernel.org>; Sat,  5 Sep 2020 08:19:46 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BkJB34Lzyz1rtyY;
        Sat,  5 Sep 2020 17:19:39 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BkJB33fg7z1qy6Y;
        Sat,  5 Sep 2020 17:19:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id HKxPIvQkAkdx; Sat,  5 Sep 2020 17:19:38 +0200 (CEST)
X-Auth-Info: 1P9+LL5s6mTX0SM2SwU4fZXO4EUujbYRKO3bgSiMtTc=
Received: from desktop.lan (ip-86-49-101-166.net.upcbroadband.cz [86.49.101.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  5 Sep 2020 17:19:38 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: stm32: Rate-limit the 'Communication suspended' message
Date:   Sat,  5 Sep 2020 17:19:13 +0200
Message-Id: <20200905151913.117775-1-marex@denx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'spi_stm32 44004000.spi: Communication suspended' message means that
when using PIO, the kernel did not read the FIFO fast enough and so the
SPI controller paused the transfer. Currently, this is printed on every
single such event, so if the kernel is busy and the controller is pausing
the transfers often, the kernel will be all the more busy scrolling this
message into the log buffer every few milliseconds. That is not helpful.

Instead, rate-limit the message and print it every once in a while. It is
not possible to use the default dev_warn_ratelimited(), because that is
still too verbose, as it prints 10 lines (DEFAULT_RATELIMIT_BURST) every
5 seconds (DEFAULT_RATELIMIT_INTERVAL). The policy here is to print 1 line
every 50 seconds (DEFAULT_RATELIMIT_INTERVAL * 10), because 1 line is more
than enough and the cycles saved on printing are better left to the CPU to
handle the SPI. However, dev_warn_once() is also not useful, as the user
should be aware that this condition is possibly recurring or ongoing. Thus
the custom rate-limit policy.

Finally, turn the message from dev_warn() to dev_dbg(), since the system
does not suffer any sort of malfunction if this message appears, it is
just slowing down. This further reduces the printing into the log buffer
and frees the CPU to do useful work.

Fixes: dcbe0d84dfa5 ("spi: add driver for STM32 SPI controller")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index d4b33b358a31..a00f6b51ccbf 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -936,7 +936,11 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	}
 
 	if (sr & STM32H7_SPI_SR_SUSP) {
-		dev_warn(spi->dev, "Communication suspended\n");
+		static DEFINE_RATELIMIT_STATE(rs,
+					      DEFAULT_RATELIMIT_INTERVAL * 10,
+					      1);
+		if (__ratelimit(&rs))
+			dev_dbg_ratelimited(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi, false);
 		/*
-- 
2.28.0

