Return-Path: <linux-spi+bounces-8635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB9ADEBBC
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C9D3B770C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1C2E92D1;
	Wed, 18 Jun 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DtZWb7pz"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE62E7F38;
	Wed, 18 Jun 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248941; cv=none; b=uBSx3oOAOTx1IFDjAmzBWcjLfcA+XijFCZL8lRfZv//HQzvk5Di8bkSaGk0v93VgLFR650FCTW4CIax96+r/Oh82uwSehgsCHWKndFXOEPr/0B9ccstXkZrJPkKN7zSUiX2IAaZlokRLVIWNvr7nMWIfjRsPGvNg53dzG45Dkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248941; c=relaxed/simple;
	bh=02WLi4M+pNsnbuuLYVR5qxwoHIYVrFMrzO8jkeSWyt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iqd15OR9n/W9tsBbZWvmxu+BDN2qOxV8ejHRaSDVpihjemO5/uqin66jKkfM+qd7rREN/t09vI8yWBCLg/PAyxDo2vfZzqWkZQkwHi7Lp8R3uC+rdb7Q0tjOX8ID6JwsLtfiRazyyoo1Kh8aD09l+sNUBj9gAj1unISm+tZHy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DtZWb7pz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8791B4385A;
	Wed, 18 Jun 2025 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750248936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZWJRW69q+SS7CXANDbY2irrOFqYZ2dZT16BR2PmS8w=;
	b=DtZWb7pzdH4o/7Nzgzkk0725atjbsimy+D+gYddGTforoC1m6f2p02mQUigg4nRo4H8KE3
	y6u7d9s4F0P+LJwg1fYfzxnVwBEeoCAYZj5VKe5u3K9B9GJmy8iZzbNancOYNAlKA1T99B
	46n9WbCrgkdJWgV9ejdAutMxJ8mCpjO3bAQqEU97XapNlA34mHgr4PxyJVRqXoNCok5r7A
	+mT1Lis3KgB9RuyYn6Iz5CacPyQwc52Sgs4VMiZxcmzRIUyfO083HG3eoTEUY46+Ach5qS
	lbw9TLqhDprM6IDcXWjQU5/FFZI2wisEkoMMLnKFLOGBmu5/09Ey5Iu6VyQeKQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Jun 2025 14:14:18 +0200
Subject: [PATCH 1/8] spi: spi-mem: Use picoseconds for calculating the op
 durations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-1-513202126013@bootlin.com>
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

spi_mem_calc_op_duration() is deriving the duration of a specific op, by
multiplying the number of cycles with the time a cycle will last. This
time was measured in nanoseconds, which means at high frequencies the
delta between two frequencies might not be properly catch due to
roundings.

For instance, the Winbond driver has a changing number of dummy cycles
depending on the speed, adding +8 dummy cycles when running at 166MHz
compared to 162MHz.

Both frequencies would lead to using a 6ns delay per cycle for the op
duration computation, whereas in practice there is a small difference
which actually offsets the number of extra dummy cycles on a normal page
read.

Augmenting the precision of the calculation by using picoseconds
prevents selecting a lower frequency if we can do slightly better with
another frequency involving more cycles. As a result, the above
situation leads to comparing cycles of 6024 and 6172 picoseconds which
leads to picking the most efficient variant.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 5db0639d3b01596b6f2f2df4b914422316eb9a3f..c42c227eb2a29ccd291bdced6b9d188c3b0bfb67 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -591,9 +591,11 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
 u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
 {
 	u64 ncycles = 0;
-	u32 ns_per_cycles;
+	u64 ps_per_cycles, duration;
+
+	ps_per_cycles = 1000000000000ULL;
+	do_div(ps_per_cycles, op->max_freq);
 
-	ns_per_cycles = 1000000000 / op->max_freq;
 	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
 	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
 
@@ -603,7 +605,12 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
 
 	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
 
-	return ncycles * ns_per_cycles;
+	/* Derive the duration in ps */
+	duration = ncycles * ps_per_cycles;
+	/* Convert into ns */
+	do_div(duration, 1000);
+
+	return duration;
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 

-- 
2.48.1


