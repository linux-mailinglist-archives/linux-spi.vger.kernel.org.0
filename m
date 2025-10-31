Return-Path: <linux-spi+bounces-10958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF49C26645
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF4404F770F
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8E3559D5;
	Fri, 31 Oct 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lqri9Bfp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8761354AF6
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931723; cv=none; b=L8eDNFL5kq8jy6W9+PdVUF9KaL9djI3S9M88fiuH4EQpUvaGavc0XBufQs5G95m8YjCxV01y5NlBkDJID6OIiTOd1pO4fYX7MfE7Elj8M6Ggnn+HAG3iW8EKHPsufz+tfkVzbVt8Z7W65QWAyToR1YBZ9TOrT3VORQ4QEMG37a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931723; c=relaxed/simple;
	bh=R0YmQeghSKw5PoxKOG0myWRRdHkSep5Ke0+SMyuX6Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YhJKkPV4j9MRbct8hDIPPOZCYQuTiPNLDJzA6NIBWTdMKD3OtafoglyTjJJP9qdZWaKmbPG1o2GLO2OE6ZCiD+WcWSaFN/xdFgYRhR6BvJ2OQ1km0OGKoq2EaekVmS+ERHgXEHNKO+cBtFPhB7OOsk+9CWkAraZMF4TgvHzkHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lqri9Bfp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 31C194E41442
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 08ED260704;
	Fri, 31 Oct 2025 17:28:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34D801181800A;
	Fri, 31 Oct 2025 18:28:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ex2SptpuBK+4RMrw2hKUubiMGuwo3pULUp58RhXWy8w=;
	b=Lqri9Bfp6SGJi9VpPmHo/57DgqJdOMKyMulKxVXHIi3QC4AAF79B6F+8ZLKit4C8ASo7UO
	K1n8kNY/vTq2dvQjXPSHjfVGANKoIHExxrMZ6qlLB2sJE8pjMiAFgIGs8ETRUxPVdfEAcy
	ql3ge0KV8xxAE+YpANVrKMS4b0D/ufEWgHk9XR3mArK78+2j210ME00om8M3PTL9lVkg3M
	3gGRPJitvJpAmjRlajBIVaVMRSp1zOWz+odGXPbCr4ws8J4uZOH4/b8/yxbasn9gQLZHdS
	oNYFsTk4PSMxPiF/FuiCGpPyGn8+nYI1taPrBekYVqcI+TaYGsWkPAWkvjpkJQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:05 +0100
Subject: [PATCH 21/28] mtd: spinand: winbond: Configure the IO mode after
 the dummy cycles
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-21-be42de23ebf1@bootlin.com>
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
index b169636376835157c64bce17a4f32549e1c1eb9f..1d79a8ae79206af7d823018c4603b3bd36a0dd88 100644
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
2.51.0


