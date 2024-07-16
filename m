Return-Path: <linux-spi+bounces-3877-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C71933044
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1901AB2189B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2071A83BF;
	Tue, 16 Jul 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toxJEzyi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C51A708C;
	Tue, 16 Jul 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154841; cv=none; b=HGlsmdvHq3euP2geRRUkmizIoHLWwf5c8oO9990lZg4cgf6nPc7KQaChpWIhabflLoY+jZwvKai4TaG4ZrRtZ+61h/9ZYe7j4k8+FkUd8TZM6DwOq+wQrMf8UrmK3j29t9+pouepMhramNBXGZOK2z0nHg9UO/rAgV/HF8Td0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154841; c=relaxed/simple;
	bh=+ZEh5ZWgZ7uqm+6KF+zNAbFjx6DKTcUOJevfXK/5pRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX4zxyKVygM1WaSrAlVVVSbjl0QoHtTdiXMiXdUfxBKbA2WSePONjBQD//WkY2xCq/1pE28leveg4gvWdIhYu4iTiBsOyF/LOjbt9050/iKVqTyLalJ342uP9/XlPsn/uk+zWOgyxpFil02oXNkEAXFPc3MRoTx+tsRTxZCdsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toxJEzyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABE3C4AF0D;
	Tue, 16 Jul 2024 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154841;
	bh=+ZEh5ZWgZ7uqm+6KF+zNAbFjx6DKTcUOJevfXK/5pRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toxJEzyiL8jmVSWHYkN6jeWch0mZTEGZQ6GfceJsQZ8SbNSOGUpVuEzTmMHv1lDzQ
	 X/aRO4kUDSiyXetnDmqWk2kEbkueM+/OacIoF+X/skZ2Zg6EGRHGtxlHSM4R2lRqkj
	 CzQyd9PIhfxbzHwbynE15fZYjQtoZXKyB2oAuAtrBgqrMpmhSs7zmA+J8/szX1JyBY
	 LhGZXswLUBf3Gxbr6UFgErXW6XJMObq8DdlIhc0DI9w3u6wyewEVDOZBDGKVpV2t00
	 hjqgkd2xROjX0dtIqFeWejklAEJo2bf5BIjPVvb1P1NCWtHZjn941XsJ5Jr+85J0LO
	 S+BF7UXnFj2EQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 8/8] spi: mux: set ctlr->bits_per_word_mask
Date: Tue, 16 Jul 2024 14:33:05 -0400
Message-ID: <20240716183324.2814275-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183324.2814275-1-sashal@kernel.org>
References: <20240716183324.2814275-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index fa8c1f740c702..804b911f2baf1 100644
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


