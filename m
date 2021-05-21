Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D214938CED1
	for <lists+linux-spi@lfdr.de>; Fri, 21 May 2021 22:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEUUUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 May 2021 16:20:42 -0400
Received: from tux.runtux.com ([176.9.82.136]:39680 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhEUUUm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 May 2021 16:20:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id DE1E96F00A;
        Fri, 21 May 2021 22:19:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id idEQAUquvFTc; Fri, 21 May 2021 22:19:14 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id EBA096EF63;
        Fri, 21 May 2021 22:19:13 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 9233046E; Fri, 21 May 2021 22:19:13 +0200 (CEST)
Date:   Fri, 21 May 2021 22:19:13 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mirko Vogt <mirko-dev|linux@nanl.de>
Subject: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
Message-ID: <20210521201913.2gapcmrzynxekro7@runtux.com>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
 <20210521173011.1c602682@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521173011.1c602682@slackpad.fritz.box>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mirko Vogt <mirko-dev|linux@nanl.de>

The current sun6i SPI implementation initializes the transfer too early,
resulting in SCK going high before the transfer. When using an additional
(gpio) chipselect with sun6i, the chipselect is asserted at a time when
clock is high, making the SPI transfer fail.

This is due to SUN6I_GBL_CTL_BUS_ENABLE being written into
SUN6I_GBL_CTL_REG at an early stage. Moving that to the transfer
function, hence, right before the transfer starts, mitigates that
problem.

Signed-off-by: Mirko Vogt <mirko-dev|linux@nanl.de>
Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
---
Updated patch with suggested improvements by Andre Przywara
For oscilloscope screenshots with/without the patch, see my blog post
https://blog.runtux.com/posts/2019/04/18/
or the discussion in the armbian forum at
https://forum.armbian.com/topic/4330-spi-gpio-chip-select-support/
(my logo there is a penguin).

 drivers/spi/spi-sun6i.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index cc8401980125..23ad052528db 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -379,6 +379,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	}
 
 	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
+	/* Finally enable the bus - doing so before might raise SCK to HIGH */
+	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
+	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
+	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG, reg);
 
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
@@ -504,7 +508,7 @@ static int sun6i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
-			SUN6I_GBL_CTL_BUS_ENABLE | SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
+			SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
 
 	return 0;
 
-- 
2.20.1

