Return-Path: <linux-spi+bounces-10956-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A5C265E1
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74FE6351D56
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7823546F1;
	Fri, 31 Oct 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gk/w51kC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC624350A3D;
	Fri, 31 Oct 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931719; cv=none; b=I5jSvvJApBD2AwWm7/KueKZ3k+IcqRWYy2QI2KpmyJT0YVsHv+WaY6BzGknNlGvsFgruC8BJa3vODLtOofp2L51WEXR6XK57SIbsWzgjiidQcJv5C3EIs3Bqpu36gJEoojD3V+T+gI6CzAZSPTem57lw3zR7FAl6t034ERllRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931719; c=relaxed/simple;
	bh=AHYs3uNkFaDan+ksySMGFisaFfq4M/PnZimfFCU0+9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zv4bN4/TjRW0FlkhD5hMVLvIonprS3o8vaaeeWGMuBET6UmMLnODo/bf43AgfFZ2UNXrHlPJujLZCtxvKOT+O1JrErXkrXIOemt8MDx1IxBB1qCCa1PXm/OZmaLfNn/V4d/+0P3XlI3yQOEGUs3Q8M14Y4yEKbNgweYwrFuumgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gk/w51kC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8C8D11A17C3;
	Fri, 31 Oct 2025 17:28:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64BCE60704;
	Fri, 31 Oct 2025 17:28:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 040A911818007;
	Fri, 31 Oct 2025 18:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931715; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5pi4CcvcO27jDmf/e7y4SHnPB/Y88k3Vae3Xm2yNuow=;
	b=Gk/w51kCU/8d4KkH+9PASySJzs9qCVlS7IgkATDswIySEf3g5XXTHBoIm3aAPcd+KhFtSU
	n3mJNRowcOMb58j+hXlbBDah4ACTL7v80ILDeN8NZkTHbjMHnlep3h3m1HQRRAIGDRNBxT
	cbzYcNgqTXu0kGbQ7cSiGv5xCZdittHtcOwnSyBEz6QnbaGJQijElzAIy/QwEGqx7kKtBy
	B454EXMpQabzAiSQMe9ZJHK4XP6KGXGjOT4saGINarKf/oNYFwunUhA3KEbHk5G6SV5IoH
	Ea8U76zlUZR/CYl4UrLL3PpgFA2+93IfiJAw13nYvBxwN843pT7cTj0qDF8fZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:03 +0100
Subject: [PATCH 19/28] mtd: spinand: winbond: Fix style
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-19-be42de23ebf1@bootlin.com>
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

Add a missing new line in the middle of the driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 1c13dba08369c48ca26381c634abcea4e7360f30..7eade2251f7b5b2a96c0a7528ca6d64ba6d8233e 100644
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
2.51.0


