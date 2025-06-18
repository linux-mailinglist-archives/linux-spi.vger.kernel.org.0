Return-Path: <linux-spi+bounces-8634-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE615ADEBBE
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148D83B7727
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FC2E889D;
	Wed, 18 Jun 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e4ShVLLh"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48C2E8DF3;
	Wed, 18 Jun 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248941; cv=none; b=Q9an2jXqymOfLoPA41qiLi7gCYN1aWghnU7xQ+GdliBuJM5XWYY45/Aa2/bmxp07bvb0arv29O6FCoDm6P1bVc+Sy25eGOW4dFU8p+vUCVvVMNDLM0kkxs2G5f8g6pWETEg6V6wjZz60Ak8HFLIplchQXWKt9qJhGOqXpYqWMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248941; c=relaxed/simple;
	bh=okWc/BfI0G5u5XP1cLJcr7F01+dpQ9wEY+YYL2Hki6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7LvNAHP/bOyTwLNML1vRB538kthsNkN9fOjPlIOtVn4TThbyh9xndSor3q1tPg2QtEhDIjhqhsH/hh7Mm3qMTMo59FNxqP2nGIIWHomQR2ZBuPam8H2wI6CSrms1oLkU+KO+vRcsJNLTCABFhAj4k1y2Zpou+8pShdstAGH/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e4ShVLLh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6EC843858;
	Wed, 18 Jun 2025 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750248937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6qXVseOPPuJ5E0CAH3U5o7t96lRH1dBWVZmLZ3LD0Y=;
	b=e4ShVLLheA+3eQsj1pu9FXUneKRHpSXBeZ5oAVfS7gbfSQtf+/jZkmgl2uvbkzCwy8npyi
	fV/sUpMRCwPZEeAscsCc3OstMGw64Qb2MvtP8861XnaINA9Jf+83sIZLqvn3331Bw8QZCi
	gYOgZ/gyzOUgjKiWeW9tyIKubZA2Do8eDtamT1VpyP2m18bMN5ONhDCC2cYd4+z4W1p31n
	DoyH6DTy8uuPT6bWvQZrHphxjTVsYtXiGt2ZwbhTdDj+Igm1kXMoj/DWCJUXFPJECHSHlh
	MXqvdVNEErMh6UsaJpOodESBgseDXS5mSL9W51lyVmcBjCGx9Dcyo+YDXvIZ5w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Jun 2025 14:14:20 +0200
Subject: [PATCH 3/8] mtd: spinand: Fix macro alignment
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-3-513202126013@bootlin.com>
References: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
In-Reply-To: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yogesh S <yogeshs@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhgvghshhhssehtihdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtp
 hhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuffvnfhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

No functional change, just a style fix to align with the other
macros all around.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/spinand.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 15eaa09da998cec3f4999ca805f7bfb6b881a5f7..28a013f4f4f38881bb9f762f2a8ca1e788d400a8 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -71,9 +71,9 @@
 
 #define SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
-			 SPI_MEM_OP_ADDR(2, addr, 1),			\
-			 SPI_MEM_OP_DUMMY(ndummy, 1),			\
-			 SPI_MEM_OP_DATA_IN(len, buf, 1))
+		   SPI_MEM_OP_ADDR(2, addr, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\

-- 
2.48.1


