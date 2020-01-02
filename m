Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8212E6FF
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2020 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgABOEt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 09:04:49 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:41588 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgABOEo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 09:04:44 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id lS4g2100B5USYZQ01S4gFM; Thu, 02 Jan 2020 15:04:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in15c-0006GP-Mp; Thu, 02 Jan 2020 15:04:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in0gG-0007eJ-A5; Thu, 02 Jan 2020 14:38:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/6] spi: rspi: Add support for multiple native and GPIO chip selects
Date:   Thu,  2 Jan 2020 14:38:16 +0100
Message-Id: <20200102133822.29346-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

	Hi all,

Currently the Renesas SPI (RSPI/QSPI) driver supports a single native
chip select only.  This patch series adds support for multiple native
and GPIO chip selects.

As the RSPI controller always drives a native chip select when
performing a transfer, at least one native chip select must be left
unused, just like on MSIOF.  To avoid code duplication, the first two
patches add generic handling of unused native chip selects to the SPI
core, and converts the MSIOF driver to make use of this.  I expect
spi-orion can be converted, too.

Patches 3 and 4 contain two small drive-by cleanups.

on older SuperH and R-Mobile SoCs only, unfortunately, and thus
untested.  But it is too trivial not to implement ;-)

Patch 6 adds support for GPIO chip selects.

This has been tested with concurrent access to two cs-gpio slaves
connected to the two PMOD connectors on the RSK+RZA1 development board,
and regression-tested on Koelsch (single native chip select).

Thanks for your comments!

Geert Uytterhoeven (6):
  spi: Add generic support for unused native cs with cs-gpios
  spi: sh-msiof: Convert to generic unused native cs handling.
  spi: rspi: Use dev_warn_once() instead of open-coding
  spi: rspi: Remove set_config_register() macro
  spi: rspi: Add support for multiple native chip selects
  spi: rspi: Add support for GPIO chip selects

 drivers/spi/spi-rspi.c     | 21 ++++++++++-----
 drivers/spi/spi-sh-msiof.c | 53 +++-----------------------------------
 drivers/spi/spi.c          | 17 ++++++++++++
 include/linux/spi/spi.h    |  8 ++++++
 4 files changed, 42 insertions(+), 57 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
