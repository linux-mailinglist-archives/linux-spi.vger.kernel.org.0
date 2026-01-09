Return-Path: <linux-spi+bounces-12243-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A28D0B957
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CCD4301AB8A
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F1F366DA2;
	Fri,  9 Jan 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZLAZdgI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE620365A11;
	Fri,  9 Jan 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979105; cv=none; b=DnE116wBsT5hEdU/gI34IV7LDxfFZEfluGLFQCKRhmeFu8IwdSifqAs3KsU6TK1k1r/oC0e3Is4jWPX2C/WZzX6G2A9wjOA5NoD7XDvRXNbFh6tpMDw+KCMCajZdahidO0i1/zApJHXINa2pUfDnV7wyWMEX8oMPUFpTWSC6cyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979105; c=relaxed/simple;
	bh=0sln/3oAuwBPrchoQttcANFqFqWVGEF9tBH4dh5X15o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUWKe80EfvF7vRSJDTL+c2cvewVXQ08xpTW7p0abnwGOWebEWI5rSAR48FfV6huhOk2m+1TH0WBmOy7oThEvvisvfcDdjX7vLTu1zC5yzYjvseNo1x2B4FNRrx5E+W3IQNDiYo/rgzuQLKz1ApujfIbgWKBZsdiUkfIxvtlwzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZLAZdgI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 84F241A2752;
	Fri,  9 Jan 2026 17:18:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C00C606C6;
	Fri,  9 Jan 2026 17:18:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D19C103C89AB;
	Fri,  9 Jan 2026 18:18:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979099; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9G/aUTnLmrJx/EKe3AC5h2XyiwOQM2CjA2RNxNPKj0U=;
	b=kZLAZdgIAwwqf4/dpch+VvSRsdxmzJOwoZw/n74dUBbuRHzqQq73AtLYqXxZE9RWElkG7z
	cuEmfLJs6HB1OxVZEY8Tgt0+XOgyEXW5KYVpWL4f4jlkZhX3NGcjiKzAeb/EUU6s9qK/LZ
	WKF+QYKqvk8puaW2J9zUrTfEQVjLGqL+XVtKlQWaaowwTeb2+RJELxICAvojzDrIrwvYpc
	1TC1MyITJv0iQyQ2i67SJGKf4YJ+mW8L04IckabagghPW3cIkJ0TzY3ynAhkbPc5Q2rk5B
	CPzye2lc21wnp3qd8G1GwwpiJyeiXsyTiFB3p4dnndZ3QA4LepsrzCSwKvQdWQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:17:59 +0100
Subject: [PATCH v2 01/27] spi: spi-mem: Make the DTR command operation
 macro more suitable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-1-1fff6a2ddb80@bootlin.com>
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

In order to introduce DTR support in SPI NAND, a number of macros had to
be created in the spi-mem layer. One of them remained unused at this
point, SPI_MEM_DTR_OP_CMD. Being in the process of introducing octal DTR
support now, experience shows that as-is the macro is not useful. In
order to be really useful in octal DTR mode, the command opcode (one
byte) must always be transmitted on the 8 data lines on both the rising
and falling edge of the clock. Align the macro with the real needs by
duplicating the opcode in the buffer and doubling its size.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 82390712794c..81c9c7e793b6 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -20,10 +20,10 @@
 		.opcode = __opcode,				\
 	}
 
-#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+#define SPI_MEM_DTR_OP_RPT_CMD(__opcode, __buswidth)		\
 	{							\
-		.nbytes = 1,					\
-		.opcode = __opcode,				\
+		.nbytes = 2,					\
+		.opcode = __opcode | __opcode << 8,		\
 		.buswidth = __buswidth,				\
 		.dtr = true,					\
 	}

-- 
2.51.1


