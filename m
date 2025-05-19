Return-Path: <linux-spi+bounces-8208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD983ABC9AE
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 23:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4823176075
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B504239E68;
	Mon, 19 May 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGCHFKr5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC37239E65;
	Mon, 19 May 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689784; cv=none; b=RBGQrvIn/LWmFyyvQU1FVgElxls4E433jDADh9DKYvpnbTCZBnCTsffCHp3TFQY+vQ3csIZrhdxU9o5Nz6JQIVOeZLjivQA+BFoRjrmySbiNduRRnKnC2OgTvh231x0uXBX0BxsybbJA/VF0sXcxrc4EgYjX5eL7M13CAhqWC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689784; c=relaxed/simple;
	bh=2y+Ih0YzpsawfkOfFrpKV58vdTkM+6PUkQz/ckM/Q3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKP3pTbkm2HsSKa9BqjjD63PQ4kCmuNFa3KDqBNmuKC7W/qdf4oFDAQLuVptjWEemRNIsdFrQIPdu5TRJt6BjbMBx+zqaQQvPPdcEfzI2eLAnK9krBvGB1s13+ujTYlWBrLHDc70l0vKROjdBfFarqP8Am4mANVowhZ2D11fzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGCHFKr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150CFC4CEE4;
	Mon, 19 May 2025 21:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689784;
	bh=2y+Ih0YzpsawfkOfFrpKV58vdTkM+6PUkQz/ckM/Q3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGCHFKr5uayY8oleaIQ6wihs5suNKChFgPF6NGVLrCmR/tj5vTrzo2aW0MLOokJow
	 RZSTrZLjaAbDHJw0UuSdEMXgCaKg8OpYKSJVYVGvqR0Pwadt9GEqMUUmKQkZS3L/uR
	 OjSXnCW7vql+SdR236MJU/HwhQ1+VLC/auYjY7o/JhbSt+HtsZwWNkeGUCakSN04Zg
	 XrIbKv8sw0wKSfEL+Yu5ITmJGNH7kApRRC20s7FFN5+RqNlnMnBJUfbPOaT5DeTyRG
	 Zkwg8HMAP6/b/7889pmzbNEbVXXRwkWl3RC/k2ef/Ds+xpy5Pqzl+O4zxmjzroO1Sb
	 fMRhmICadWBKQ==
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
Subject: [PATCH AUTOSEL 6.1 5/8] spi: spi-sun4i: fix early activation
Date: Mon, 19 May 2025 17:22:52 -0400
Message-Id: <20250519212255.1986527-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212255.1986527-1-sashal@kernel.org>
References: <20250519212255.1986527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.139
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
index 6000d0761206c..6937f5c4d868f 100644
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


