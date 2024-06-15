Return-Path: <linux-spi+bounces-3408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D269909796
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jun 2024 12:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895251F22395
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jun 2024 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED07E219F9;
	Sat, 15 Jun 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk6115X/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A34C89;
	Sat, 15 Jun 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718446170; cv=none; b=evnQrFg3ePsTG/8HVNFdqc1bpdSsn2iobDcb/fjCR35j5VBVadCqvN2oLW6PHYPR/nSnWkD6P2+oTj7rfkASjsJ9r1krjY5vyIrQ5gblk0mHPWXjbnSTqHNFTnB4bSyR/9KfyH41pTN+4O3zlPKtckXnZwwCYk83/J8+4PeUgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718446170; c=relaxed/simple;
	bh=HvUPx802Llt4G+Tl13HBiTarHMGlEgkkMTaaTO5pzFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oqjhJcCiLKH3uNSLcWXbecGjT1xP0/tW/+yI63hWindGhj+i5aeWyqq2B64LQOc7bqgszvvDMdyEJxySfFUt7HpqFii8Ibo53Z51McFD1QI/PnGnZ3zAA6cUKtOFiSDIn34fAmhW7brUkeE3fkJAy2F3F3/v73h+IxpoJ62YMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk6115X/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso24661775e9.0;
        Sat, 15 Jun 2024 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718446167; x=1719050967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzN9Kmb9Im4DBxHzjqgQLTqERE+RXhwVrMeRyO/BEY4=;
        b=Rk6115X/5vguyd1TbyiiU2ehP2wRqeXf1yQRTgHx9q1RbA2jkOhOp3bhI5pqwE8bhP
         VbYZE1JYg58Rg0UREsYxMh37KCWt1XRERWo20tdbyaA1meQZ5OJJobogn1sRryjeFjjF
         djjp81VRzfcEp8jTsJSlIehVOD6QI9aGV5nmebBqZMySQrWHAubffOpgPlqS7JtUfikE
         lVI2PrXhCUfSKd9aouk3LLSpwXdk8wc1ca8B6OXsz6ob1aszWroFIHIzgoGuaqYJOId+
         ytowdp7HR86P7lHqXb41YJL9z+OJUJtCYr21qgLkaZKWChGFHjfWd9pU2K2rmqrJTP5o
         aC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718446167; x=1719050967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzN9Kmb9Im4DBxHzjqgQLTqERE+RXhwVrMeRyO/BEY4=;
        b=QkYo12OCoJ0rd+mCDn9p2N344L2leMO0FFjlFaOjrvFOz99NymnO+Ll/k80mKftvq8
         3FxXe1ECDCdnENGynR3yGsp7huMfkElUrSlq61hjH6zEEnv4oxZp9g7UrQBit1IgremZ
         SuGTehndy12YyW2axk+yviU5P8wH8b/oUXriz5j3I+J2Acmq1iBqx94nA4cEvHrCDBBR
         BDt6324p+e/AjvzxC+0FHmlh9v3Q4khXwHaS0+fZBAj5T3Bzc+ILOjGhoxc7I7vb3/q5
         UqdqpStmiVdlQ+cOJT9KzC4vP5ANT+yDaM3JG0FvGMiZf9uraPczYwY9Z4wy2gxM7LIx
         WGNg==
X-Forwarded-Encrypted: i=1; AJvYcCWvtX8ylBQp3zzgU+zpT12xi42cQ+mhU3JppWHEjHahjmi2aU+K+3U6YbOyHVDFxWvF07Jo542OeJ0om5DvHqoHUK05vR4gHhx1Csz1
X-Gm-Message-State: AOJu0YwooRJFQidkN0n8xkpyngFdMkJ69d4zjIa9cdGGl2thFPVA3DpL
	rT4j07QD+q4KxQ6/SHS3xM+2ZGHgGuRIwbxAzb6eRTCbEfknWnc3ArqJ1Mf0AqY=
X-Google-Smtp-Source: AGHT+IEcxQYeEzQCTZ8Uc5HEW1YaGzm3HqfqNWtteRcG8fjqp3PnQd0zKrO5BVUu8OfGavFLydUY4g==
X-Received: by 2002:a05:600c:198b:b0:421:81a7:b0b9 with SMTP id 5b1f17b1804b1-4230482126fmr45612425e9.8.1718446167207;
        Sat, 15 Jun 2024 03:09:27 -0700 (PDT)
