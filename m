Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB7739C66
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFVJPd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjFVJOv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 05:14:51 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB70B5249
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 02:06:37 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687424796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=smUguiUnq/2ETy4GDzWzASOaK7+FY98RKmwyQrczEKo=;
        b=Kt8zDoybTN2+sdhcOsTJ/AVmCuksnWdHAZJ0wEg/DE+N+X3NqqF4xHoaT3JEonsxvIDbLt
        2Haj8RarDMprtsD6IamCksSqm2/GLskf3JSNmCzYoFMyOm/B3zeqX41F2M2XizvzwEX/tf
        JHHiqTVE+2MzvBqIxDRbnPJSTgKrR4tii10ruPu8wRmKFpXMkc/EXmXXXsMQQ0zqpUOFZk
        wURIVhjBb/Sk5D0/LfQFsuNSQD1HLT3Jjc2qpN8gw6NgFy3fGMJ710M1TtXi5agzVNneYx
        ecBTVTMk0d0AXMY4HW1Fwhu9/Gd/yzTrKpxK1o/A/1GC+pK466qa+GRqoIbxuA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8C7E4000C;
        Thu, 22 Jun 2023 09:06:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/3] spi: Helper for deriving timeout values
Date:   Thu, 22 Jun 2023 11:06:31 +0200
Message-Id: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I recently came across an issue with the Atmel spi controller driver
which would stop my transfers after a too small timeout when performing
big transfers (reading a 4MiB flash in one transfer). My initial idea
was to derive a the maximum amount of time a transfer would take
depending on its size and use that as value to avoid erroring-out when
not relevant. Mark wanted to go further by creating a core helper doing
that, based on the heuristics from the sun6i driver.

Here is a small series of 3 patches doing exactly that.

Cheers,
Miquèl

Changes in v3:
* Collected a tag.
* As my platform runs on 6.1 currently, I cherry-picked a mainline patch
  changing s/master/host/ in the atmel controller driver and modified the
  series to fit the new naming. I then cherry-picked my three patches and
  verified it compiled correctly against a v6.4-rc1.

Miquel Raynal (3):
  spi: Create a helper to derive adaptive timeouts
  spi: atmel: Prevent false timeouts on long transfers
  spi: sun6i: Use the new helper to derive the xfer timeout value

 drivers/spi/spi-atmel.c | 18 +++++++++++-------
 drivers/spi/spi-sun6i.c |  2 +-
 include/linux/spi/spi.h | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.34.1

