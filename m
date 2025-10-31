Return-Path: <linux-spi+bounces-10944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC16C265A8
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 984713519A4
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444FC34CFCA;
	Fri, 31 Oct 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qPsj2AdS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5634B667
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931703; cv=none; b=tS2mOKh3zQPmI2ZEmm5WBXRf1/+6/WFvWQ3RaE9eW1q7W+cVszC5k6KcgRMUq0pnsSLb/1U9G+KqfynzBhbLX1HpkY3WzHff/lxrpnoqcUmm7odP3QChoSoaJC+q15jhvdg76yNPnH0PEuCOoIXNEVlghsZfVbMLhunux/nN8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931703; c=relaxed/simple;
	bh=IpPFvCzVGIPQ3xyoVo+Bvmwy5JdjUpewmsRAMzScicI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ik/5AIqY39dHLtLb8qzytrM6SJ0FMR+GYdzVDcQ7upA+FZ90AsBw/1GJPIc0DdqnTEgCQulszYuqsIMhNJNsbN2zRv73czmcvWMt8Lr1SUWJBTlnA7KDJIpTjoOdqH45O37Z8saT9fR4fAmvv7Cq9RdmA3OYBWAeC33s4l0B1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qPsj2AdS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3FFEBC0E95A;
	Fri, 31 Oct 2025 17:27:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3C1260704;
	Fri, 31 Oct 2025 17:28:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E3CB11818466;
	Fri, 31 Oct 2025 18:28:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YMq2Oulid+/ZQVRpF4JkTbc5d0mnCd8cN+kKX2PYD7Y=;
	b=qPsj2AdSwefrttBWTwJ1ayqmRCPISo0cpeRtPiZQNG94IkZbwRoSwb56jEVqoTDePSuj/v
	dqx8EmWFclZbh9bkRk2OcjdD+lz96eweN42MuDNrsCQd/de+kbrc+/TeyAezKeHPg0Q6Xy
	PGy23q9AfTRxd9oPCpXyiB21cPRBdpPihzKYAjkgkvut03QlsQ1PwZi9zHUZ+ocJbrAHG8
	xgyevXzS5Qw4oBNf5Z8WlZ7OYOge6f7kv8rBexL59N1xTdkkkSsx8gT+ohadd675AXODwK
	8Iqcaz7E4p8JJdehRIpMuGkGfXFhzPaLWY9pghjLT8YzwWU8rFLcXSuKoxzOyw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:51 +0100
Subject: [PATCH 07/28] mtd: spinand: Use standard return values
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-7-be42de23ebf1@bootlin.com>
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

Replace -ENOTSUPP with -EOPNOTSUPP which is as relevant in this case but
is standard.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9d4e82554dab07b676632155ae94a706cf1177df..e6ff5706a65bdd300ce5945846749afa59b2f12a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1418,28 +1418,28 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		spinand->op_templates.read_cache = op;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.write_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		spinand->op_templates.write_cache = op;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.update_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		spinand->op_templates.update_cache = op;
 
 		return 0;
 	}
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int spinand_detect(struct spinand_device *spinand)

-- 
2.51.0


