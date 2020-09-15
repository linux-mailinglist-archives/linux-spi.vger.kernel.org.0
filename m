Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D126B82B
	for <lists+linux-spi@lfdr.de>; Wed, 16 Sep 2020 02:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgIPAhi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Sep 2020 20:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIONXw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Sep 2020 09:23:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C09C061A10
        for <linux-spi@vger.kernel.org>; Tue, 15 Sep 2020 06:23:22 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIAvT-0007Yn-Oe; Tue, 15 Sep 2020 15:23:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] spi: bcm2835: mark polling_limit_us as static
Date:   Tue, 15 Sep 2020 15:23:11 +0200
Message-Id: <20200915132311.1112865-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
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

This patch marks the global variable "polling_limit_us" as static.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c45d76c848c8..41986ac0fbfb 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -75,7 +75,7 @@
 #define DRV_NAME	"spi-bcm2835"
 
 /* define polling limits */
-unsigned int polling_limit_us = 30;
+static unsigned int polling_limit_us = 30;
 module_param(polling_limit_us, uint, 0664);
 MODULE_PARM_DESC(polling_limit_us,
 		 "time in us to run a transfer in polling mode\n");
-- 
2.28.0

