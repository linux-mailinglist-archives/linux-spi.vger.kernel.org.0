Return-Path: <linux-spi+bounces-4768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D0973F95
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146951C257AD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED91BC09E;
	Tue, 10 Sep 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSERkTQm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4511BC07D;
	Tue, 10 Sep 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988998; cv=none; b=gAljGZSa99M60D2D8KQSXW+VG129G2jkQgnCDsDzEj/tFWWOaBsSUwdCBJ9J54mMtMzGt4+EtC9EcljXg5gMtUYw1kZksI5mwkh7YbP243LUhwdVVyXpHLnhOOMw7z5Nkwxi20g54ImYz5hY3xWqDbnSYszAgiAKV6uQ6AmfPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988998; c=relaxed/simple;
	bh=QC9waTAYhanq0vRqyFrmyLWHIwfCfeopNkfwbFRwz1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUGo6LyuNKb7yTZYGW6uNjVpRgdfE1lMTihq+MHtrTqDP7FtuVOVXXW6drKcy2hTyTMjOkpg9rIaXQbLd4ysDzAU4isNCgUDGT3Owjo7DqUl3INO/WvqZsZQqBrJAIjfPmvgyi6wyO0P46ltRZ9tcnxFk30iNtD71uZH7duNdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSERkTQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9F8C4CECD;
	Tue, 10 Sep 2024 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988998;
	bh=QC9waTAYhanq0vRqyFrmyLWHIwfCfeopNkfwbFRwz1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSERkTQm59XrbRJ2uY2Odref4X/0gi/zhmN23L46HPg8EeeRFtrfSnbxJosKUhPsB
	 8y44f5yPU2edjRWEFRDWT9XcD3xD6RmQnEsURBDQsMfbeY3QIvfqTs9eM4oc76coGb
	 Ky1LGdjW8D5lqXIWPsTlfwgXCFXRS3DTe8Sfis+caXLUeA1lIf+t9Whs5ee13C52YG
	 VSdQfxLqyuLankI2iDOfOin3p2yi1dnfes5gpDzkvbNJ6Zo/V/chex6movRKg79X70
	 F1I5pm7DG4aXahDZy+OhDntZVRqBfUYz5w6+EI8WRhA38Xiqj6WRj2H3V+DCilGgc+
	 PaTIX2MuKcA5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/12] spi: spidev: Add an entry for elgin,jg10309-01
Date: Tue, 10 Sep 2024 13:22:49 -0400
Message-ID: <20240910172301.2415973-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
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
index b97206d47ec6..edc47a97cbe4 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -735,6 +735,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.43.0


