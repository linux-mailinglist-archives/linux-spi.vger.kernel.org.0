Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787393BE822
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 14:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGGMoL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhGGMoJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 08:44:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C20FC061760
        for <linux-spi@vger.kernel.org>; Wed,  7 Jul 2021 05:41:28 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m16re-00024g-Mi; Wed, 07 Jul 2021 14:41:18 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m16rd-0005Dz-0i; Wed, 07 Jul 2021 14:41:17 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        kernel test robot <lkp@intel.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v1] Input: ads7846: ads7846_get_value - fix unaligned pointer value warning
Date:   Wed,  7 Jul 2021 14:41:15 +0200
Message-Id: <20210707124115.20028-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix warning reported by the kernel test robot:
drivers/input/touchscreen/ads7846.c:705:24: warning: taking address
of packed member 'data' of class or structure 'ads7846_buf' may result
in an unaligned pointer value [-Waddress-of-packed-member]

Fixes: 6965eece2a89 ("Input: ads7846 - convert to one message")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index adb4c2230c31..1987dedac94f 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -702,7 +702,7 @@ static int ads7846_get_value(struct ads7846_buf *buf)
 {
 	int value;
 
-	value = be16_to_cpup(&buf->data);
+	value = get_unaligned_be16(&buf->data);
 
 	/* enforce ADC output is 12 bits width */
 	return (value >> 3) & 0xfff;
-- 
2.30.2

