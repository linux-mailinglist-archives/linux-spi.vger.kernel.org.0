Return-Path: <linux-spi+bounces-7045-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F620A50C3C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 21:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F90C16B3E3
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02E1A5B85;
	Wed,  5 Mar 2025 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ntw6iRZB"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D019D06A
	for <linux-spi@vger.kernel.org>; Wed,  5 Mar 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205390; cv=none; b=h+75IksG8mYjKiyRMOCfBxs0xghdhNWObcCmEOQS3ESFWzvTLfTbJz15m4rtFQuSWEkamsMbSh3Ocz4GPr8BYJlzrQoXepKnLDGBOups4rnvQ1J9zOPw4xu17Dy9lPhmAaC9z1ILlIPzZf9m8u79vrYZP2+kxDnjIvAJUPd292Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205390; c=relaxed/simple;
	bh=1UH27UY+fcQziMHEw2K+3wLlnMyIFUnPrc2ix+7N5UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P67vlEYY1qtHn1qSDK4+d//c6YSdBVHe/DLgdDM3Hn/ENDcGZLNTYnnTt5WkgV0Q9ukb30JT8TifFgAUWkHi10+zP8Umyyd2CUoss7LPG8CBJT7dz6o4vrNktSlcn2EY0/BO+p+X7gSMUKV2gSBCIYmlrRi5Xk8QsmVLUnrKG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ntw6iRZB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 590DF442B2;
	Wed,  5 Mar 2025 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741205386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEQNmi8WIVrqFymiVEP02jh11Ii5GRFTp/TusI0BYkc=;
	b=ntw6iRZB3XqQwOwEoz/OLbmCMODYzkfrcQ5f+jeJUI1jenWG+d7CnnfsgmroheRa7FBdFG
	gf944jbMuxH1qNN4pLKHqo5st0oQwx2LLT+/Ko9s/sFbkkDKi1MaU/dOJFasaEpqExAfiH
	J1joic5DrsLHmdMPi5jIfLVQZJPxpoXOxUsRSMUOpg39UBQX1BRC7bsYPDzlIHA9ogHT8I
	NN6RJoI+36FboA0mQIxGHbulBHy+gWz9cUx/vCFZOhbsrOMA7GDX/uAKc6QVC1QqX/2G9+
	ZD9Bxqtq/DiGBkfxwrsk5D8J4EQ6Bd4kPAwy5SwYZzFeQA9ui3VQ1rycX/YggQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] spi: cadence-qspi: Improve spi memory performance
Date: Wed,  5 Mar 2025 21:09:33 +0100
Message-ID: <20250305200933.2512925-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305200933.2512925-1-miquel.raynal@bootlin.com>
References: <20250305200933.2512925-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueffgeevteevkeegkeehleetteffhffffefgleeuleevjedtgeelgeeutdekgeelnecukfhppeelvddrudekgedruddtkedrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrdeliedphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihess
 ghoohhtlhhinhdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

I do not know the controller enough to really understand what is
happening under the hood, but most of the supported IPs just disable
direct access without explicit reason.

In practice we observe a significant speed improvement when using
indirect mode, some kind of direct mapping, instead of DAC, Direct
ACcess. Add the relevant quirk for all boards with the same
defaults as AM654 to use INDAC (INDirect ACcess) instead.

Speed tests show no change on the write speed on a SPI NAND chip clocked
at 25MHz on the AM62A LP SK, but a read speed jumping from 3500kiB/s up
to more than 10000kiB/s (approximately x3).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index c90462783b3f..559fbdfbd9f7 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2073,7 +2073,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NEEDS_WR_DELAY,
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
-- 
2.48.1


