Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE8249F15
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHSNGM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgHSNAO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:00:14 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9625C061359
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:59:15 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id HQz6230064C55Sk01Qz62X; Wed, 19 Aug 2020 14:59:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0002bc-03; Wed, 19 Aug 2020 14:59:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgH-0005SY-U6; Wed, 19 Aug 2020 14:59:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/7] spi: rspi: Bit rate improvements
Date:   Wed, 19 Aug 2020 14:58:57 +0200
Message-Id: <20200819125904.20938-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

	Hi Mark,

This patch series contains several improvements for the Renesas SPI/QSPI
driver related to bit rate configuration.

Changes compared to v1
(https://lore.kernel.org/r/20200608095940.30516-1-geert+renesas@glider.be):
  - Drop accepted patch.

This has been tested on RSK+RZA1 (RSPI) and R-Car M2-W/Koelsch (QSPI),
using a scope and logic analyzer, except for the by-one divider on QSPI.
This has not been tested on legacy SuperH, due to lack of hardware.

Thanks for your comments!

Geert Uytterhoeven (7):
  spi: rspi: Remove useless .set_config_register() check
  spi: rspi: Clean up Bit Rate Division Setting handling
  spi: rspi: Increase bit rate accuracy on RZ/A
  spi: rspi: Increase bit rate range for RSPI on SH
  spi: rspi: Increase bit rate range for QSPI
  spi: rspi: Fill in spi_transfer.effective_speed_hz
  spi: rspi: Fill in controller speed limits

 drivers/spi/spi-rspi.c | 81 +++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 29 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
