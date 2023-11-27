Return-Path: <linux-spi+bounces-43-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4737F9CFB
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 10:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CFB20D0D
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88D17982;
	Mon, 27 Nov 2023 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dS1ef+Pf"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F63101
	for <linux-spi@vger.kernel.org>; Mon, 27 Nov 2023 01:58:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD110C0015;
	Mon, 27 Nov 2023 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701079124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHGKlgKxT76iC8mipDwr85DcuoaL+X6WKArNXlsTKSA=;
	b=dS1ef+Pft6nEAqSbKigFpFnEFxXIV6hTvZs3MwDGFX0g8Op4UXKp4GAaQu6RULQit/u86N
	XGXWc6xNbp/ObJNYS/1b8Q8N7ZkhRH+jiGQf3+1zYNJ7dc+wXvnIeZ4ztBhmllmU8ySbfB
	7qjWX5aCLBtQpCWfS8EQQu+tnOZmvo8rp/Gim4gmgWR4jK+HUjdOjgLYUHVmtJaX/tuRkP
	YzTfHqpbi4IHPGCABZCcj3P7d4pM7TqlrBK4cW1dPVDPaGGSvKICcMizEPwYTd+l4NVHfw
	/Jb3vt0R5dzJpq/OumM6L8uhEd6hNkBNW/Ojr80VTDAIF8rPTOZ7r+vklhvFzw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH 2/2] spi: atmel: Drop unused defines
Date: Mon, 27 Nov 2023 10:58:42 +0100
Message-Id: <20231127095842.389631-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127095842.389631-1-miquel.raynal@bootlin.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

These defines are leftovers from previous versions of the blamed commit,
they are simply unused so drop them.

Fixes: e0205d6203c2 ("spi: atmel: Prevent false timeouts on long transfers")
Reported-by: Ronald Wahl <ronald.wahl@raritan.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-atmel.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 2e8860865af9..0197c25f5029 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -233,9 +233,6 @@
  */
 #define DMA_MIN_BYTES	16
 
-#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
-#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4))
-
 #define AUTOSUSPEND_TIMEOUT	2000
 
 struct atmel_spi_caps {
-- 
2.34.1


