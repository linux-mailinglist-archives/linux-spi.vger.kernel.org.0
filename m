Return-Path: <linux-spi+bounces-10940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B7C26590
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C731A65D3C
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FF326D79;
	Fri, 31 Oct 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jGqvtoEg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045C308F1B
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931698; cv=none; b=ADm7tWB/WG0wZ9l55FTAxCJqP/5Qz3+d5JPJqJJOPt+G8qisVfVAStYaTDPAlvUJeVkX5ibiTihlDE+FjbmyRAy7GHNxe3UQny6kn8FYev8SYjLHsPuA3kYcMCVFVIWf3Eyp7NVgI+L+Rfi2IIk01n8uWzmvpZxcZpg4xfMDc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931698; c=relaxed/simple;
	bh=D83udK3rkUXcu4imHlcUt7YguepdlZ70bccpPaQWIZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olyAe9pQMM4sstdSd4JJLupaQNQMFAdB6ZIh/80FL6vg5v6/+Lm1FMJ9K2rDP6AstyfiYmRpCoEzT3NaPyPvyKh5GgjsTAmytqeJ/sQa5zSKL5fbDqfXkOCKoGhkfsBCFVaiB39SbuYO9SFWgtIsI2HUcjCZHqJeAyPm2SaymqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jGqvtoEg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F1BEEC0E95B;
	Fri, 31 Oct 2025 17:27:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 821FB60704;
	Fri, 31 Oct 2025 17:28:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E31F011818466;
	Fri, 31 Oct 2025 18:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cd1E/3COSsZlzYl0nvZBhxDTb/M09zD1KDjitt7bE84=;
	b=jGqvtoEgGLnT2FvQCgdCkvNmT/ZZIAcSzIe3eAmD/fd49VWzBqmtx1ZAi5yAzMVIqGu+Kt
	MZXAKpC1Aak5V/prgzt8vtmQ+barP3b7XHNvOiYzGiLSqBnaZeHbahS0VBtk09usO596GW
	8Wq/YPez7gHEO/lsb6JpLaqeey7Sq9cuJEPT5Ew9MwvbRss91lXdLeC2M4tkmRRz++6eGu
	wYzF4015/Ur39MQqXqOXpRz0GO20ZrzgZ2sbkYIZ0eO0tk+XaBrnWKMg8O+PrV1N3Jbsia
	+wuyzvp7gue4DN4KO6czR8S002NDd/KVa/uX9NFueknXukxZQ5vBjRqOJ3SCpQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:47 +0100
Subject: [PATCH 03/28] spi: spi-mem: Limit octal DTR constraints to octal
 DTR situations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-3-be42de23ebf1@bootlin.com>
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

In this helper, any operation with a single DTR cycle (like 1S-1S-8D) is
considered requiring a duplicated command opcode. This is wrong as this
constraint only applies to octal DTR operations (8D-8D-8D).

Narrow the application of this constraint to the concerned bus
interface.

Note: none of the possible XD-XD-XD pattern, with X being one of {1, 2,
4} would benefit from this check either as there is only in octal DTR
mode that a single clock edge would be enough to transmit the full
opcode.

Make sure the constraint of expecting two bytes for the command is
applied to the relevant bus interface.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 064b99204d9ac4bc233307609defa4fbbaf4534a..71e3eaf59df97cf6d04e6e674810f12d037f384b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -175,8 +175,19 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
 			return false;
 
-		if (op->cmd.nbytes != 2)
-			return false;
+		/* Extra 8D-8D-8D limitations */
+		if (op->cmd.dtr && op->cmd.buswidth == 8) {
+			if (op->cmd.nbytes != 2)
+				return false;
+
+			if ((op->addr.nbytes % 2) ||
+			    (op->dummy.nbytes % 2) ||
+			    (op->data.nbytes % 2)) {
+				dev_err(&ctlr->dev,
+					"Even byte numbers not allowed in octal DTR operations\n");
+				return false;
+			}
+		}
 	} else {
 		if (op->cmd.nbytes != 1)
 			return false;

-- 
2.51.0


