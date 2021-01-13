Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0BA2F487D
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbhAMKUB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbhAMKUA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jan 2021 05:20:00 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600DDC061794
        for <linux-spi@vger.kernel.org>; Wed, 13 Jan 2021 02:19:20 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id GAKJ240064C55Sk01AKJ9p; Wed, 13 Jan 2021 11:19:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzdFF-003EHA-Ox; Wed, 13 Jan 2021 11:19:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzdFF-004oa0-3y; Wed, 13 Jan 2021 11:19:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] spi: sh-msiof: Advertize bit rate limits and actual speed
Date:   Wed, 13 Jan 2021 11:19:14 +0100
Message-Id: <20210113101916.1147695-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

	Hi Mark,

This patch series makes the Renesas MSIOF SPI driver fill in actual
transfer speeds and controller limits, so the SPI core can take them
into account.

This has been tested on R-Car Gen2 and Gen3.
Thanks!

Geert Uytterhoeven (2):
  spi: sh-msiof: Fill in spi_transfer.effective_speed_hz
  spi: sh-msiof: Fill in controller speed limits

 drivers/spi/spi-sh-msiof.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
