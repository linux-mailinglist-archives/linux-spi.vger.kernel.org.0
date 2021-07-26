Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF363D5AF1
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhGZNZO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZNZN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Jul 2021 09:25:13 -0400
X-Greylist: delayed 253 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jul 2021 07:05:42 PDT
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B315C061757
        for <linux-spi@vger.kernel.org>; Mon, 26 Jul 2021 07:05:42 -0700 (PDT)
Received: from myt5-d8fb82618a34.qloud-c.yandex.net (myt5-d8fb82618a34.qloud-c.yandex.net [IPv6:2a02:6b8:c12:59a3:0:640:d8fb:8261])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 220B81C81E12;
        Mon, 26 Jul 2021 17:01:23 +0300 (MSK)
Received: from myt3-07a4bd8655f2.qloud-c.yandex.net (myt3-07a4bd8655f2.qloud-c.yandex.net [2a02:6b8:c12:693:0:640:7a4:bd86])
        by myt5-d8fb82618a34.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 05ydkELBYN-1MIqVdno;
        Mon, 26 Jul 2021 17:01:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627308083;
        bh=6TqxMApa5kcdZX8jPD0nGQ3trmLFjcpmrXvvUjOT4Rk=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=ahZ2fmMmWFL5o80XnAFJfK6QJ8DAlU1SVA4QbyRQBu0dUID2hgJRfw2Ya6w0CqeHK
         i/MuCEoz4/YjB5bZ25kBDFxYnkCwUBDFGTVidxmqQUjhbLkO+qjcTgjlX1Ik/bKnCh
         vbuC8djItOv7G3UsMrXkiRJc/kxhEL8kaI9O/iRo=
Authentication-Results: myt5-d8fb82618a34.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt3-07a4bd8655f2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id olJ9yWy468-1M2iTObv;
        Mon, 26 Jul 2021 17:01:22 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/8] spi: spi-ep93xx: Prepare clock before using it
Date:   Mon, 26 Jul 2021 16:59:50 +0300
Message-Id: <20210726140001.24820-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726140001.24820-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared ep93xx-spi.0
...
Hardware name: Cirrus Logic EDB9302 Evaluation Board
...
clk_core_enable
clk_core_enable_lock
ep93xx_spi_prepare_hardware
__spi_pump_messages
__spi_sync
spi_sync
spi_sync_transfer.constprop.0
regmap_spi_write
_regmap_raw_write_impl
_regmap_bus_raw_write
_regmap_update_bits
regmap_update_bits_base
cs4271_component_probe
snd_soc_component_probe
soc_probe_component
snd_soc_bind_card
edb93xx_probe
...
spi_master spi0: failed to prepare transfer hardware: -108

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/spi/spi-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index aa676559d273..5896a7b2fade 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -550,7 +550,7 @@ static int ep93xx_spi_prepare_hardware(struct spi_master *master)
 	u32 val;
 	int ret;
 
-	ret = clk_enable(espi->clk);
+	ret = clk_prepare_enable(espi->clk);
 	if (ret)
 		return ret;
 
@@ -570,7 +570,7 @@ static int ep93xx_spi_unprepare_hardware(struct spi_master *master)
 	val &= ~SSPCR1_SSE;
 	writel(val, espi->mmio + SSPCR1);
 
-	clk_disable(espi->clk);
+	clk_disable_unprepare(espi->clk);
 
 	return 0;
 }
-- 
2.26.2

