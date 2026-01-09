Return-Path: <linux-spi+bounces-12260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E9D0BA05
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E29C306CCC4
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6036BCC3;
	Fri,  9 Jan 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zMOUPjUA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE32366DC0
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979125; cv=none; b=O1oQcTiXoZgqvwwEacmOxtex+J2/iYSzhHGatB5exxszYy1uNq2vsciAkSlcEtYCNCGPyNgRmPRfyjKWZI9LRx8MsdcXofnUwKjzZvgN9YG8QN5wa5qV3R+tCgSf1O61/dfZzITBtPMdrB9A5Nfi0EhymZ2WTvv0UJpBqXtD/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979125; c=relaxed/simple;
	bh=5BVkDdhPjQnDwGQu6wDXQeEYwIQ8QpywOZbs/XLaB/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ceExRfRSPnfFlYKU1eNewtRgajWYyaUINqCV1R2sKoOrfHd/peF9RsQu6iCeFcoSUDyOVB2zf5hUZ9qCctZMq8KYyIiOAoL190GaYIE+7XChdGRHtUQFBsROz+N1Ore18C2o3lCmUf2n4Ru89Oxh3o+abe8HQ3hCeti4G1LfBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zMOUPjUA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E5CA24E42027;
	Fri,  9 Jan 2026 17:18:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7DBB606C6;
	Fri,  9 Jan 2026 17:18:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30F84103C89BA;
	Fri,  9 Jan 2026 18:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=W6+rvBQGeoJcUuTU/Yf2GkJyCdo7KGLjvhpSVmkvjVc=;
	b=zMOUPjUAOqspSfsNt505s/8CA2O3cgcgg8yJCBsN+gMIijYLK6nlXFTeUmqT3tq1D9Wh6A
	BhfsXxv6b8HY5BBvdrUTKIIZ+auAQ0KLBLns82N4viG+TPr3cfVgIlS66v6U6b/SQoETgv
	E91jKZnLJZSxx06pWa+IspmvDc6U8GzKa6PJIdG21vI6K4LtR0hf1X3DcLqnQxxV6ogv6Y
	NfNj91UfwCAayJnH+iASo0wasO8/XiI+DG6BRHmLuRm35hvdea5CpuKxdF+a6wGA0YTE9I
	A2MaLXI2gbxl17zh+xOMJdJMQqYWypR+alewZYZhV6sbdv4V/5+svwg9Tm4GSA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:16 +0100
Subject: [PATCH v2 18/27] mtd: spinand: winbond: Fix style
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-18-1fff6a2ddb80@bootlin.com>
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

Add a missing new line in the middle of the driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 1c13dba08369..7eade2251f7b 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -408,6 +408,7 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
 	default:
 		return -EINVAL;
 	}
+
 	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_DUMMY_CLOCK_REG, dummy_cycles);
 	if (ret)
 		return ret;

-- 
2.51.1


