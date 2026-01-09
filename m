Return-Path: <linux-spi+bounces-12245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFAD0B95D
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 976873022F2A
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3244366DC0;
	Fri,  9 Jan 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rt6j6ZvB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C03659EF
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979106; cv=none; b=LI/ex216JH/mH4ceq4mYsHCYVpTEgEbYE3ndFVmNNqAYle1yzk7fphErIqsy/xKc19IU/F7FZzNFRq2MIOaVbdXHcqBzwaIhCLofDx4Y69xB5Ot0IwW3y+Gt49531pHIF1WpYKKj5KFdE/WHS45WzUqdbh4rgk5R79WTtHyMmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979106; c=relaxed/simple;
	bh=Vcy/12KBDerD4lsZZ0OCPmONKW4YxSkzB+GIyt5FonY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLuZlzqSwX2oLvcO8MIL49AWrqgvueHOCb3jBs46Wy3ueWG7vRj+BKRzf8Zf1NtSmRGnDEL4GOHuJP/4XiP0cojrUpzrSdolhzqY3iEb7Cq2L6wcSydQU9zzes57AZsXD6gMLmdGUhVZ8QMfRuB0Kkj2r6oaWMvFfjnKW+qw7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rt6j6ZvB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 13C1B4E4202B;
	Fri,  9 Jan 2026 17:18:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DEDC8606C6;
	Fri,  9 Jan 2026 17:18:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31395103C89AF;
	Fri,  9 Jan 2026 18:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979102; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hpWiGp2IJhYFgxmfj56BPtbUVs0Zl/pSRbFJbsG8PAQ=;
	b=rt6j6ZvB+gVvtkjvT5b/qqqXMMtTMJ4no6KRPrg1z7A7g8TY9U3T9os07NoQaiH2IhQm5i
	lPKkvlAjD7ltT/lsLFyAUy3d1F9faa21ajqVuB0rNUr2AfvZjzfRGKu+CUoZqhqSyvcFUi
	ghhPFrH3emnkB39qO6dC2BqStYVXb2GYomhEu1UPQVkzxyAXyCV9KgLlNOhecjsCtoqqNJ
	gFAgodyruiT+Hiyy6lNvj04pXH/hP4SykA2w0Dk6U51N8gj1yawctATkcPIL3kMJQYVdD5
	mtC8yG7L9zEUIIFKPSZ0wmY25+gvFIcolbtpLtsJ4siA7tRGyUSR1ivTjc8JaA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:01 +0100
Subject: [PATCH v2 03/27] spi: spi-mem: Limit octal DTR constraints to
 octal DTR situations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-3-1fff6a2ddb80@bootlin.com>
References: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
In-Reply-To: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
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

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c8b2add2640e..6c7921469b90 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -178,8 +178,19 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
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
2.51.1


