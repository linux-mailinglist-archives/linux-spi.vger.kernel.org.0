Return-Path: <linux-spi+bounces-145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79041804C6A
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 09:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F06281716
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1C3C484;
	Tue,  5 Dec 2023 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QK0mMsEz"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866CB18D;
	Tue,  5 Dec 2023 00:31:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39A1E6000D;
	Tue,  5 Dec 2023 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701765066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FYWMV4zrEtZnbrExDx0nqD3HDOe9zXAaFMqIEbZCOCo=;
	b=QK0mMsEzWUW1JKqu6XipwK9zZcjEkQ0tWwgw5EsAf/Ggs4sBg3pRztf1EuY0+cA62EQmVv
	ZX+kjNuD7X8WBUOXcfCG3Ovid8QnaCISpkLjkZEHL5FS9Hdb+cZXhchGtR2Nggj/61GaFO
	ZV682MPmuNjiaE+7hpucQczgX+Ij40u/eqNtal4XAOgy8ouW81tcMLaIN1wRmPAFmcRHQw
	12c26I9B8hcV9WoM9wTcnqKYAy2dN3QoXO2t8tsuksl+d2anSkkZSW6rkFGOASn49lF/9Y
	AVatn5K3Fu9GVdzmKwHhyAZ3SBE6EuPm8hhzA9Q3280bn3vFeHtguQOk9x3Rxg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: atmel: Prevent spi transfers from being killed
Date: Tue,  5 Dec 2023 09:31:02 +0100
Message-Id: <20231205083102.16946-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Upstream commit e0205d6203c2 ("spi: atmel: Prevent false timeouts on
long transfers") has tried to mitigate the problem of getting spi
transfers canceled because they were lasting too long. On slow buses,
transfers in the MiB range can take more than one second and thus a
calculation was added to progressively increment the timeout value. In
order to not be too problematic from a user point of view (waiting dozen
of seconds or even minutes), the wait call was turned interruptible.

Turning the wait interruptible was a mistake as what we really wanted to
do was to be able to kill a transfer. Any signal interrupting our
transfer would not be suitable at all so a second attempt was made at
turning the wait killable instead.

Link: https://lore.kernel.org/linux-spi/20231127095842.389631-1-miquel.raynal@bootlin.com/

All being well, it was reported that JFFS2 was showing a splat when
interrupting a transfer. After some more debate about whether JFFS2
should be fixed and how, it was also pointed out that the whole
consistency of the filesystem in case of parallel I/O would be
compromised. Changing JFFS2 behavior would in theory be possible but
nobody has the energy and time and knowledge to do this now, so better
prevent spi transfers to be interrupted by the user.

Partially revert the blamed commit to no longer use the interruptible
nor the killable variant of wait_for_completion().

Fixes: e0205d6203c2 ("spi: atmel: Prevent false timeouts on long transfers")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-atmel.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0197c25f5029..54277de30161 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1333,12 +1333,10 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 		}
 
 		dma_timeout = msecs_to_jiffies(spi_controller_xfer_timeout(host, xfer));
-		ret_timeout = wait_for_completion_killable_timeout(&as->xfer_completion,
-								   dma_timeout);
-		if (ret_timeout <= 0) {
-			dev_err(&spi->dev, "spi transfer %s\n",
-				!ret_timeout ? "timeout" : "canceled");
-			as->done_status = ret_timeout < 0 ? ret_timeout : -EIO;
+		ret_timeout = wait_for_completion_timeout(&as->xfer_completion, dma_timeout);
+		if (!ret_timeout) {
+			dev_err(&spi->dev, "spi transfer timeout\n");
+			as->done_status = -EIO;
 		}
 
 		if (as->done_status)
-- 
2.34.1


