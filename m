Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C3C3D7A82
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 18:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhG0QGF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhG0QEr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Jul 2021 12:04:47 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076F8C061757
        for <linux-spi@vger.kernel.org>; Tue, 27 Jul 2021 09:04:47 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3F6AA801D9;
        Tue, 27 Jul 2021 18:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1627401885;
        bh=jOFWwdY796uysbhC1MZk8C4uSydSpazEs5mWg/v6yqA=;
        h=From:To:Cc:Subject:Date:From;
        b=bSvgaiU8JpTrgwaMU3MGZt5NGoT+eOOVSPtCozY4BSCahmgDsjPT5gT+NJExJbRf1
         dXCS4RqNFMao31R95hKk4bVcL0tMawy4or6cQpcKoaknPkhXTjfPi+SO13aS2MkDt7
         CVwBrl+62/mn9Z61pvhmnOObspGSlaMzvTlZF4qgXSGDyYEI0rzTohCO0lrw+qJ599
         ui9G5znObOpAhjLfsZSZdnXqvWJs1n4/IPSrnTiQayd6d/H/s5OaI068fkI2fOCoGL
         sWJp06fv/5CMGcefbWXEJPJ9xeHM/zu/53A3AU+wiDwQx9r2RZ625ISfZOuYL047mK
         IAMG4sLHIvFXA==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>
Subject: [PATCH V2] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Date:   Tue, 27 Jul 2021 18:04:28 +0200
Message-Id: <20210727160428.7673-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
the min_speed_hz must be above 200000 (i.e. 200001 rounds down to 9, so
the condition triggers). Update the comment. No functional change.

Fixes: 6fd8b8503a0dc ("spi: spi-imx: Fix out-of-order CS/SCLK operation at low speeds")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>
---
V2: It is not 100 kHz, 181 kHz, 222 kHz, it is 200 kHz. Make it so.
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 75a82d6cac785..e3231b501ae06 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -598,7 +598,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	}
 
 	delay = (2 * 1000000) / min_speed_hz;
-	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
+	if (likely(delay < 10))	/* SCLK is faster than 200 kHz */
 		udelay(delay);
 	else			/* SCLK is _very_ slow */
 		usleep_range(delay, delay + 10);
-- 
2.30.2

