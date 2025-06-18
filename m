Return-Path: <linux-spi+bounces-8633-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA66ADEBA7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CDD4A45EE
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A402E8E19;
	Wed, 18 Jun 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mtqTnIpY"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364D2E8DE3;
	Wed, 18 Jun 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248940; cv=none; b=W9gfNE0BUs3DVYtN45peMu2iYRor1hqWvRGitUhd3kOiNeoaK7deUGa/E71EYy1fnd45mCytckgfQbAQryb/WIBhfBDQldzyYXyOMFAdZv8y+JE++IU40uvq1gVO/AdHXMf0ykLn7ho1uXPwdfWu/FYZJX6tcZzEojYYrLXOsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248940; c=relaxed/simple;
	bh=c4eQp1jpNaHTJFYnkNcsmV8UPwxGMhGSuf7or7yikzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Epwy50Ihb8M448yLM8pSLeDVb9YJFN+77zvLWL5LwDVY2pymrdk14Wd+1+Nzv+19okzPb0v0vWvVuHWgRHo9ab2gh0a/eMS7v5HKMhPtrBAaMq2XHFHuh1HDpbE4fs4+im9I1gCUEHU2Pn/qD0D4F9KeAcXuitfh10YfocNiLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mtqTnIpY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CA3643860;
	Wed, 18 Jun 2025 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750248936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ6sSa3qqRKNyhsxZmga10RJnCjtGjq37nBcPbQIfTQ=;
	b=mtqTnIpYfFXAOBrU3xmBw40hiHYyu9z2ligQjwfVEvrbaNetxhXy6+FoA2QFRXo49CvtyP
	zeWK78f95pvv3HbqrOTGI4EfUu4qcCkAWojlUcAKyTKa6Pos3lCDXRGuA+aRRu8VvV+Tlj
	3bfXMlhgS2dDiPmvfHLQPlKmSaCoFTFzOH9PB1z/zz4KjO25CHR5ebtClA4gFzX9DTBUq7
	a6kMVqrSpQAH8olv7btwJWErWWBIoYYuAC5yUYDSm+4Nec64QpnDUfFb+685SUvbjVL3bg
	e+FXi3/b4ilhORoSGHayNRRMFE6Rlhwz8JjO6bV9uaJEovto580rkMeFN1nZEg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Jun 2025 14:14:19 +0200
Subject: [PATCH 2/8] spi: spi-mem: Take into account the actual maximum
 frequency
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-2-513202126013@bootlin.com>
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

In order to pick the best variant, the duration of each typical
operation is derived and then compared. These durations are based on the
maximum capabilities of the chips, which are commonly the limiting
factors. However there are other possible limiting pieces, such as the
hardware layout, EMC considerations and in some cases, the SPI controller
itself.

We need to take this into account to further refine our variant choice,
so let's use the actual frequency that will be used for the operation
instead of the theoretical maximum.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c |  2 +-
 drivers/spi/spi-mem.c       | 18 ++++++++++++++----
 include/linux/spi/spi-mem.h |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 942a33b8d2ed9530f5fa9228fe298ec1653a795e..03b4b0cda815a2ecc456ea25e802c60e32ee2bae 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1298,7 +1298,7 @@ spinand_select_op_variant(struct spinand_device *spinand,
 
 			nbytes -= op.data.nbytes;
 
-			op_duration_ns += spi_mem_calc_op_duration(&op);
+			op_duration_ns += spi_mem_calc_op_duration(spinand->spimem, &op);
 		}
 
 		printk("%s [%d] variant %d duration: %lld)\n", __func__, __LINE__, i, op_duration_ns);
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c42c227eb2a29ccd291bdced6b9d188c3b0bfb67..d3b7e857b3776e16310d3afc9acb7c315e3ea039 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -586,15 +586,25 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
  * accurate, all these combinations should be rated (eg. with a time estimate)
  * and the best pick should be taken based on these calculations.
  *
- * Returns a ns estimate for the time this op would take.
+ * Returns a ns estimate for the time this op would take, except if no
+ * frequency limit has been set, in this case we return the number of
+ * cycles nevertheless to allow callers to distinguish which operation
+ * would be the fastest at iso-frequency.
  */
-u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
+u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	u64 ncycles = 0;
 	u64 ps_per_cycles, duration;
 
-	ps_per_cycles = 1000000000000ULL;
-	do_div(ps_per_cycles, op->max_freq);
+	spi_mem_adjust_op_freq(mem, op);
+
+	if (op->max_freq) {
+		ps_per_cycles = 1000000000000ULL;
+		do_div(ps_per_cycles, op->max_freq);
+	} else {
+		/* In this case, the unit is no longer a time unit */
+		ps_per_cycles = 1;
+	}
 
 	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
 	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index c4830dfaff3db5549c45bb7a9c4bf5110fa2e338..82390712794c5a4dcef1319c19d74b77b6e1e724 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -424,7 +424,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
-u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
+u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);

-- 
2.48.1


