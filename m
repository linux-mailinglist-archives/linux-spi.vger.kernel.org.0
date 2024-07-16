Return-Path: <linux-spi+bounces-3879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A688933052
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DBC2827A5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB8D1A98F4;
	Tue, 16 Jul 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z70iw2xn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1471A98EF;
	Tue, 16 Jul 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154863; cv=none; b=clTeOe6PSQfZPfwKBZmEjn67GZLxleu892gBUOUTpAbZR3vweRBBajD32Lvtjb6j+c4PA0LCwahiIYx8L+JlxTzrah796NskTO9xVKPzt8o21853RqjnVpevNFelrtmqh1WMGhMJzzy6HoWUDBkROt95bi2mGjnVlbH8eGL7BKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154863; c=relaxed/simple;
	bh=za7H4vQ+L5KJ9eT/gcyxZw/9dBkD1ATzxAtOSvNBgBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db/w3NPGsGd5r95ZJNIGB3dYwbQnC4KJRSp8LZ/BIUrlgbtcp+NWc4p280oGMv56tyHkH6NXYo2iEkqoCJV75k2a4EbHvI+tUpbuC2cnql3T0jx6qIpxDWsFPQwow235CuHSHkduMLtdggHZGILUuZzhmR14Be5Ma0JcygnD85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z70iw2xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2FAC4AF0D;
	Tue, 16 Jul 2024 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154863;
	bh=za7H4vQ+L5KJ9eT/gcyxZw/9dBkD1ATzxAtOSvNBgBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z70iw2xnjwdPZARJPN0pmli0VVHxoM33EtFvyM5xZBdDMGZeYioRqjGbqbwzMscxi
	 p9UocBKcZB+PsyirxKwKOu2S9HXVh3x/U6G26M0ZO8emBLhKjpHaR0JLpsP7vyApib
	 XzvTI4yQObuLmBDlfTLSp8CuD439jN3UHB7j3cU5uy/QjUMP+/7WP2GT20EA4aHLsy
	 pAVbwZ14XvuxaJQtFY4XS9fs3gXW1kGXiiRI6+LzoIMtPIMyL8V+QuZvPG8Gk6kXSQ
	 Cw4ySlzNMSIVCVdq2CIXlDlmLK/KNPKgA7xRr0zMedhL5Uqb3VKu+4P0j8bm3hHKsJ
	 7LsuR60Aum/3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/5] spi: mux: set ctlr->bits_per_word_mask
Date: Tue, 16 Jul 2024 14:34:02 -0400
Message-ID: <20240716183409.2814531-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183409.2814531-1-sashal@kernel.org>
References: <20240716183409.2814531-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit c8bd922d924bb4ab6c6c488310157d1a27996f31 ]

Like other SPI controller flags, bits_per_word_mask may be used by a
peripheral driver, so it needs to reflect the capabilities of the
underlying controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20240708-spi-mux-fix-v1-3-6c8845193128@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 0709e987bd5ab..465d5b0e1d1a9 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -156,6 +156,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	/* supported modes are the same as our parent's */
 	ctlr->mode_bits = spi->controller->mode_bits;
 	ctlr->flags = spi->controller->flags;
+	ctlr->bits_per_word_mask = spi->controller->bits_per_word_mask;
 	ctlr->transfer_one_message = spi_mux_transfer_one_message;
 	ctlr->setup = spi_mux_setup;
 	ctlr->num_chipselect = mux_control_states(priv->mux);
-- 
2.43.0


