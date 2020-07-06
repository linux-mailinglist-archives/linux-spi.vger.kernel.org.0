Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2321598F
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgGFOev (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgGFOev (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 10:34:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BCBC061755
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 07:34:51 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsSCl-0005DP-2E; Mon, 06 Jul 2020 16:34:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 03/10] spi: spi-sun6i: sun6i_spi_transfer_one(): remove useless goto
Date:   Mon,  6 Jul 2020 16:34:36 +0200
Message-Id: <20200706143443.9855-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706143443.9855-1-mkl@pengutronix.de>
References: <20200706143443.9855-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch removes an useless goto at the end of
sun6i_spi_transfer_one().

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 64b4d8077010..955be8921c45 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -335,10 +335,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
 			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
-		goto out;
 	}
 
-out:
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
 
 	return ret;
-- 
2.27.0

