Return-Path: <linux-spi+bounces-3874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF006932FFE
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 20:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A721C20A29
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662A31A01CD;
	Tue, 16 Jul 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqJI4NcT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CE1A01C1;
	Tue, 16 Jul 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154747; cv=none; b=ad9B9fpWu8V+Mluvs91lg/q/umDw8kRdOJTHc0RO/ZJ1Hx/xdIiHYq+IcKy3OzhsIpGK55H0HHSCVYqJLtfwW30Ivb+zyng4TSKxwYnIdSyCq3ihbiQaKDngIdiEO0LRK9KqTy0UWkbktYnQ3WF32bpsgQDN/o9vi9FlMLLlrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154747; c=relaxed/simple;
	bh=g1fv/uDr8HX6/q9u0wKfQ/YDK4q79yovscP61xbiipA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAtNPsk5DT4o+F/SkMltcSHTUS8dVFNqmFUSdayQPVGHUxXMtghEtApII7hd0PruxWem54JvZAlyvk7P6J5SqxkrK9W+EISk3dB+sKk7NHpAcjdoVU3S7gjfvtUjKJFH04j8UxmM99c/bhCcAj1LjF2GVaYInYhU9NutaYC3xRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqJI4NcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C20C4AF0D;
	Tue, 16 Jul 2024 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154747;
	bh=g1fv/uDr8HX6/q9u0wKfQ/YDK4q79yovscP61xbiipA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqJI4NcThZWN/kJJWf+E5dLPORLeMjUKhHgz28jQr86GqwScvEFJQTMAYfPo7fCMx
	 JiJNGEJK0axv7YbwFSWpECvNxWjTLeibmA4kMnXXgrkEFD4E/RPKmeNti79hML/0Pz
	 Iwir6890UdLf+hVgkBcA2nj7usDniBzhJ4XLgf+YwBwQSK9aQXvepCUwXep/1w86H8
	 +Xwyl2MPNAmXN0ZIxvCZCJa8ITS+xqqZjHvL5m9Gew+d1yO/IpGD3IENlsVxx9UoX0
	 eQaAUH+Klwm7G/6QeTLsH9mVGSp/bJeHx5bvyb5kimqfegQnd+oIYuDykoSBNcA+rb
	 cD9jdTfpengWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 02/11] spi: davinci: Unset POWERDOWN bit when releasing resources
Date: Tue, 16 Jul 2024 14:31:46 -0400
Message-ID: <20240716183222.2813968-2-sashal@kernel.org>
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

From: Bastien Curutchet <bastien.curutchet@bootlin.com>

[ Upstream commit 1762dc01fc78ef5f19693e9317eae7491c6c7e1b ]

On the OMAPL138, the SPI reference clock is provided by the Power and
Sleep Controller (PSC). The PSC's datasheet says that 'some peripherals
have special programming requirements and additional recommended steps
you must take before you can invoke the PSC module state transition'. I
didn't find more details in documentation but it appears that PSC needs
the SPI to clear the POWERDOWN bit before disabling the clock. Indeed,
when this bit is set, the PSC gets stuck in transitions from enable to
disable state.

Clear the POWERDOWN bit when releasing driver's resources

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Link: https://patch.msgid.link/20240624071745.17409-1-bastien.curutchet@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-davinci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index be3998104bfbb..f7e8b5efa50e5 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -984,6 +984,9 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	return ret;
 
 free_dma:
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
@@ -1013,6 +1016,9 @@ static void davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
-- 
2.43.0


