Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5B2E2DE3
	for <lists+linux-spi@lfdr.de>; Sat, 26 Dec 2020 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgLZKFp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 26 Dec 2020 05:05:45 -0500
Received: from tux.runtux.com ([176.9.82.136]:57772 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgLZKFp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 26 Dec 2020 05:05:45 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Dec 2020 05:05:44 EST
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 262A86F070;
        Sat, 26 Dec 2020 10:58:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IXeIB_tByXV2; Sat, 26 Dec 2020 10:58:46 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 81DFB6F01F;
        Sat, 26 Dec 2020 10:58:46 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 7505146C; Sat, 26 Dec 2020 10:58:45 +0100 (CET)
Date:   Sat, 26 Dec 2020 10:58:45 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Fix SPI Chipselect/Clock bug for sun6i
Message-ID: <20201226095845.c65lhsmluddvwxsl@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch makes additional GPIOs usable as chipselects for SPI.
It is available for years on the linux-sunxi SPIdev page at
http://linux-sunxi.org/SPIdev and probably is originally by the user
"Mirko" there. I've tried unsuccessfully to contact the author.
Note that contrary to what is stated on the page above, the bug doesn't
have cosmetic implications only:

The SPI-Driver for the H2 Allwinner processor in the Linux kernel is
supposed to support normal GPIOs as additional chipselects but fails to
do so without the patch.

For oscilloscope screenshots with/without the patch, see my blog post
https://blog.runtux.com/posts/2019/04/18/
or the discussion in the armbian forum at
https://forum.armbian.com/topic/4330-spi-gpio-chip-select-support/
(my logo there is a penguin).
Please bear with me if I'm not following proper procedures, this is my
first patch to the kernel in years.

Thanks
Ralf Schlatterbeck

From 682ae1848b0df00cceb4c76486b971826b2737a9 Mon Sep 17 00:00:00 2001
From: Ralf Schlatterbeck <rsc@runtux.com>
Date: Thu, 11 Apr 2019 16:21:54 +0200
Subject: [PATCH] Fix SPI Chipselect/Clock bug for sun6i
Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>

The current sun6i SPI implementation initializes the transfer too early,
resulting in SCK going high before the transer. When using an additional
(gpio) chipselect with sun6i, the chipselect is asserted at a time when
clock is high, making the SPI transfer fail.  This patch from the sunxi
spidev page http://linux-sunxi.org/SPIdev fixes this, without the patch
no additional gpio chipselects can be used. The relevant code seems to
be from the user "Mirko" of the linux-sunxi wiki page, I was unable to
contact the original author.
---
 drivers/spi/spi-sun6i.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 19238e1b76b4..9b292c6ade50 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -290,6 +290,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	}
 
 	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
+	/* Finally enable the bus - doing so before might raise SCK to HIGH */
+	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
+			sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG)
+			| SUN6I_GBL_CTL_BUS_ENABLE);
 
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
@@ -398,7 +402,7 @@ static int sun6i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
-			SUN6I_GBL_CTL_BUS_ENABLE | SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
+			SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
 
 	return 0;
 
-- 
2.20.1
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
