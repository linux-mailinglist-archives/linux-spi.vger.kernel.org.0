Return-Path: <linux-spi+bounces-8205-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB082ABC936
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 23:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CD21B66206
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A5221F1E;
	Mon, 19 May 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyVRm4WU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BE221F15;
	Mon, 19 May 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689715; cv=none; b=SpEK9KPPr9AOTgk+xWlG1Gi98oPMLUO5spmLfdzFQPvqvD9pe+VFG0VxrddfA2ldsQuW6z4+8PeT6la9ABdThoSpnIzrqOgUWgTJddmqLY8Gub6e6QHBH5G4BHIQncMtwOF8Le7LAmTUcPKosOANo785JwZYu1zxdg18hRe7hsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689715; c=relaxed/simple;
	bh=AmLg2chyBTHsNhkZM74ucMywdT/YyQZpQrmFmE9oqEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0UMYgmJKEV0Q11ui0bA84XuZrpVNaqUWxGtwAgjICT1d79iyfuKOHkl5qA5jw8cx1hcsG0WAJ0zHixi4wssB9p07AKULqBUqiFP+I61lkcxuddVPZ8awGJHZs6inXFwGCHjR4ze5ikVCxm23uGxnDdIfw0mwfB2d6gJkbpU+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyVRm4WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4411CC4CEE4;
	Mon, 19 May 2025 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689715;
	bh=AmLg2chyBTHsNhkZM74ucMywdT/YyQZpQrmFmE9oqEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyVRm4WUiBVF5tPlidMg3ojEagyz5D95vxleZnTN/maonTbhtW0geSoj9TspF/+ar
	 o2wJ9qSa9PS2q0LquvRKnrvIvTmystKaycBivtLwtVu/ym8M1bS5++qHBPdtdFps+p
	 SDoHAhR+N+xx534ydIrcMew9AFG/r3TSu0cyybG0Pr7Xs5xn3sPu5WwsNYwEt0i/kW
	 2L00uOxw7NsEKIM8Bmg6iYaOmY068DsU+OjYFPHmF/0XbC1NzpQxrrWtK9LQIWuGfG
	 G9qQg4wuKFQ+0KHHXmxsVc23WbHI/XqWOyn2yMM5SS1E3W6j7euC45K2myxsh86vo7
	 U4C/ERX8tyJHQ==
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
Subject: [PATCH AUTOSEL 6.14 15/23] spi: spi-sun4i: fix early activation
Date: Mon, 19 May 2025 17:21:22 -0400
Message-Id: <20250519212131.1985647-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212131.1985647-1-sashal@kernel.org>
References: <20250519212131.1985647-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.7
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
index fcbe864c9b7d6..4b070377e3d1d 100644
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


