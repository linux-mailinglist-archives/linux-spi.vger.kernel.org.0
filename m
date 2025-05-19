Return-Path: <linux-spi+bounces-8206-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83EABC970
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2713D7A60A0
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA93722B8AD;
	Mon, 19 May 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXlvh++H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A822B8A9;
	Mon, 19 May 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689746; cv=none; b=Bhv0Vxze2TBnXoe4JD2ccYUhCyxrKypWUiHpqhxmXvaeSpPpFaR5UBtZ4TD79bf+iLb1e/Bto48S3CjM4DPyzPC46LKgvo93Xc35GGUa5YI4ZNGONFo+Fnm3fKpo8oMk/kdgGB1/QfViStoFRZlE2FQDXvU4/EfyE/NdWL9+x9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689746; c=relaxed/simple;
	bh=cw6Tkijcuttb9ZLMtOBWn44aOyeM3pb3rshzRVE8F0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2I7LQwG9WdRPkEMu+/qtLDQoXU73A9ZvvRBtDW57ckdjw6ICJuJWiCMtRwCi/vwk6VNJARLkMm3/zAUfs6ovHZ2gfFQBvQkQ6AmrMXGrlTc8fE/qlqaj9bsC0CkUz/iOtMsyUmdg/h79lOZ48heA5V+k8jfthQGc0gVPtgVdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXlvh++H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746E4C4CEE4;
	Mon, 19 May 2025 21:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689746;
	bh=cw6Tkijcuttb9ZLMtOBWn44aOyeM3pb3rshzRVE8F0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXlvh++HoFlZzlhRFKHtN4xARnAzfoWTM6LyP5lcEtWyZsIwOROcdAh5XwD6lNtF4
	 6OR8wa7J3bGD9xkUwS/CycAf7em1LaVn6Ys+QYAeXMMn+0AHQWhjoVjDGaAq8qSy1T
	 Va49KwNMnu2cDGKlmVV6fGNg/zBYAZjB2AFYJiSr3yihRcXc8Wt2lrWNCcVUZu7AWt
	 UNJHaiUVYVOXQkjGZW9FohxBBUzpvgcu+adVg+QnER+05jqXge+id8p8PkQNfL365I
	 b9khkGVw71vNZXVRwKTTw/YfNd7jTP8AqZVmE2Y/er5IEJsWNf1kCjRe8iBoHgxqle
	 saSDpCxSOxxCQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alessandro Grassi <alessandro.grassi@mailbox.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mripard@kernel.org,
	wens@csie.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/18] spi: spi-sun4i: fix early activation
Date: Mon, 19 May 2025 17:22:00 -0400
Message-Id: <20250519212208.1986028-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212208.1986028-1-sashal@kernel.org>
References: <20250519212208.1986028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.29
Content-Transfer-Encoding: 8bit

From: Alessandro Grassi <alessandro.grassi@mailbox.org>

[ Upstream commit fb98bd0a13de2c9d96cb5c00c81b5ca118ac9d71 ]

The SPI interface is activated before the CPOL setting is applied. In
that moment, the clock idles high and CS goes low. After a short delay,
CPOL and other settings are applied, which may cause the clock to change
state and idle low. This transition is not part of a clock cycle, and it
can confuse the receiving device.

To prevent this unexpected transition, activate the interface while CPOL
and the other settings are being applied.

Signed-off-by: Alessandro Grassi <alessandro.grassi@mailbox.org>
Link: https://patch.msgid.link/20250502095520.13825-1-alessandro.grassi@mailbox.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun4i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 2ee6755b43f54..3019f57e65841 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -264,6 +264,9 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	else
 		reg |= SUN4I_CTL_DHB;
 
+	/* Now that the settings are correct, enable the interface */
+	reg |= SUN4I_CTL_ENABLE;
+
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
@@ -404,7 +407,7 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_MASTER | SUN4I_CTL_TP);
 
 	return 0;
 
-- 
2.39.5


