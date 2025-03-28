Return-Path: <linux-spi+bounces-7361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B1A74F84
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A79189493D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345381DE8AB;
	Fri, 28 Mar 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RehwtQ3N"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D341D54E9
	for <linux-spi@vger.kernel.org>; Fri, 28 Mar 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183306; cv=none; b=IZKh3OyaSlQsk/T0uAUXaQ/7HxIukuSd6SFQPPJl/3Vod5YQZkJHkdBBg7Igt0HSaNRmRHNBXPQd4aZebtXT0rDThJYG7QPV9WLyoRQOHEtz2FNQJJgPb/+jNmtdvVJQ8LQMJq9qgXbzCyvYxQyyS5koe6zMhxbT5MF4bkhlw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183306; c=relaxed/simple;
	bh=z/FYoyXXBmt6ez1HzUoSTqPT7fM+tr0MilwItKQYPeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTWx657B/1tXtMW8FklZlC/1UIHnO26Pl4JgMuyYJURAkEwUPXnCqYqS0gOPbPAJinMaXJiy3Iz7tEgLcKvUS1N5KnKul1lbjMCuZR2qdXpQQ4EDbqzDMxlYSYrCOCLjXYWLypm8+DTt5hwWVmflEd85EoKTxn4AnbZ97dsjcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RehwtQ3N; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E19943147;
	Fri, 28 Mar 2025 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743183301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ye0M5x0gwdBLkZPPS6sdWDRha5iqPAZkK8PubVMbplM=;
	b=RehwtQ3Nysoodog4P1kPndGqE2unmaFHHw26EyjPkYY909Te/qQYBID2AEFj+wGq8T+Hm0
	xjnzZyw2EWdipC40TIVi1Ezyz0qRkPYLdO9JvOClBIcPnKX/4C3CpAsNg8dVVfGwnPUeeE
	yo7kEeCxP+HmOoYIDwwpWMZt/0O584eBU0aOBHXVZh/wtH9Gm3YUA4XnexSAXlnLfO+fa5
	wqohCs+I8eaL7xyJfcIpuer9EBikY5ps42EdB/p1x7I3eWDU6kLk0SvwDvTXz8KaMUEWRI
	n3X2eLwfh1lN7I7/8HCufSKu2ScQzaiL1Ife2p2c5DGTL5It1a4J50ABwBStCA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <stlin2@winbond.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] Revert "spi: cadence-qspi: Improve spi memory performance"
Date: Fri, 28 Mar 2025 18:35:00 +0100
Message-ID: <20250328173500.3687483-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeduledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetfeduleefjeffheevleeggfdtvdduhfdugeeuieejveejiedvhfdugfettdehnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidrrddpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepmhhiqhhuvghlr
 dhrrgihnhgrlhessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

During the v6.14-rc cycles, there has been an issue with syscons which
prevented TI chipid controller to probe, itself preventing the only DMA
engine on AM62A with the memcpy capability to probe, which is needed for
the SPI controller to work in its most efficient configuration.

The SPI controller on AM62A can be used in DAC and INDAC mode, which are
some kind of direct mapping vs. CPU-controlled SPI operations,
respectively. However, because of hardware constraints (some kind of
request line not being driven), INDAC mode cannot leverage DMA without
risking to underflow the SPI FIFO. This mode costs a lot of CPU
cycles. On the other side however, DAC mode can be used with and without
DMA support, but in practice, DMA transfers are way more efficient
because of the burst capabilities that the CPU does not have.

As a result, in terms of read throughput, using a Winbond chip in 1-8-8
SDR mode, we get:
- 3.5MiB/s in DAC mode without DMA
- 9.0MiB/s in INDAC mode (CPU more busy)
- a fluctuating 9 to 12MiB/s in DAC mode with DMA (a constant 14.5MiB/s
  without CPUfreq)

The reason for the patch that is being reverted is that because of the
syscon issue, we were using a very un-efficient DAC configuration (no
DMA), but since:

commit 5728c92ae112 ("mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes")

the probing of the DMA controller has been fixed, and the performances are
back to normal, so we can safely revert this commit.

This reverts commit 6e6363dd2f1e5b3e42505606ea494572c81dbb64.

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 559fbdfbd9f7..c90462783b3f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2073,7 +2073,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY,
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
-- 
2.48.1


