Return-Path: <linux-spi+bounces-2666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9F8B74B7
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C0F28297D
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875AC13C908;
	Tue, 30 Apr 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cp4YYHTb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89541420D8
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477319; cv=none; b=Bj0ISL0tT2+pkYziDLUweWOoL9q7NRpBrp2adWi9hsb3GNjnkoHI54P8XTmZ5xclRToRi3iC7t2wafj4wu/g9Oop5PyPY9Pp0UcyW8Sv/RJMklRQDsBi3ZDGiJ0jaoDxlcOEGGUVPB6JjGvB4kC3SsIHOXfQoQAD/++59WGvsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477319; c=relaxed/simple;
	bh=MqlEzg2jbLKX7b5U4n7ik5lIo7ox8YuJe3H75yyVnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQu67B+79UpIgndWyLKzqRlH3scdG6VoBzQhgDtRtuypkZgUKWHnP2lFvIH4MuFrlMC7oYF+Em6wqMt7VjLeG3HvTzbzIw4uEgM1Qam1UBP919nBBAxooXW/XsAgRc4WqBIzpuCcC4IdhlH5ee2z7LO/PQAJ2n5WINj3ddMTuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cp4YYHTb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=QSKeK0isKUrZRHFQeVEM2xYZKBtP1xN7MAYYmt11wmo=; b=cp4YYH
	TbTJudf06wF5eH8m20CcvujSbPUeyhp6b+7biQIB+tM3ipArocFXGfV3R+dADOi6
	Li848d30UqayJuqft6Rbi9H/DE5Pds3yP7KVC5DbKMe0iapP3tQyDSnumNtCJeu8
	FBkadZMt6r5jT8Canoh0P2QeCA+vz/hR3T3ngFT0J1Al0BjdZR1laWeyaIoIqWxt
	YzDvyRLBDJWYZYU/PuSd2weXGZxaAf1E2UC5RfZaRmyzzByUvsgLCFk2MzM7KZsd
	SvWVjpjfFEfO71dKLa3JiFAEXpSvFsFy3b8JqQpwPwXFtHMtdDfc+ZisJzv0algg
	9gDVIlQVsupZCIeg==
Received: (qmail 2617945 invoked from network); 30 Apr 2024 13:41:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:50 +0200
X-UD-Smtp-Session: l3s3148p1@u9IL204Xxpxehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] spi: xlp: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:40 +0200
Message-ID: <20240430114142.28551-9-wsa+renesas@sang-engineering.com>
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
---
 drivers/spi/spi-xlp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 49302364b7bd..2fec18b68449 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -270,7 +270,7 @@ static int xlp_spi_xfer_block(struct  xlp_spi_priv *xs,
 		const unsigned char *tx_buf,
 		unsigned char *rx_buf, int xfer_len, int cmd_cont)
 {
-	int timeout;
+	unsigned long time_left;
 	u32 intr_mask = 0;
 
 	xs->tx_buf = tx_buf;
@@ -299,11 +299,11 @@ static int xlp_spi_xfer_block(struct  xlp_spi_priv *xs,
 	intr_mask |= XLP_SPI_INTR_DONE;
 	xlp_spi_reg_write(xs, xs->cs, XLP_SPI_INTR_EN, intr_mask);
 
-	timeout = wait_for_completion_timeout(&xs->done,
-				msecs_to_jiffies(1000));
+	time_left = wait_for_completion_timeout(&xs->done,
+						msecs_to_jiffies(1000));
 	/* Disable interrupts */
 	xlp_spi_reg_write(xs, xs->cs, XLP_SPI_INTR_EN, 0x0);
-	if (!timeout) {
+	if (!time_left) {
 		dev_err(&xs->dev, "xfer timedout!\n");
 		goto out;
 	}
-- 
2.43.0


