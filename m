Return-Path: <linux-spi+bounces-3881-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3F93305E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868FD1F23331
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13E1AA361;
	Tue, 16 Jul 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o86jliYt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBF1AA37A;
	Tue, 16 Jul 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154878; cv=none; b=fGw+SGedffikuUfAFGrk45IozHiSY6cbf5sZUkqqHUBg4oj1Ku/RYEmI4mqTF5nqdMdacsfmFqbzRozNtjkERz8sgAJvc3D5jx6rDcyD/apA2YXrSy70pW/kEw+j2vzfbrUKyIdxpOD81Wq2I/klKX7zDwQ3B6H4PSFdlBqzKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154878; c=relaxed/simple;
	bh=P+TvZ/ip7kSMn875lMmBh8M/QIiB8ckRz284FHjL9E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb2BfJYcofkfvMBZ+0BOrqfnYF0oDxmOe+2Wlp/hPQlvXipzXpulC0CTL2njsZRMSb+Q6XzqG9aEGSZ3acYbtBj9txOAORRcs4rMQYK7kRqf4Fbi512FONaPE6/kMu/+Oc1H3aoQqAFX5Pk+tGK31fhbMmfuQL75oVb4qjaTBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o86jliYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB20CC4AF0E;
	Tue, 16 Jul 2024 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154878;
	bh=P+TvZ/ip7kSMn875lMmBh8M/QIiB8ckRz284FHjL9E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o86jliYtNvPOHHWyVxvY73TLCe252efG7y9WSssFk2eUySzeGPttdl6AABt4I9GNG
	 SrpfMw2uV1JHY3G2+q4yVj+TepDuLalyEiNTbTNN5RjYWXKTMg1sG59I6TSrBGXus1
	 0VD4u+pUgZeKdmMmRS/fAOqsg3pWvSRrZarhJ/emOaO5nG0tRLfj84VL5kErB/FlNF
	 t+Da3eovTW7ZIm3RaZ0o31Cp3ZaHlYw7FE8ZAE6hd6/Wufty/fDE6+xToUsQMgQa5e
	 6fE7QX1O1gAS8cwzo1JFo34sZ5lCmWdCo8Ay86VxLZKpMZjdS4JnOpSr7yDKHaquXB
	 UhajhbwnjaGtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/4] spi: mux: set ctlr->bits_per_word_mask
Date: Tue, 16 Jul 2024 14:34:23 -0400
Message-ID: <20240716183427.2814662-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183427.2814662-1-sashal@kernel.org>
References: <20240716183427.2814662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index f5d32ec4634e3..e1af2d8ed51a6 100644
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


