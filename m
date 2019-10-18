Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D903DC8D8
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbfJRPfM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 11:35:12 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50419 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJRPfM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 11:35:12 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1CD74200005;
        Fri, 18 Oct 2019 15:35:10 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mans Rullgard <mans@mansr.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] spi: atmel: fix handling of cs_change set on non-last xfer
Date:   Fri, 18 Oct 2019 17:35:04 +0200
Message-Id: <20191018153504.4249-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

The driver does the wrong thing when cs_change is set on a non-last
xfer in a message.  When cs_change is set, the driver deactivates the
CS and leaves it off until a later xfer again has cs_change set whereas
it should be briefly toggling CS off and on again.

This patch brings the behaviour of the driver back in line with the
documentation and common sense.  The delay of 10 us is the same as is
used by the default spi_transfer_one_message() function in spi.c.
[gregory: rebased on for-5.5 from spi tree]
Fixes: 8090d6d1a415 ("spi: atmel: Refactor spi-atmel to use SPI framework queue")
Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Hello,

This patch was first submitted 2 years[1] but was never applied while it
has received the acked-by from Nicolas, and I don't see any review
against it on the mailing list. So I resend it now.

Thanks,

Gregory

[1]: https://lkml.org/lkml/2016/1/17/31

 drivers/spi/spi-atmel.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d88e2aa64839..9e84a93083bc 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -277,7 +277,6 @@ struct atmel_spi {
 	bool			use_pdc;
 
 	bool			keep_cs;
-	bool			cs_active;
 
 	u32			fifo_size;
 	u8			native_cs_free;
@@ -1416,11 +1415,9 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 				 &msg->transfers)) {
 			as->keep_cs = true;
 		} else {
-			as->cs_active = !as->cs_active;
-			if (as->cs_active)
-				cs_activate(as, msg->spi);
-			else
-				cs_deactivate(as, msg->spi);
+			cs_deactivate(as, msg->spi);
+			udelay(10);
+			cs_activate(as, msg->spi);
 		}
 	}
 
@@ -1443,7 +1440,6 @@ static int atmel_spi_transfer_one_message(struct spi_master *master,
 	atmel_spi_lock(as);
 	cs_activate(as, spi);
 
-	as->cs_active = true;
 	as->keep_cs = false;
 
 	msg->status = 0;
-- 
2.23.0

