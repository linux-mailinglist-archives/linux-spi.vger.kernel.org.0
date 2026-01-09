Return-Path: <linux-spi+bounces-12262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7301FD0BA3E
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A4A312ED19
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03336C0B1;
	Fri,  9 Jan 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VsVf09XI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3636B064
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979127; cv=none; b=sYCQHchqeW4LfmNOzOn7tp9k/HFeAUmhjcvGbxZvQDU3Q0sPxCQRU2hgb4rBqwNLPSNhu335Xc0e0k04as1OwtGKt1yOylOCy7L5MnjCQGk1LFh3htv4VN4eZRN9mCBoAc7QXMHijXG6wRWZdmXgEDp25lRamLsK5JWS1Zes/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979127; c=relaxed/simple;
	bh=s5DqMiIYKdUfxWUAhN4RGGYA4fqft2YfnmGn93p+UVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaqejOnWAIRZS5X93mKrx76EVBgAX91PsUnafkxw0y6yr0HSNAcDrdi34Ge7kRwhqn+t7RkVTwGfX0np7e/dPKvJpwoN2CVnqnTiDa9eYjD6XMxksCmE+Ci0tzmoNgMECgmMgff1d1Bql/ohnC62xYSATzNo7I6KhzFPDdtqJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VsVf09XI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 628BE4E42029;
	Fri,  9 Jan 2026 17:18:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 38D1E606C6;
	Fri,  9 Jan 2026 17:18:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99992103C89BE;
	Fri,  9 Jan 2026 18:18:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MJtnWz64Xe2CigN2SsqL9dz4pY2jKcHax/iVWEjwuVE=;
	b=VsVf09XIYY2kdVeC7p8aVeJhhXqg3JjokyNXGBN/qHn+C8TZq/tt9kVF8GKjfzrTja2L49
	ObuMZwLg6icAY8fW1jwM8TCNfKPkvcWs4PqikhCyUD+7fqYCE/mjiTLzwBfYEQGICfoQb7
	LHVUj0tVRQ0O9Y3pZypA10d2LigK45IrsM87PfSQj9Lr2H/chB6Ct017Vm/mDMM/tHHAzI
	OmF7aL5DFTrSBB1621r+FS+UtY4TCk869vywmaiZB/zZc629UUxlIn1LxHE21ThmJa4SYC
	M0XEXdCHeuIgfp7NjC8xu/6zHpYF2N9bWBYd0E8O8oe/MY+vEVJGz2kvP619Dw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:18 +0100
Subject: [PATCH v2 20/27] mtd: spinand: winbond: Configure the IO mode
 after the dummy cycles
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-20-1fff6a2ddb80@bootlin.com>
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

When we will change the bus interface, the action that actually performs
the transition is the IO mode register write. This means after the IO
mode register write, we should use the new bus interface. But the
->configure_chip() hook itself is not responsible of making this change
official, it is the caller that must act according to the return value.

Reorganize this helper to first configure the dummy cycles before
possibly switching to another bus interface.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index b16963637683..1d79a8ae7920 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -381,21 +381,6 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
 
 	op = spinand->op_templates->read_cache;
 
-	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
-	dtr = (op->cmd.dtr || op->addr.dtr || op->data.dtr);
-	if (single && !dtr)
-		io_mode = W35N01JW_VCR_IO_MODE_SINGLE_SDR;
-	else if (!single && !dtr)
-		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_SDR;
-	else if (!single && dtr)
-		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR;
-	else
-		return -EINVAL;
-
-	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE_REG, io_mode);
-	if (ret)
-		return ret;
-
 	dummy_cycles = ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
 	switch (dummy_cycles) {
 	case 8:
@@ -413,6 +398,21 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
+	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
+	dtr = (op->cmd.dtr && op->addr.dtr && op->data.dtr);
+	if (single && !dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_SINGLE_SDR;
+	else if (!single && !dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_SDR;
+	else if (!single && dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR;
+	else
+		return -EINVAL;
+
+	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE_REG, io_mode);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 

-- 
2.51.1


