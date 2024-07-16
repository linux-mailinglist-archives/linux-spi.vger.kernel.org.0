Return-Path: <linux-spi+bounces-3883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6D93306B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC7528410B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714231AB52A;
	Tue, 16 Jul 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+Bz7ppO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F601AB508;
	Tue, 16 Jul 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154895; cv=none; b=HIfyrzQJWeU22xJG3GqqZ21FULJEV70NovPEeBVFVPb3r7BvfZ7PrJyv1L/0vzphwQuDar+nP9XCXzz23xWRpBNA1Z7oW70mILOBaX26wvpGyVaf3vBVReUhhFtxiy08CJ2uRooAJ/zz+cCR3NE3oD/WprIaIY7TtE+QDE3jHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154895; c=relaxed/simple;
	bh=E+5TwT6MRjxAF7RnKL0fPWWqAO9TyyqyIw9cGaL56y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Veg9iolRcBbvof/+hpwktLNvOkGuzWl0m/gDmkw9K3fgCzl2A3gUZPVDUx9xsPa7OvyABLdUF3FjfvbmMk30I7RQuCuPbLwoWG+Bj6ELQvoUC7ZShulDIEfTtbqqcoou3OO4I+ZoLak/8eT5EBAIGhNhgUwtICyT8vsQ3Ll1CdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+Bz7ppO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FCDC4AF0B;
	Tue, 16 Jul 2024 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154894;
	bh=E+5TwT6MRjxAF7RnKL0fPWWqAO9TyyqyIw9cGaL56y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+Bz7ppO5+hKlipXwGqre0FOGOwz5rVD1Sz/zjL+A5fMrmBMGQt1KaJRgtjBiN43Q
	 qPjXe7v4lmev4ukrI0+R6QctYn7WxXliovFWBnUZ5dSyJ4/uZN5vgKBGdwgjDNzg/l
	 U0fjUgwqRAE+qtwVUfLZXun28tOQqv5p5lIJF+fwW3y4jVS520p6nbVHPgZkvJVTS2
	 UalRRvb0thbJg9T9/SmuqBhCO/9kSCxO3qslfK61KADeFnBBvHjbUdnVmR/oPl1EkG
	 Tm5kLJ+tzRmRXZb9pTYtRTWGEZ6Ta0UJVpwt46WivdmPLuHWFZtAeST4b43nV6NAcI
	 j1R8U2JNrYWvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/4] spi: mux: set ctlr->bits_per_word_mask
Date: Tue, 16 Jul 2024 14:34:39 -0400
Message-ID: <20240716183443.2814769-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183443.2814769-1-sashal@kernel.org>
References: <20240716183443.2814769-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
index 9708b7827ff70..b18c5265e858c 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -149,6 +149,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	/* supported modes are the same as our parent's */
 	ctlr->mode_bits = spi->controller->mode_bits;
 	ctlr->flags = spi->controller->flags;
+	ctlr->bits_per_word_mask = spi->controller->bits_per_word_mask;
 	ctlr->transfer_one_message = spi_mux_transfer_one_message;
 	ctlr->setup = spi_mux_setup;
 	ctlr->num_chipselect = mux_control_states(priv->mux);
-- 
2.43.0


