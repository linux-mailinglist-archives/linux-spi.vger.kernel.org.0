Return-Path: <linux-spi+bounces-12387-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4E4D239BE
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C83C7307F907
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB535F8DF;
	Thu, 15 Jan 2026 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cJiHUmex"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F735F8A2
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469148; cv=none; b=Ls+Oa+0XmuVYhpY4yfx/qkkyGpwJXCcCXm3ZI2LajkyzcQ6MnmAkRhtc8OBz7WVzwypUljFaNllEG/0RVuki5/4/s60ypglGWmpjJRqVeBwOjQxtd91LczUGPhaySjuyUa7jTYyJoaAbDCsFzrY48UAwF8zuev/u5sgD7V75YVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469148; c=relaxed/simple;
	bh=igVog/TuQlFhP2II37PWCpQHbGnK/zT5ZUv8hPXJn2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHoVliTts/wH5xPc5J1i7aev7Mr5Y7GBQXbBls3xL55LSrfg2AYSdY0tqXNenp1xNqsq6Ej3cLLAs3H0QIYYhlQk1Zd6GE1ZzDR3s4BPnrUxyAZQFbrEJz8o2aB5Kpkj37POK4XwssArlUuB68u6lny/Y7WiKxcDHkvCdc2LDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cJiHUmex; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2B9FD4E420FD;
	Thu, 15 Jan 2026 09:25:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01301606B6;
	Thu, 15 Jan 2026 09:25:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29FBE10B68454;
	Thu, 15 Jan 2026 10:25:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469143; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0c7taA1Mf9rP/X5UWyC/94bk5u6l6JsrkY0WDU5uFtU=;
	b=cJiHUmexPQw4YbPrHTSm/5gJ5v9ZY6S2CHXXJuAkw5R3QfXpheYmStQ3zQaS1VN4rHTYHG
	NryXsHr1pX5cOpnOUKnxgqpBAlTtvFlPHCWo3s3HH/C4pi0pco8Rar4j7M3WaKRFyqnTow
	iPsVuU9J2MmAau5zBkCNh4v1+cpk2UM2NeQPgAKEbnreAi50uIzHp2KA54CWKsnzxgCqqT
	Z60p/S3G9R2ia9n3p2/3uBDm9pk5hPRolbQJFPIsuC7uW2MAD8jRwafZZk1j5+aascC7Ef
	vDzJkAVlJgijLoHz9C+2iVILptMDRD42vXke8KjfAGnpx3ERXibrQ3dlqo9nUw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:24:57 +0100
Subject: [PATCH v2 06/13] spi: cadence-qspi: Make sure we filter out
 unsupported ops
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-6-7e6a06e1e17b@bootlin.com>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The Cadence driver does not support anything else than repeating the
command opcode twice while in octal DTR mode. Make this clear by
checking for this in the ->supports_op() hook.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 06f6c5979229..fc9f6e8dd549 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1531,6 +1531,10 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 			return false;
 		if (op->data.nbytes && op->data.buswidth != 8)
 			return false;
+
+		/* A single opcode is supported, it will be repeated */
+		if ((op->cmd.opcode >> 8) != (op->cmd.opcode & 0xFF))
+			return false;
 	} else if (!all_false) {
 		/* Mixed DTR modes are not supported. */
 		return false;

-- 
2.51.1


