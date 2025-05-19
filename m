Return-Path: <linux-spi+bounces-8207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B62ABC98F
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88706189C0EF
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE4A23506D;
	Mon, 19 May 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guL1eDFN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4323496F;
	Mon, 19 May 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689771; cv=none; b=kDr8ygPwl7wUW1gmWdJcrUonE/zi6YpRlQjcpa3xreRc/tamp8XtMA9IMiyzz/86rb5BgMDstbdpptIE/JkeF3VYB1CxDmV8SrHB0buVII0t4uajTxYWaoDesQ58siR3FSbNBpB/1k6x3T8MnBEv6+3arufeTvFvIMUa+fpwipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689771; c=relaxed/simple;
	bh=D7IBcVOI+yPkwGYr35IJjIYa1iRv9LBRLXIHo2RAt/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHgzTwvvVWj+kLKKYpuR+2DCmiTHUQw/mFmDZtdB2K4rzUflLjj7uCNIkrnCnzXFWVnpfRslVxD7L+k6ADU6GPJ84BKDhGKQoF1CPzQNGBzt9RXPK64yEtkfgFW8/Knlyy67ZqWZdW/5U82MEDk6sL37kUjNfO5mfPU/TtXZBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guL1eDFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4374C4CEE4;
	Mon, 19 May 2025 21:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689770;
	bh=D7IBcVOI+yPkwGYr35IJjIYa1iRv9LBRLXIHo2RAt/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=guL1eDFNIKRtaBNuiuxhOr6ObFUgfWKK+PzlaoM8mA4ukHV7llx4ZN3KCqOr0iaVa
	 PXiNKGRW0Co6C2yL8cI96uBdTtC2LfHbfJQZZxbkpF/SVRs45C5Wvarx//J1EzMVer
	 Ri8MdXJA3xQbk1TDQnh2gM7I+zFA0sA/ujKVD5eK7bNqGZE+vjgDloMetLk4U/s1iL
	 1nLo3c8THNh/MT3XhBrBodkq2AGd2Xi3+ZvMfhFpeJMFDSV48wXzNyvap4Zc4CGJz7
	 hx/ZnAK1lNghfOm80w3q+UX9rIy19nzAXSn7dnQya6pO1Y+6iQQDJQp85oFp8Ij0KA
	 jhrq+8IPNPYgQ==
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
Subject: [PATCH AUTOSEL 6.6 08/11] spi: spi-sun4i: fix early activation
Date: Mon, 19 May 2025 17:22:34 -0400
Message-Id: <20250519212237.1986368-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212237.1986368-1-sashal@kernel.org>
References: <20250519212237.1986368-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.91
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
index b8947265d329e..5b2cb225a4198 100644
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


