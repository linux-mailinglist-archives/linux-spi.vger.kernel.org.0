Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222381F161A
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgFHJ7u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgFHJ7p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 05:59:45 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48521C08C5CA
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 02:59:44 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by michel.telenet-ops.be with bizsmtp
        id oZzi2200A0R8aca06Zziol; Mon, 08 Jun 2020 11:59:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007P0-Ak; Mon, 08 Jun 2020 11:59:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007x4-8K; Mon, 08 Jun 2020 11:59:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/8] spi: rspi: Bit rate improvements
Date:   Mon,  8 Jun 2020 11:59:32 +0200
Message-Id: <20200608095940.30516-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

	Hi Mark,

This patch series contains several improvements for the Renesas SPI/QSPI
driver related to bit rate configuration.

This has been tested on RSK+RZA1 (RSPI) and R-Car M2-W/Koelsch (QSPI),
using a scope and logic analyzer, except for the by-one divider on QSPI.
This has not been tested on legacy SuperH, due to lack of hardware.

Thanks for your comments!

Geert Uytterhoeven (8):
  spi: rspi: Remove useless .set_config_register() check
  spi: rspi: Use requested instead of maximum bit rate
  spi: rspi: Clean up Bit Rate Division Setting handling
  spi: rspi: Increase bit rate accuracy on RZ/A
  spi: rspi: Increase bit rate range for RSPI on SH
  spi: rspi: Increase bit rate range for QSPI
  spi: rspi: Fill in spi_transfer.effective_speed_hz
  spi: rspi: Fill in controller speed limits

 drivers/spi/spi-rspi.c | 101 ++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 32 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
