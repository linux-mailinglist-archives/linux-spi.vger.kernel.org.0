Return-Path: <linux-spi+bounces-4770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9193973FD7
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A271F2AA7C
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1E1BE874;
	Tue, 10 Sep 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeMk++UU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889F1BE871;
	Tue, 10 Sep 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989024; cv=none; b=Xhfe/FUjHwgXyNnH2mV4gvS8vZ+Yur8Ubk7sWxYz9DzGyKbxC/IMCAjokXF7GC+93uiQxwyt/anK5UdGl6ztZCzUy5z4t3DYs74JqtWV2sTMsbxqJkne+yzApeEy66qhazz0+b3oR2kvygYkYprKFOnhBxQfcxBe+iLJHKKlSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989024; c=relaxed/simple;
	bh=EXwvZMHl3kwSI4ZOqxjjQfwCu9nbD2uz/WWZ5dtcGrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Fg32MKnavwWdZa2p9JnIfDOOBNIsKinfTT9QBm/6CYVpLcwKYFKQdwNh8yNkVC8aLjZixn4C6yOYaRgHbGbfISCL+GpVPQWgauU9RqlXBujj+TWzhNCxwVXupGYBGGNPg7hJynA9lM/UyCIeT1cpTeJ+r94JiSIZdU4G9noKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeMk++UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8702DC4CECE;
	Tue, 10 Sep 2024 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989024;
	bh=EXwvZMHl3kwSI4ZOqxjjQfwCu9nbD2uz/WWZ5dtcGrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeMk++UUmwWiZtZwxbezhkKNgwmo6lQ8hHpyqEW2zogiv2M0LxsW6IP3P1pHZpjkD
	 y/YbLoWid44NGbufTcfKzeU7AuRO0gleUERXe2Ee++xkbHb63TkrWQkJn666I7e5Ka
	 676HDSHF39x2XBOABDtkEDQYzXIm62HgbVvcVBh45C5JfclZly/Dcln6Sj55GJlNp1
	 HWCdCpr6avSpL2556qDZIMW7pQNIDzV/TzFA84S89x3LzIQY8Lve/ny8NClxtiZ3IW
	 ra5Woxmts8rs7ZpIzMPn9cM6czwVFrGYd7QTtfFwqgYD3jzTY1O6lTzBp/daE+hFto
	 3YLiAULtrvu/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/8] spi: spidev: Add an entry for elgin,jg10309-01
Date: Tue, 10 Sep 2024 13:23:25 -0400
Message-ID: <20240910172332.2416254-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172332.2416254-1-sashal@kernel.org>
References: <20240910172332.2416254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.109
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
index 477c3578e7d9..7ae032f8de63 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -722,6 +722,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.43.0


