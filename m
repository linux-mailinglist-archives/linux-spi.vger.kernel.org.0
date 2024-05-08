Return-Path: <linux-spi+bounces-2788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0858C0157
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCFB28A057
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91291272B5;
	Wed,  8 May 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTBS1PAz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC35126F39;
	Wed,  8 May 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183234; cv=none; b=YkWYXLa9ccoqYfuLuBa6zICuHywKXMcNj83AfogbVLplUNlLY5my6fdNLcUCkH8IELKefOtM74DfhZAr2QOzIcp2Q5rTc7c3vWTtSZT45UI6U38PYPKJdFDhpnqxn2VG4bJ08ahkWzFOLsmATogTqcXJZkL6lfsDofyxisgVhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183234; c=relaxed/simple;
	bh=0HR6q0zl75bMlgfU7A1SNZdUSz2U26CMH4Khc6e3wVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVuUnhpHDQg1Xdlwixgo3TYH3NVk6TGkO2cmqWTjUkrpEOaY9pG+c6IxIZy28a/lQDK0Yd3qr5XpwgrJ1/qLGX274/AfhC95jKo9vi134OPKydNdDVMfJzqisC0VGpyaa591ppZ5IsFVGYMwMDTNYxvR0pmnZu2rRBNeMvwnpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTBS1PAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE5AC113CC;
	Wed,  8 May 2024 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715183234;
	bh=0HR6q0zl75bMlgfU7A1SNZdUSz2U26CMH4Khc6e3wVY=;
	h=From:To:Cc:Subject:Date:From;
	b=BTBS1PAzbNf5tz9Ylffd4s0oku6UWlAlm3kmSVwkXAO3ZZzbNmrXVpugY9mtYHqdn
	 /XdXhjBsBEa+TUINBTB2B2en7R3j+TtPNvonFvbDTdZBLEEP8WFzlTz9d1Qe6c+h2C
	 2bBe2OBE7a8lDLgcqtWnzFOwOT8imZwETAiPED54GqjZrhZ2yC8lS060tN/kWjh9RD
	 5wlaoTeI6ccvR+9z0aXsdXIPwhk4C53T7fdORfUk19uUSPq7R+rTX0YbHiUkn4w3jD
	 pVQDZactcwSIJegW1XYIXUNMv5Hcukemwo6AdvLzTMCVLj400ZHlWqHuIdP0pURcw4
	 X9c6Vi/T6AhYA==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] spi: microchip-core-qspi: fix setting spi bus clock rate
Date: Wed,  8 May 2024 16:46:51 +0100
Message-ID: <20240508-fox-unpiloted-b97e1535627b@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=JZge+HWuFL69hQ2rSaeYyYwg1fwwg6/w4PlilwD4sWM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnW87IY6wvjcvbd3lc5s9/aYuKZvvjm3zweQikcjRv66 /ctvsnQUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlcncrIsPFnWtJWd4OtphIv ylmefL970ExKTr392aGbuWIBFxlZ2hj+u9uo3583L3LLvj2WExIS+68aJopO6H/8T/nr/8/mnOx uXAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Before ORing the new clock rate with the control register value read
from the hardware, the existing clock rate needs to be masked off as
otherwise the existing value will interfere with the new one.

CC: stable@vger.kernel.org
Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microchip fpga qspi controllers")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-microchip-core-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 03d125a71fd9..09f16471c537 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -283,6 +283,7 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	}
 
 	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	control &= ~CONTROL_CLKRATE_MASK;
 	control |= baud_rate_val << CONTROL_CLKRATE_SHIFT;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
 	control = readl_relaxed(qspi->regs + REG_CONTROL);
-- 
2.43.0


