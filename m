Return-Path: <linux-spi+bounces-7519-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE8A8425D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A2A4E0C27
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC022836B9;
	Thu, 10 Apr 2025 12:00:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE461EA7F4;
	Thu, 10 Apr 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.72.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286451; cv=none; b=Bitwxp22dBrTy9QYsak5Jz+XumlY93AuGa+5VwJoZbOjRkh+uNFsPke/6OZ5BGbLx5GNYo9IWsqUz+VT+WPYEvi/U9a/T+BPWzfCmTD6ijikft1VTDoUeP2xPuFJLpYhM60px4D2VhM9UiRdK6k429PdXtLeENKskhGaddzW8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286451; c=relaxed/simple;
	bh=wcg7C+k1bcrv+bIk+uzHk4gA5FuzRRg0xdj/HxqQ+G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOonh6swmba4f2bDQcG5YLgEsDJm6sakjU5sTWFlriqoDCv9fZAAtqHUxVXBRjMB314QwXTXjpCIfkGtMDkYPNPa2xJGZS7ME4mMKJ0FHxG8Yb2jnt6nXWsaOE47Clr7PjCCzW4+sKcKbIKAHlsaFZwR/5hUz+GECPcAQz31MeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com; spf=pass smtp.mailfrom=mansr.com; arc=none smtp.client-ip=81.2.72.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mansr.com
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
	by unicorn.mansr.com (Postfix) with ESMTPS id D4E3C15360;
	Thu, 10 Apr 2025 12:53:34 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id C35A421A3DC; Thu, 10 Apr 2025 12:53:34 +0100 (BST)
From: Mans Rullgard <mans@mansr.com>
To: Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Pan Nan <pannan@allwinnertech.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sun4i: add support for GPIO chip select lines
Date: Thu, 10 Apr 2025 12:53:03 +0100
Message-ID: <20250410115303.5150-1-mans@mansr.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set use_gpio_descriptors to true so that GPIOs can be used for chip
select in accordance with the DT binding.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/spi/spi-sun4i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 2ee6755b43f5..6645d218bcf3 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -462,6 +462,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	sspi->host = host;
 	host->max_speed_hz = 100 * 1000 * 1000;
 	host->min_speed_hz = 3 * 1000;
+	host->use_gpio_descriptors = true;
 	host->set_cs = sun4i_spi_set_cs;
 	host->transfer_one = sun4i_spi_transfer_one;
 	host->num_chipselect = 4;
-- 
2.49.0


