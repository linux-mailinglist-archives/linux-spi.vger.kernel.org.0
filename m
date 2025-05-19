Return-Path: <linux-spi+bounces-8211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53BABCA02
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 23:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5897A1B12
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08568218ABA;
	Mon, 19 May 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5J2sLgK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF12472B2;
	Mon, 19 May 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689819; cv=none; b=Mv0YvQKnIM4oG05uoyvJKVkbbfiRE8YdFfJDZkc/hTmpVVyqCicRUOpmV4dggpZ1O+Qc0RKa0JUNqjJkMOlielR9YaJKzzKvQDT1zc8LM90+C4fYJRHcumUpK7sNKnsVnP8odTU1X4vd05XM+PUYFJwL1xkusYsZ9SS4GGxO8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689819; c=relaxed/simple;
	bh=WKN0tIyIVZDMFS27vKYjeDiZINzeS4GUB+3+CuoWzKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FK1ZArwpehN1DHdjjEZzRk37zk7Oj8jN4BtRA30vzXr0/Qns+ash8ay0hsiklgPbX5BHUqyAGJj0j+R/9Ug2Y2pGW1K6/VSrkY6S9A25aD+T7EeQ4HjSByVGdeBnnm2GjoUGHEhxDgbS91cJRtpWqSavoDM+cQBquNC3lq+NZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5J2sLgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1305C4CEE4;
	Mon, 19 May 2025 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689819;
	bh=WKN0tIyIVZDMFS27vKYjeDiZINzeS4GUB+3+CuoWzKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5J2sLgK3mNyC5t74W2OB91lcRC/5VHsjc5SBk0zX8Nxqnk3UU+6viaJjcymyTohb
	 qadoJCPE65SuxmQC8DsH7fmcSwxbikpcRTGpGosiTAzU/TjuOuJ0C3b7N1dSkw0bbe
	 +02KDqUdkFP4j+SC4bplIP9zqjVjVtz7ezYokSGNULzVoQtiNRNtaw9tazng3+tyJg
	 m4tF9gqH3p5xRGePeb7njg26PZTrzv4ZsgUActTqwGbComzdTxF9EKBQiHZSbFDRPf
	 Xd5bHVKRpx+2bMf36vLn3U9erTf/5Lk/RMuEiR1DsK84a4Wprg3zbaRJ/tPGkRQvJt
	 oLujhyRUC8SiQ==
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
Subject: [PATCH AUTOSEL 5.4 5/5] spi: spi-sun4i: fix early activation
Date: Mon, 19 May 2025 17:23:31 -0400
Message-Id: <20250519212331.1986865-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212331.1986865-1-sashal@kernel.org>
References: <20250519212331.1986865-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index cbfac6596fad5..2bdac65789b62 100644
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


