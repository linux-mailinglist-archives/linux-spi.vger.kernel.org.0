Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5481ABDC8
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504777AbgDPKU4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504724AbgDPKSi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 06:18:38 -0400
X-Greylist: delayed 257 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Apr 2020 03:18:38 PDT
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F7AC061A0F
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2020 03:18:38 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by baptiste.telenet-ops.be with bizsmtp
        id TNJc2200J4dKHqf01NJcg6; Thu, 16 Apr 2020 12:18:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1bQ-0001RS-Dl; Thu, 16 Apr 2020 12:18:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1bQ-0003ns-CI; Thu, 16 Apr 2020 12:18:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] spi: spidev{,_test}: Add support for Octal mode data transfers
Date:   Thu, 16 Apr 2020 12:18:33 +0200
Message-Id: <20200416101835.14573-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

	Hi Mark,

This patch adds support for Octal mode data transfers to spidev and the
spidev_test tool.

Note that this was not tested with Octal-capable hardware.

Thanks for your comments!

Geert Uytterhoeven (2):
  spi: spidev: Add support for Octal mode data transfers
  spi: spidev_test: Add support for Octal mode data transfers

 drivers/spi/spidev.c    |  3 ++-
 tools/spi/spidev_test.c | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
