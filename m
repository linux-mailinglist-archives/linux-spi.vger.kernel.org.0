Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3074316251B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBRK6P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 05:58:15 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:58194 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgBRK6P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Feb 2020 05:58:15 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id 4AyC220065USYZQ01AyCyp; Tue, 18 Feb 2020 11:58:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j40Zw-0003jJ-31; Tue, 18 Feb 2020 11:58:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j40Zw-0000FZ-0e; Tue, 18 Feb 2020 11:58:12 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hoan Nguyen An <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] spi: rspi: Add support for configuring word order
Date:   Tue, 18 Feb 2020 11:58:07 +0100
Message-Id: <20200218105810.902-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

	Hi Mark,

This patch series adds support for configuring the word order on Renesas
"RSPI" SPI controllers.

This has been tested on RSK+RZA1 using spidev_test (with/without -L
option).

Thanks!

Geert Uytterhoeven (2):
  spi: rspi: Factor out handling of common mode bits
  spi: rspi: Add support for LSB-first word order

 drivers/spi/spi-rspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
