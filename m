Return-Path: <linux-spi+bounces-12311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3ABD14A53
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8549530115DF
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5F29AAFA;
	Mon, 12 Jan 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc/vCUrh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EB34F262
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240794; cv=none; b=ql8GOcgzkJLn0mCGglfpYn0A7rJmgTY2V08EiOT0D8Pxhu0DfU3yLjGQo/ylpybgi2tTbL5e6XFF7Gkng4EnPxpT2RfXdZ2ee5UTVZ22Y+3UQetUfrMgx1nBPQr+0h/BA7YsCuCpzrlb/Naz2K2trmcEKPk9njvIieHaEsbzfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240794; c=relaxed/simple;
	bh=yBskddXBb0e5qg8YbpSlrr/Ws6e8sG4wnDD1Ujs+xAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fzGWdiUXxEGj087+Vyz74g2MrwllmRmWWee/xRTkh/CC62hyvT6zOvjuuMTrUB2ghgrjInNSQqUsSf6WAqd2AKRN/sHb4689iLYNTVWHsBsIEEfDE8JkgCsauMlqRLIgsL7iYYQ6YF1F1yEH31BnTUrgl6my29cs+HUxZkW96e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc/vCUrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBBCC116D0;
	Mon, 12 Jan 2026 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240794;
	bh=yBskddXBb0e5qg8YbpSlrr/Ws6e8sG4wnDD1Ujs+xAI=;
	h=Subject:From:Date:To:From;
	b=lc/vCUrhtiEwo0WetiLdv1zdN/8hHMjXfNcHpUfErj541nQZee91RoXMJEOVajCck
	 2aBXFabaJEnVc6NMCblzSYwC3kF+yil5oGJTajnlUnGopm8MAZQK4C5xLOF+ZJez8n
	 L+DUO++OD6P67Bd26jQYuKJhi6b1JQ/IQpTLpdHlGIQK8cz27YX85nKfF0J5ReWu7X
	 fUc1x8mGYierLf7yrc0FP044YTkDWuF4PMN0yVBCZSR/h2gk3+KFBYE/1HR3cmlUTV
	 BcXmE/w2AMDcKfGgcyNrD7/3izoj0S5WpweN52Z1dc1fWceQ3AZFkXzABUUQYN31fA
	 RtA/vnuCepyMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7A7D4380CEFE;
	Mon, 12 Jan 2026 17:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176824058801.1061701.5007408306836660502.git-patchwork-housekeeping@kernel.org>
Date: Mon, 12 Jan 2026 17:56:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: add multi-lane support (2026-01-12T17:45:18)
  Superseding: [v4] spi: add multi-lane support (2025-12-19T21:32:08):
    [v4,1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
    [v4,2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map properties
    [v4,3/9] spi: support controllers with multiple data lanes
    [v4,4/9] spi: add multi_lane_mode field to struct spi_transfer
    [v4,5/9] spi: Documentation: add page on multi-lane support
    [v4,6/9] spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
    [v4,7/9] spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
    [v4,8/9] dt-bindings: iio: adc: adi,ad7380: add spi-rx-bus-width property
    [v4,9/9] iio: adc: ad7380: add support for multiple SPI lanes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


