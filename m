Return-Path: <linux-spi+bounces-3875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F12933017
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5C41F211E9
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149B1A2C24;
	Tue, 16 Jul 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI9xbtrx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83561A08BE;
	Tue, 16 Jul 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154784; cv=none; b=a3BGQEvBbwLz6xEacqHVZovia2ChA402jt5ijUzb8ESDwenmEa0SdhaUBpBhlCMJQrL5IMYCqyIXbHeADpUSUM2+zHayBWkgdxtlq1e+03GxxQyCxDIH0qIN82+k/F/wp4rzwYN0197qNV6aFNGiIU6uGc1D76TG2khsZgRmdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154784; c=relaxed/simple;
	bh=lGTEc50ynugriQfUKe+P3Gddc6Uik9OC/JG7rQMPb/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIxEaO4v0buSwfwfjfAjkNqTqETTIeJZHooH8tbsaqaK28P4qW+ZqtW+cJGZ70My+NDsSWaw6MRrngzImDRvaCC2Ab0So9ewqM8F7+OC76d+GCWW1w6GJtxpOXA+jQ+nphhnDaOtJ73Qg4CGcbtYS5fTdDU7fTTBerG3MgHjBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI9xbtrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B177FC4AF12;
	Tue, 16 Jul 2024 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154783;
	bh=lGTEc50ynugriQfUKe+P3Gddc6Uik9OC/JG7rQMPb/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uI9xbtrxBBo9EAPit0oPVIdPWfm753pxcdgWMhWE0HZn0U0awWL+toNgVIxoPzrPu
	 g3gC4EmwfXeVz372WXCpRu6DjiRyFMcBMl79WQ6/obVmmJtSmE1/TrJYo/GJxegUmx
	 so9PluwPUVu7kq6iZ3IsM2tupa2T33nvS74R12mp+NzWVUt5H4q7XFWKmU2hht7m3b
	 J2DGKA9qZ9nG9RtrBo/ugLE8hnjh+a4MMLtTDelDH//ZnZMey0xnClaip1JZ8jd1rF
	 +phIN/ZdF2d9uo/gJOJASq3tlX/B4wO1aY/Qf95Mi4dfgkVE/czCV2g0tRLSJ2GQeE
	 7jZMIWowztV+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 11/11] spi: mux: set ctlr->bits_per_word_mask
Date: Tue, 16 Jul 2024 14:31:55 -0400
Message-ID: <20240716183222.2813968-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183222.2813968-1-sashal@kernel.org>
References: <20240716183222.2813968-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
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
index bd988f53753e2..0b0dec95e4445 100644
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


