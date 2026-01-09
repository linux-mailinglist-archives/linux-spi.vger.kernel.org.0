Return-Path: <linux-spi+bounces-12265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF65D0BA11
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B5830DC8D7
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37A36C0D9;
	Fri,  9 Jan 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BBiadMXg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8E36AB79;
	Fri,  9 Jan 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979132; cv=none; b=kLI35GFZucT2SB4sm9q6bvvcaPmfyiHCmGGw4V6pr/bj3znBog4s4IyP1vW4zqjs7NtYMxdh4/gOGjGwEaQFF/5bxKxJOeuaImn/in33WbBwGYpkDoOpQvUFjM4u0/RGniGzoAu/f6GB7I29S4sPPDPiSR1XzBNKiQ5DISds3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979132; c=relaxed/simple;
	bh=WrdVrZoKVo7gsw1pCH6PG6OXJObCz4MraKoZETSmsB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eKLDEefXgaM9kBmc7/EAutb4DEd+VzefEMouMQeXdMavB5c1Zr+qmHMTsNzAKbnX5JorMk/jXtOscHdLbW5S/wlStVBN3sGkrVERLXLD5/f7kekF1OzTJDVIEi8pU3JUNV+B3UkTXuG/94J3OLdfKg47I7pWAb/oir1huvDAsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BBiadMXg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E7E77C1F6E5;
	Fri,  9 Jan 2026 17:18:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BC3C606C6;
	Fri,  9 Jan 2026 17:18:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BEDC103C89B1;
	Fri,  9 Jan 2026 18:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TvT8KJbAI4+CbX9ktmIBaXAw+sBQzrpvbOewgKo4BbY=;
	b=BBiadMXgp6XHU8+FJoxBFnflrpev8GygXL88DIWVtos0GJ1ahXR6wjXBRtB8KY81GcfEDD
	bQpszt8t7P06j2ql7IHAauo4wdTboUW8rQWyJKyGu5Kh9AGTpU5foLBlLlNydaJns3L6aP
	MXihlzvvN+v5LXlOhA9skPEikY5Mtd2oWXPPNzVfWUXw2jGTyz142C032OxWXshpoSZAhM
	D0uFefBJCi3j+CZW812mVmr+BCYSktX5nzG3fOh5g40BpVJG1JymH7uoHdB+2QxxO+j4ew
	7RIWpo8W6iHgFpBVX/P43Ivn5lQgGkCq58p/LAZ/81KFzm/UlUeX6K3eASwxXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 09 Jan 2026 18:18:21 +0100
Subject: [PATCH v2 23/27] mtd: spinand: Propagate the bus interface across
 core helpers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-23-1fff6a2ddb80@bootlin.com>
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

For now all drivers provide SSDR variants only. When we add support for
ODTR modes, there will be a need to differentiate the type of variant we
target as well as the need to check if we support one or the other type
of operations.

Pass this parameter to lower level helpers, which for now is unused, in
order to simplify the patch introducing ODTR support.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a5166b49020c..019594182c60 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1410,7 +1410,8 @@ static void spinand_init_ssdr_templates(struct spinand_device *spinand)
 }
 
 static int spinand_support_vendor_ops(struct spinand_device *spinand,
-				      const struct spinand_info *info)
+				      const struct spinand_info *info,
+				      enum spinand_bus_interface iface)
 {
 	int i;
 
@@ -1431,7 +1432,7 @@ static int spinand_support_vendor_ops(struct spinand_device *spinand,
 }
 
 static const struct spi_mem_op *
-spinand_select_op_variant(struct spinand_device *spinand,
+spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_interface iface,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -1524,28 +1525,28 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.read_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
 		spinand->ssdr_op_templates.read_cache = op;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.write_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
 		spinand->ssdr_op_templates.write_cache = op;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.update_cache);
 		if (!op)
 			return -EOPNOTSUPP;
 
 		spinand->ssdr_op_templates.update_cache = op;
 
-		ret = spinand_support_vendor_ops(spinand, info);
+		ret = spinand_support_vendor_ops(spinand, info, SSDR);
 		if (ret)
 			return ret;
 

-- 
2.51.1


