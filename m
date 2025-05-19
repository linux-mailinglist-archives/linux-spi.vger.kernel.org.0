Return-Path: <linux-spi+bounces-8209-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B799ABC9BE
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 23:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E907B11F0
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1C23F421;
	Mon, 19 May 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiYJLWd6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEB220F41;
	Mon, 19 May 2025 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689799; cv=none; b=qW1Xh3SjwQyI51WzX/bQMAeFZNqMtyBpqI8JvaVRkvP70+VmH2CckxlwWtIS+putAOoOQxQW48yZPd6+q8LcMki+KYGhTG/uOZnlypy6UNB1hpcNklzeqz50863isKblsDGCd4+imAT5Im1PbhSzTymv/dm1ZFnR8QLWkfKZqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689799; c=relaxed/simple;
	bh=pOFSHYTAt9k+byuw5GnkOTfdc/p6LzC2lKTZF/eBYfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hr8jBYRjPxpbKPT7BW5/4MSjtdl5ssQpbnXFt2ePsFdvr0AkGwDrZYSIs6ZuK3otfyol4QEzdXDS/3tGnav/AUjjaQkElJ3fslNt5SlTpr8+JmKwVc4gzIkhTWSH56RPJLUqyHRFPzrABv3arl01K+91Maoc9ewae06RiU9W/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiYJLWd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504BCC4CEE9;
	Mon, 19 May 2025 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689797;
	bh=pOFSHYTAt9k+byuw5GnkOTfdc/p6LzC2lKTZF/eBYfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiYJLWd6gLDu2O+0iYStgFZBhJo0PctqhcF8IkVBBRwXPuEMIXgO+RHOk9jb+8zRy
	 MV2/gc+U0DNXnqI1BOshcsLPGl1jl3mF0CJFdceRrTSq4PzEgfQnG7Yd0xiPr8s2Pe
	 lQNYhU633lDaGvnIa6BloEKz8Vm1fzYIcoG/0YSpuKP9Pb8yTo8Hn3QvF+/lFS0NKW
	 p/PtCew42odVHlpCNXpx1v7rKfIKzirRFFga7ea2vDeLIg6whBQBiT+/ZpRG3mFwzW
	 u8JO50TeBbq4BRt33JtmE5McfAai7HTyaa74YGReaZ7HqDE/lq8G0QuI+OW8ny7WNC
	 sJcaDeQ6IlQPA==
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
Subject: [PATCH AUTOSEL 5.15 5/7] spi: spi-sun4i: fix early activation
Date: Mon, 19 May 2025 17:23:06 -0400
Message-Id: <20250519212308.1986645-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212308.1986645-1-sashal@kernel.org>
References: <20250519212308.1986645-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.183
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
index 1fdfc6e6691d2..a8fba310d7004 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -263,6 +263,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	else
 		reg |= SUN4I_CTL_DHB;
 
+	/* Now that the settings are correct, enable the interface */
+	reg |= SUN4I_CTL_ENABLE;
+
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
@@ -403,7 +406,7 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_MASTER | SUN4I_CTL_TP);
 
 	return 0;
 
-- 
2.39.5


