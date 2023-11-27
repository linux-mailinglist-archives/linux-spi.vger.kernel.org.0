Return-Path: <linux-spi+bounces-44-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A707F9CF9
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 10:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C599A281218
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BBC17986;
	Mon, 27 Nov 2023 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Temh8eAU"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761AF0;
	Mon, 27 Nov 2023 01:58:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10150C0013;
	Mon, 27 Nov 2023 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701079123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B5Sho0rj1OqGHldxHSwjpOtKBXGN/gFmtHdV8vDyx1U=;
	b=Temh8eAUgqp7H2Zv37zsOf7me+IwQdmT5bUFObWSekbbSdjmUq9loQQKowGKfKsQCJXOZf
	JbV4XmW1ZKIeswj9n8YmKc7Lsy4+9eyR5D/xYz8XhOgB8KUURzR0mTLxk/7nvnj5NHlxEs
	4lZ96ouNHrsWHyf1l09vc/Frapby+waR8ESVISMcQmBOC9WZHrRxRfqsvF9xkAfGd1cTQo
	/t9EuguuxVxaIsOrEOODyJGVNH4Ps2Yna/c978NXHpU7DOvyD3iD0QEuQMI68NqeI2u9/x
	sujPXjsZOey81Sl/d7ujjyvf4zRe1sVNSP9edOUpIgmJz4v3fGDPm36a/rl05w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org,
	Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Date: Mon, 27 Nov 2023 10:58:41 +0100
Message-Id: <20231127095842.389631-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

The intended move from wait_for_completion_*() to
wait_for_completion_interruptible_*() was to allow (very) long spi memory
transfers to be stopped upon user request instead of freezing the
machine forever as the timeout value could now be significantly bigger.

However, depending on the user logic, applications can receive many
signals for their own "internal" purpose and have nothing to do with the
requested kernel operations, hence interrupting spi transfers upon any
signal is probably not a wise choice. Instead, let's switch to
wait_for_completion_killable_*() to only catch the "important"
signals. This was likely the intended behavior anyway.

Fixes: e0205d6203c2 ("spi: atmel: Prevent false timeouts on long transfers")
Cc: stable@vger.kernel.org
Reported-by: Ronald Wahl <ronald.wahl@raritan.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Hello Ronald, this is only compile tested, please let me know if that
fixes your use case or if you still suffer from interrupted transfers.
Thanks!
---
 drivers/spi/spi-atmel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 6aa8adbe4170..2e8860865af9 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1336,8 +1336,8 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 		}
 
 		dma_timeout = msecs_to_jiffies(spi_controller_xfer_timeout(host, xfer));
-		ret_timeout = wait_for_completion_interruptible_timeout(&as->xfer_completion,
-									dma_timeout);
+		ret_timeout = wait_for_completion_killable_timeout(&as->xfer_completion,
+								   dma_timeout);
 		if (ret_timeout <= 0) {
 			dev_err(&spi->dev, "spi transfer %s\n",
 				!ret_timeout ? "timeout" : "canceled");
-- 
2.34.1


