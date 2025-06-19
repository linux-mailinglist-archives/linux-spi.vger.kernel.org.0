Return-Path: <linux-spi+bounces-8671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7FAE0368
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A169B7A5155
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D0227B87;
	Thu, 19 Jun 2025 11:24:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BF22539D;
	Thu, 19 Jun 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332253; cv=none; b=J2YGLsLZyTokBRWpRGdsqsCrXZJPTPt40+5L0eYbrwdrstT8laldMnh8CC77s+zRTSg57r0NzXuVzcxvfqNd3jSLCHTEftZb1QUc2cosCOQwQa1lIPWbSclZ5R6YQzk6b92huHt5M2++cazeo1rpk/+D1ioDG51A1Jv9jepWfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332253; c=relaxed/simple;
	bh=xRKgh0EVMeDW99WcMswamZPT62KVgQfkBUwIc3MIA/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWd4ndcEZUm2VHVuVdphMvenmI9iRFLu5Q8KpDSqXWzYUKRU2gkAGgoliRiEMRRRKgPgdTySoeF+DscNb4NGEql0Ph+5zYNCOlXWIPdqLRecCWpG9veL5GS/wx3Lq+SjAELVcpOOQQunxZDN9K2/MGUrL4kdpX5Qa5mhWlk4iFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst086.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 19 Jun
 2025 14:24:00 +0300
From: Dmitriy Privalov <d.privalov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Dmitriy Privalov <d.privalov@omp.ru>, Sanjay R Mehta
	<sanju.mehta@amd.com>, Mark Brown <broonie@kernel.org>, Shreeya Patel
	<shreeya.patel@collabora.com>, Lucas Tanure <tanureal@opensource.cirrus.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, kernel test robot <lkp@intel.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 1/1] objtool, spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq()
Date: Thu, 19 Jun 2025 14:23:30 +0300
Message-ID: <20250619112330.749714-1-d.privalov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619111219.748491-1-d.privalov@omp.ru>
References: <20250619111219.748491-1-d.privalov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/19/2025 11:05:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194191 [Jun 19 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: d.privalov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst086.omp.ru:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;81.22.207.138:7.1.2;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/19/2025 11:07:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/19/2025 5:52:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit 76e51db43fe4aaaebcc5ddda67b0807f7c9bdecc upstream.

If speed_hz < AMD_SPI_MIN_HZ, amd_set_spi_freq() iterates over the
entire amd_spi_freq array without breaking out early, causing 'i' to go
beyond the array bounds.

Fix that by stopping the loop when it gets to the last entry, so the low
speed_hz value gets clamped up to AMD_SPI_MIN_HZ.

Fixes the following warning with an UBSAN kernel:

  drivers/spi/spi-amd.o: error: objtool: amd_set_spi_freq() falls through to next function amd_spi_set_opcode()

Fixes: 3fe26121dc3a ("spi: amd: Configure device speed")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/78fef0f2434f35be9095bcc9ffa23dd8cab667b9.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/r/202503161828.RUk9EhWx-lkp@intel.com/
Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index bfc3ab5f39ea..b53301e563bc 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -243,7 +243,7 @@ static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 	if (speed_hz < AMD_SPI_MIN_HZ)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++)
+	for (i = 0; i < ARRAY_SIZE(amd_spi_freq)-1; i++)
 		if (speed_hz >= amd_spi_freq[i].speed_hz)
 			break;
 
-- 
2.34.1


