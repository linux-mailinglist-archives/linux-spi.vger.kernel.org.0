Return-Path: <linux-spi+bounces-8210-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2109BABC9D1
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 23:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393AD18903A2
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF2B24418E;
	Mon, 19 May 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSZhlLVW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA7242D88;
	Mon, 19 May 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689809; cv=none; b=GwlSZBafi0E5tlN1Vu3+9PwvYn/WJ22538d9JwqdNp92ZgJpPVt72JV0AazhtXoEs9EO/SacGyp+bWFeFK9kiZTR9+NAV8/VcjePVJijRvxb2qI/XXYO3dLAis/l6EB6q5Zo46YRcrR2Zep/OzL4IYxcpuxHGj1PsSHArpKqmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689809; c=relaxed/simple;
	bh=pOFSHYTAt9k+byuw5GnkOTfdc/p6LzC2lKTZF/eBYfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hapZ6SRCb9zqezYCpO/lA49D+5VpGrx/qT0ztxHIhN1f+5JyBj+Xr5f9CN3VYWC4duGQA7ERprrahLZ2tanZkfjqqnZk+TCHczPqJ2K3fn8FfyH+u8igSaLEGVIADqPF5W+/UePcBr2vOeNVV+yz16XbPU9NMDzCQxbK1LH48dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSZhlLVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF96C4CEF2;
	Mon, 19 May 2025 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689809;
	bh=pOFSHYTAt9k+byuw5GnkOTfdc/p6LzC2lKTZF/eBYfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSZhlLVWdKf4eVh8R0Wvinky0zVzGMcdXQzc0RM2kJioHCzRmCjxaPUN5NsbRGZbr
	 EEcSBcYdItZyfzT50+1DFB7cVzu2qnfCeofzlgL542OfKuyXYqJd0s5xXaK8e+NgLw
	 l18/TRsHk3AeJaPBZQPWrfmkwrsTeDLBxJdnhGdjttDvzM3fbkL8kTyQQ37XqYhDw6
	 6yblqG6hnpN0WbvRUGuRt23ifzUG5uqwf9na/WmUSGAFYiD/oUC0hVYrR5zB29wLWY
	 loV6MeWi8phe1srk/j0FW48zGfaf09TExQ0KJgkgE2+YQLsFoWeDtwDzLtwfmj1yQr
	 tfwzpaS6nzlCw==
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
Subject: [PATCH AUTOSEL 5.10 5/6] spi: spi-sun4i: fix early activation
Date: Mon, 19 May 2025 17:23:19 -0400
Message-Id: <20250519212320.1986749-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212320.1986749-1-sashal@kernel.org>
References: <20250519212320.1986749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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