Received: from desktop.lan (mob-194-230-144-139.cgn.sunrise.net. [194.230.144.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33be5sm93633815e9.2.2024.06.15.03.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 03:09:26 -0700 (PDT)
From: alain.peteut@gmail.com
X-Google-Original-From: alain.peteut@spacetek.ch
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alain.peteut@spacetek.ch
Subject: [PATCH] spi: omap2-mcspi: consider gpiod chip selects.
Date: Sat, 15 Jun 2024 12:06:11 +0200
Message-ID: <20240615100610.11587-2-alain.peteut@spacetek.ch>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alain Péteut <alain.peteut@spacetek.ch>

Consider gpiod chip selects, in which case channel 0 is used.

Upstream-Status: Pending
Signed-off-by: Alain Péteut <alain.peteut@spacetek.ch>
---
 drivers/spi/spi-omap2-mcspi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 6ba9b0d7710b..12519519f0f6 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -266,6 +266,14 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 	}
 }
 
+static int omap2_get_channel_index(const struct spi_device *spi)
+{
+	if (spi->cs_gpiod)
+		return 0;
+
+	return spi->chip_select;
+}
+
 static void omap2_mcspi_set_mode(struct spi_master *master)
 {
 	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
@@ -1062,8 +1070,8 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
-		cs->base = mcspi->base + spi->chip_select * 0x14;
-		cs->phys = mcspi->phys + spi->chip_select * 0x14;
+		cs->base = mcspi->base + omap2_get_channel_index(spi) * 0x14;
+		cs->phys = mcspi->phys + omap2_get_channel_index(spi) * 0x14;
 		cs->mode = 0;
 		cs->chconf0 = 0;
 		cs->chctrl0 = 0;
@@ -1261,7 +1269,7 @@ static int omap2_mcspi_prepare_message(struct spi_master *master,
 {
 	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
-	struct omap2_mcspi_cs	*cs;
+	struct omap2_mcspi_cs	*cs, *cur_cs = msg->spi->controller_state;
 
 	/* Only a single channel can have the FORCE bit enabled
 	 * in its chconf0 register.
@@ -1269,10 +1277,11 @@ static int omap2_mcspi_prepare_message(struct spi_master *master,
 	 * A FORCE can remain from a last transfer having cs_change enabled
 	 */
 	list_for_each_entry(cs, &ctx->cs, node) {
-		if (msg->spi->controller_state == cs)
+		if (cur_cs == cs)
 			continue;
 
-		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE)) {
+		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE &&
+			cs->base != cur_cs->base)) {
 			cs->chconf0 &= ~OMAP2_MCSPI_CHCONF_FORCE;
 			writel_relaxed(cs->chconf0,
 					cs->base + OMAP2_MCSPI_CHCONF0);

base-commit: 88690811da69826fdb59d908a6e5e9d0c63b581a
prerequisite-patch-id: 7a234a8c0536cda1dc91514bddb2f083d8d666cf
prerequisite-patch-id: 01c2349d2974d82d3ca247376ef662af76c36e00
prerequisite-patch-id: d1073b7d7d83b86d24982c6ce6760c3d3e45c384
prerequisite-patch-id: 20ffb9fa23d00d67cbbdfa2f844f94dfb3a8f46a
prerequisite-patch-id: a47109b77bed675b663c80fc05eda78dabe6033b
prerequisite-patch-id: 83a34f6d7ca32d93dece10251e56b32539ac231e
prerequisite-patch-id: 4a0df403305f1ad7fa2ca4e5deb6dd4f5316ae1d
prerequisite-patch-id: 8bc4935e31918f5c1536c4e24e26fae9c5d56d8d
prerequisite-patch-id: b3e4cdfeecdb49f35cc812e8aa93380870eb971d
prerequisite-patch-id: 3c05cf476520c48fa72e8f0532d7b8bbc8a6669f
prerequisite-patch-id: 01111a1e598cfafa7cc9053b5dacf409cef752d4
prerequisite-patch-id: a6a254ae73657aac27fceb77e998d36d776bb945
prerequisite-patch-id: dc0f9db10774a3d0fa084d8be4cf45673d382d05
prerequisite-patch-id: abdbc1894b50d94126e784dc87a40f8dc367609a
prerequisite-patch-id: d27844ef50a0ce4402b4660f765027dd55a971ff
prerequisite-patch-id: ea542d6a43949fa3d92176d204c464b5d8d2eaf8
prerequisite-patch-id: 6699a5e206e5d57316bcc46cded20fd12dabac64
prerequisite-patch-id: d2e8a366c84dfeba2c0957163fd9ab4f89b07f37
prerequisite-patch-id: 9637656b8d8645f779f5be6a7ca457e71d077727
prerequisite-patch-id: bda5faf0c1da291fc591cd19b1b9db95a22c3575
prerequisite-patch-id: 57501aaf0ab3cfc94c898f875d63349c89a46386
prerequisite-patch-id: ab18d19294365b37c5dcd60195a66552eb9c1cde
prerequisite-patch-id: 4bfb8bc3cb184f631d9664c047e64b95f04e0661
prerequisite-patch-id: 2b6b7716667c29aae9d6bf7dd60b3d81b1ba943f
prerequisite-patch-id: 75655305636f677f58696b85bedb606b70d4bf04
prerequisite-patch-id: 6b1cb16a0bac172401d259ea6576ea8a466b0fc7
prerequisite-patch-id: 7e3e785900d025ae3b180b75ee34e777765d880e
prerequisite-patch-id: 4c2e45e422050e642d46e6aa09a69ef7e079e45c
prerequisite-patch-id: b590b648b8a13609bd684b5d5aa761862c800d18
prerequisite-patch-id: 3ad0c491adf37c454380caba882ecad58fd01d90
prerequisite-patch-id: 60aee342d1a638c0caa03615f840157c5ebc7b47
prerequisite-patch-id: fbc6a7676195e95978cc9146f3ed663152945da8
prerequisite-patch-id: 9b740983ed186d32e2f95053637e6a34d6dbd86d
prerequisite-patch-id: 5da6d2e76b08013d3f1647a0d399f22ac9c40b87
prerequisite-patch-id: e51b9e99da9f0dfb3f0b077ddeea827670a0352f
prerequisite-patch-id: 301ff6c13cb7e24f53135414b30a43634cf1a9b4
prerequisite-patch-id: 52d5222c90a11408324824694f53b74c55d8c6fa
prerequisite-patch-id: e1188536ae5f0895a2f22771a4021c72c5f2c589
prerequisite-patch-id: f0e721d90fa583c8344c83e83f0c95b2e975af26
prerequisite-patch-id: 822a1f0ec6f5045997542a45fd59b4452031bd46
prerequisite-patch-id: 7ce932809ec6bb5cde99f0e3b2e60ceb013315a5
prerequisite-patch-id: 913b2a7cda1e1f8af04822a32161e8649328cfb1
prerequisite-patch-id: e78432e9441d034c25ef3c837f51797dc20e9d28
prerequisite-patch-id: f9896d99600d8a2a5c817b86ef68b78b5185a009
prerequisite-patch-id: a8ab762262a02d8f30b819e92ff62cefa78d940a
prerequisite-patch-id: e88134ee667f27d6c7466f66b4ef9732c4b60e44
prerequisite-patch-id: 46b8b11abf42558c97e6330c857434c85460b765
prerequisite-patch-id: 1acb898f7dbccd18015afc49e938cbf136eb0474
prerequisite-patch-id: 68ad68c986d2aa7fd6be7da950e18859c5dbeaf7
prerequisite-patch-id: 199d26502b482da691c0f120494ae60d97a02fbc
prerequisite-patch-id: bcfa60c3241a0b870ea4a0a4542ff2a706e1c7ef
prerequisite-patch-id: 4fd07d8f84fc4dcb1a4693f068cfd66f5476a257
prerequisite-patch-id: ba949404f5aacfed3696566bddcd6a88c267051a
prerequisite-patch-id: 1a8e877f64a3e9a045d4a1f219ee574a03b735a3
prerequisite-patch-id: 7f007ec4664ed50c59a6e17e09a94eb5458654b5
prerequisite-patch-id: c4d2fd90ffd576a9d1275670a58a635417704a1a
prerequisite-patch-id: 78eb21692fa9b31524eb3e3063a6ce814e736056
prerequisite-patch-id: 92d2dcca06c6afb3702810cb7dcc4f2069e261a4
prerequisite-patch-id: a76f7712d71e566b78952abb8c2e7c7b88640e9a
prerequisite-patch-id: d7948eb62bcaa1682b6500921e703c39d2056737
prerequisite-patch-id: 5c2e29c76850cfa430c0fc5f028e8977a1c5e522
prerequisite-patch-id: 5d9467b4ffa7f46327fbd3411f6a9d1c4538ba1d
prerequisite-patch-id: f6de8daa45a99740be15066b32245f5c1628bafc
prerequisite-patch-id: ecd701a80ef3f7030c3b7c02522cba3094bf43e9
prerequisite-patch-id: b9ffc0d7a91111690077a8d072dc884dc19bb7ab
prerequisite-patch-id: ad3b2b58ed31c4615eee856c069471405927e1a4
prerequisite-patch-id: 8ba1fa50048b1f4f7f8cbe121471ff4a625fffa5
prerequisite-patch-id: 16052ac149497aa67692d67576adfc5cfc595dc3
prerequisite-patch-id: 786a032663ae515cf4cc830d896a2dde065505e6
prerequisite-patch-id: 4a680dfa3b536343c57b36b99885ee791516cc70
prerequisite-patch-id: 4b7d409ea636b5439ee404ffe9f94d50f76011ba
prerequisite-patch-id: 72c9c0e469a943efa26f30cf6d2753837daa8619
prerequisite-patch-id: 2ab32bcbeb78b0435353d5661c619479aa0f1a1d
prerequisite-patch-id: a3aeeca5625b7fb8c2c053968916b3d405172052
prerequisite-patch-id: 3be43a12d4957904b295c4e767f340c23da356cc
prerequisite-patch-id: f88eb08ca2f79cca30027857e5bfe9a73fe72084
prerequisite-patch-id: 1c42d9022b972a96d90a1695590c6bcd38fc19f6
prerequisite-patch-id: a9d84d309ee09b6c76682e45dec68fba80336f38
prerequisite-patch-id: 55cfb44dc1939e3c417b072ce7684384a6782d83
prerequisite-patch-id: e0b07e5ff3c351fae8f69769c107d3accf6887d0
prerequisite-patch-id: f83e7af8dc45f72cce7d5eaba33d1e5ff359544a
prerequisite-patch-id: bd29457895293d8408c62abce17110a0e839db39
prerequisite-patch-id: 105c923ae3bd1367551ca218bd0d23aa00fccbe1
prerequisite-patch-id: 56606bbfa6a4bf0d9e668198ec0a2ae91675c325
prerequisite-patch-id: 644ac8bd901add9f666eb67fed3b6d72eaac7b2f
prerequisite-patch-id: 187d848bc59cc97644e103abf1f22a41d2e52b0c
prerequisite-patch-id: 48ae7c2f7a12b4485b71cb52ed58fd65d22be2fa
prerequisite-patch-id: f4030e29fa3845d01f40c5f9b9f774389d6776c6
prerequisite-patch-id: f6a250824717a6049823ab935e730dccb7214442
prerequisite-patch-id: cd4dafc24d799219b22f94ae1db0a40ce718b432
prerequisite-patch-id: 7fcbace9120a8a8481cc19ee4dd6228d522b449d
prerequisite-patch-id: b84cfdfd1e0247179deb5e5c2bb8b06a32e59e16
prerequisite-patch-id: 35eaf9c996e696dd90c04cb3fb832a36bda06573
prerequisite-patch-id: 30b417c09caf630c21bf925e751ed936001e5541
prerequisite-patch-id: e88138e960a179d98db32c32e170ad731069c42c
prerequisite-patch-id: 3676df39a17496888e2557f652707ebff4053a2b
prerequisite-patch-id: 9869709efcf8381edef7ff2eaffb3dc5a33cbc35
prerequisite-patch-id: d26b9c0c4097e701924a9c5bc37f3fc5299c9f74
prerequisite-patch-id: d2d923adf83fbf243a408e69f05ee5f72b78297c
prerequisite-patch-id: 5e8bac61b4c4e20679104a4a29e615e7207e224d
-- 
2.42.0


