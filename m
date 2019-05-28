Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276512C99B
	for <lists+linux-spi@lfdr.de>; Tue, 28 May 2019 17:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE1PH1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 May 2019 11:07:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1PH1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 11:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0+E2u/R03c5rPCMEH9eEWAg7IhEIFC7wRcCvovhk0TE=; b=xpZgTG8H0HVB
        /crTj5heZptBCg1c+uDaPw0D4ABriLSifu2LzuBjsQ7Ifz2g/q/FVsacgY/zfNY4eTJzK5seXaOF5
        NMoC07kQMX9WclvvAZHLkCqPyM582pY33E743KIHg0yvTRpN9/hEK3Sa+JXJFsSSrrVQsyfIow4Gv
        4im+U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVdhD-0002qS-5Y; Tue, 28 May 2019 15:07:23 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8F921440046; Tue, 28 May 2019 16:07:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-meson-spifc: update with SPDX Licence identifier" to the spi tree
In-Reply-To: <20190527134124.3034-1-narmstrong@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190528150722.8F921440046@finisterre.sirena.org.uk>
Date:   Tue, 28 May 2019 16:07:22 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-meson-spifc: update with SPDX Licence identifier

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 891100dfa2d6eeca6913b45c883b72efee7c229b Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Mon, 27 May 2019 15:41:24 +0200
Subject: [PATCH] spi: spi-meson-spifc: update with SPDX Licence identifier

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spifc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 616566e793c6..f7fe9b13d122 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -1,15 +1,9 @@
-/*
- * Driver for Amlogic Meson SPI flash controller (SPIFC)
- *
- * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Driver for Amlogic Meson SPI flash controller (SPIFC)
+//
+// Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
+//
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.20.1

