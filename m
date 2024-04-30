Return-Path: <linux-spi+bounces-2661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F88B74A9
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E702824D2
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58813D25B;
	Tue, 30 Apr 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hF5BQX/l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3251332A1
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477314; cv=none; b=HkDF+5xfTpdmkV69AbljdJa0+JHOxwh++08h4srtMD4psCk3bwz8QQ4m3IeANtbr+pHM00ZjHHaZfamq2ChLQE0QcJPi2r6R9eOxealFS15+RbMerD1gy8EmmItwULLHngZ+z2m09zXdguTfzxB187a0eCCoUQumR1GyLcBy+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477314; c=relaxed/simple;
	bh=q2H8UXP1+xWtkRmq3d5s2Y2aDkjwDLUdHoiPD5Nkpxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW1uOhKv1i9fdYRWovzeScev2ZZCgMWg4+tQeUlI/344ra795McRLb4DZV0amgj+J446JB3FdFaJJj3ftOjYMfD8bNzgf82tblzM7lrgOgAxjEcJmuXrf/5nwv69aqSPnpC/jxleFk/FO5pKQYF5SgVhALVHgtXAeusAmRhDSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hF5BQX/l; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=7f9jKgtLM4TR5f7XNIH/KGrjxeMbPFxlMoITbWCOV7I=; b=hF5BQX
	/los+n3gxdls0mAEj5zLys2rltn8smAmKIpXGU/Kwfd8vuN324/BmJjhTZNmGRhw
	PR8pMVNktgUsX+OJM0XnhtaLYeVddf0GvAmv5hCkadI573DwSYFeJYMWk2uT31HC
	yv3ApoZljYLtqFO8SIu6NRKknBQ1sv0FjPuwcqdXCfx//U2S5ZKAVGZCYLvimGi6
	rhkGCQZKUf7+mi4KHo55DGzaciRM4pcQgAMaDZYVQqY5bMRgksUW2BHwscioG1oe
	87e9NA52rC1iRvkGwqKpXATlnceHESfGk/0yaDmAJ1yBCStuD6SUtKfPgFc/t9R9
	zw4DVG7UHohxpy0g==
Received: (qmail 2617918 invoked from network); 30 Apr 2024 13:41:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:48 +0200
X-UD-Smtp-Session: l3s3148p1@rBzz2k4X3uhehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:38 +0200
Message-ID: <20240430114142.28551-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
References: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/spi/spi-sun4i.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 11d8bd27b3e9..2ee6755b43f5 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -206,7 +206,8 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_transfer *tfr)
 {
 	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
-	unsigned int mclk_rate, div, timeout;
+	unsigned int mclk_rate, div;
+	unsigned long time_left;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
 	int ret = 0;
@@ -327,10 +328,10 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 
 	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
 	start = jiffies;
-	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(tx_time));
+	time_left = wait_for_completion_timeout(&sspi->done,
+						msecs_to_jiffies(tx_time));
 	end = jiffies;
-	if (!timeout) {
+	if (!time_left) {
 		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
-- 
2.43.0


