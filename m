Return-Path: <linux-spi+bounces-4797-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE9976A65
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E6F1F24C01
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFB11A76BC;
	Thu, 12 Sep 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPCSyIwa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F51A2C22;
	Thu, 12 Sep 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147292; cv=none; b=M6lt3UYuRwf/+R42yX1kmVoDBT7KEzS0pVkeN3R6/aMhZJ9kw06vrguK7TUbUHFCoD7MPF4NFOlEJp5YjU9ma8hSINjgU814f10AtdD1BbcCrVugHQeKG8V+dgtWPOhzl0AIUyitRGngkyq8BffB6dGZO6tkCJxWu9b6Mt5RzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147292; c=relaxed/simple;
	bh=+oL+w1ZiuKwHTIJCuiOnYhTVM8g2jEPUvIOW5PUts/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AGPrU5fcjxoMad/PFlEaicmyUDosTVVHeC+ih9l8qL099AFI3MqqZAmUCbWkNH6kK6nZuVFTjN1Tv/qTVp1qbE5BhibEJxYEyicxaf9XWu4CgTM3jlOzaPq/BI7vfx2PhqsA9T+CPDJSQLDGVUk6vXMspR/Zeo1FJtwjakSm8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPCSyIwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23F7C4CEC3;
	Thu, 12 Sep 2024 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726147291;
	bh=+oL+w1ZiuKwHTIJCuiOnYhTVM8g2jEPUvIOW5PUts/U=;
	h=From:To:Cc:Subject:Date:From;
	b=YPCSyIwaiXI35dr3xpBQPyDOGzppF0eBpNteyi3LsGfw+V2+378irdqJ6rxuMxhHI
	 yIYJYU62Z7i7pF8gFkq1bk02Wadz7k4HTcrL1lMiOjU2xOE/0Y6c8hARYpGmKli+Pl
	 DPoYCRjPP+KkZ73T94xAzpusgZgy2F8bzC3q8NqjCaHlKJTfoRRtMiqqdbPWgfMntl
	 aV04riYxZven9gV3VuPqg5/8CLNCtGf4dBBjDsZj3AQ/AI41TbKO/r27fiIN7UynQx
	 j8KJaKj9vt0dg4JnPNieknAKAlaeeh0Zw0hJGIz+28Me+Pivy5Irv9QojyfHjz1b12
	 HihH71ILOqbTw==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: ep93xx: update kerneldoc comments for ep93xx_spi
Date: Thu, 12 Sep 2024 13:21:21 +0000
Message-Id: <20240912132126.2991851-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Two fields got removed but are still documented:

drivers/spi/spi-ep93xx.c:98: warning: Excess struct member 'dma_rx_data' description in 'ep93xx_spi'
drivers/spi/spi-ep93xx.c:98: warning: Excess struct member 'dma_tx_data' description in 'ep93xx_spi'

Fixes: 3cfe73256905 ("spi: ep93xx: add DT support for Cirrus EP93xx")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've added this fixup in the ep93xx/dt-conversion branch

 drivers/spi/spi-ep93xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index ffbe0d522bce..dc6bdc74643d 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -76,8 +76,6 @@
  *              frame decreases this level and sending one frame increases it.
  * @dma_rx: RX DMA channel
  * @dma_tx: TX DMA channel
- * @dma_rx_data: RX parameters passed to the DMA engine
- * @dma_tx_data: TX parameters passed to the DMA engine
  * @rx_sgt: sg table for RX transfers
  * @tx_sgt: sg table for TX transfers
  * @zeropage: dummy page used as RX buffer when only TX buffer is passed in by
-- 
2.39.2


