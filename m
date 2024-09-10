Return-Path: <linux-spi+bounces-4766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A727973F62
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F0528DE08
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE11AC45C;
	Tue, 10 Sep 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb0G/E7n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B301AC42D;
	Tue, 10 Sep 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988957; cv=none; b=aw4ipTCpS3jXYgI4rqn5Q/iNIlENeMPNU4eHGO7PKrhWO00upTLnNu5/HSnV27+r8BZP2kXmj+brAsInrXW/4GrGGwsONN75T15WQvqqusDuCq9oHjluYo+vyT/iakpfnGuSnAZSdrobwYGYxiar10nvwkEMSOIhwudqyU2wKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988957; c=relaxed/simple;
	bh=CdhUIjiDZivdSI9VSGWFxDOzCndKC/j39GX8Ydcjimg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkQ/3/bHlpeWMKu5E+LCStbdfoSmzbaVUUZNKg6W3xwNkrUCZgmg69IcFn0b+xydtVeGlWdcc8er7XVCK9hktwWyk/279Pn6hZYGCRsYMDUXYKfzo72H8jdXizvwd/Nf9lJPxDXJRihPCpoQekFxX8LsiSqiVbkSXPFfzNuxhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb0G/E7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D9AC4CEC3;
	Tue, 10 Sep 2024 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988956;
	bh=CdhUIjiDZivdSI9VSGWFxDOzCndKC/j39GX8Ydcjimg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sb0G/E7nskFMTglCq0/dFWwDfEaEUViV+5F2kLKeATJJMi/StJKZzaitWJYHEbnC+
	 PR1UlNvXhIfcrx5pKa138IsBqirI1yK2wQYysaiE5TgBnTT9XeW9p9ext1i/aF1r/u
	 leviynEEz6PkuRINk7XJt3Lm/88tl1wJ3aQX4bfBeGjpA3vhQpmPxw98TLGuGb/iYV
	 TMLkc4YYIvUhvkg79RBNGuZ+Y+MSy2PmI/ELpsCv+Zzvv2yh7cohWPDUoN/RwxZsoh
	 F9LM7nAiN4BdDKtr/ZbHdVRRXmsjQgqdIpRPFohQcGuTCGN03NbIR/+w0OKDiTx3Aq
	 GCV03MVV6utog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 09/18] spi: spidev: Add an entry for elgin,jg10309-01
Date: Tue, 10 Sep 2024 13:21:54 -0400
Message-ID: <20240910172214.2415568-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 5f3eee1eef5d0edd23d8ac0974f56283649a1512 ]

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
The marking on the LCD is JG10309-01.

Add the "elgin,jg10309-01" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240828180057.3167190-2-festevam@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5304728c68c2..14bf0fa65bef 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -731,6 +731,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.43.0


