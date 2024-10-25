Return-Path: <linux-spi+bounces-5487-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE449B0990
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E9E1C23298
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C765189B9C;
	Fri, 25 Oct 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cofj1aeV"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512C187872
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872929; cv=none; b=coYx2f4U8vFut92uQowBhy76TevFfm4pDFIWQIg2VyEc84G6y7EsY2gxDULYtJ35l9SUfhbc6zK/LR05FmA/mnQC7Y8KTP/5jpSBXPetrwfCfHpUU2OwA2TvBTsTn7KSPeEnP1mQt1MPJM68KJwaEM5eYszXWxQSNv2DTYBPyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872929; c=relaxed/simple;
	bh=V7iunp8RpYcvXJs9VJ1uDz8o9vFJcFy1WSAnVCN/qLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI367BcBFCtSWPQLt5bhSnN8tPUWydznNz6WEMIId0cCct8v6Qbb2tHqKiGxIWlj6NXB18x3vHDtyPDLHbYV+wy0JtiwqicCDolJy9hg961xhDA3qxsOf0wOMjvfmFgIyno1Fr8U+c8cu5PLjdL2+sT4fNkvnCFXM/nAXmAVsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cofj1aeV; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB94DE000A;
	Fri, 25 Oct 2024 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pByiemz6sGQ1dAc0XGPZWpgyfqvuQv9orpYDTvxc394=;
	b=Cofj1aeV4v4w5g1P2JbjfXuAhzb/D/hZUV5QKSjmsliVXNsX0Liy+oxfIcrf4iww7NnfnX
	f9m2d32g4G1RY0unlEGPoKq6SwXledRpqAERsA6BcF93QdxPjp6opHal0BNXmSuIQz/OFs
	+N9VZ9xwWEf57iUDdmVBoEMGgFUoLf+1FkTfFrWm0Xt4E8nBTuum1Rj21C9O1JBfgimtsa
	PFG5LZ0jl0P5FTS56jjxm6J/6d0NKt8uZUPLygt/r/K4acXagLTneqLmmnPWD3ymnyMeCI
	aaYBSdXbTtBRVDvOiZbjl7LSdfaVUWHysXp33Zt9hftyRkcqMIpzoPQm8tqnBw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 20/24] spi: spi-mem: Reorder SPI_MEM_OP_CMD internals
Date: Fri, 25 Oct 2024 18:14:57 +0200
Message-ID: <20241025161501.485684-21-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025161501.485684-1-miquel.raynal@bootlin.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Follow the order used by all the other similar macros:
- nbytes
- value/buffer
- buswidth
- other fields

There is no functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 379c048b2eb4..318ea7b193cc 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -15,9 +15,9 @@
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
-		.buswidth = __buswidth,				\
-		.opcode = __opcode,				\
 		.nbytes = 1,					\
+		.opcode = __opcode,				\
+		.buswidth = __buswidth,				\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
-- 
2.43.0


