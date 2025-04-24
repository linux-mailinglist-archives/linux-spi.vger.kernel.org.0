Return-Path: <linux-spi+bounces-7736-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28246A9A501
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F143162A4F
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EEE1F3FD1;
	Thu, 24 Apr 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIQoH6zJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB571F3D44
	for <linux-spi@vger.kernel.org>; Thu, 24 Apr 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481364; cv=none; b=oX0JZvA9x6lKtH1zCvEGIidRwu+N2xuWaCz32wzEnoksU/zriAEfxgyCPrGznRTkqLhwy0xmLR/FHzn3AUW20NCboX14ySWry5XvYaj+HMK+pnFgvolGFJWKZOBd9WhWmlwtYEhgfZ3aGvfbYHy09JcmU6sayW/Fco/AxggctHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481364; c=relaxed/simple;
	bh=FfG/nnDyWcgQMZ6fwmcP4IOeZAVsV9j1/ggv+qo05bc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CD45lxo2GzIliTggZZLV37JPmiuFRl6fuoA/vKQGuAaWAhoRZgrSqU+aPxabaHjskA0zHCPvfmViLKfMMjxBEvE8LGKF2HU0P5SF8ELV5ymJOkbaUw5Pc6B+mvWE0D1Lu0hVu+hhpGDNUVFgNN/5V5mbRviyNzza/u9M5tQudg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIQoH6zJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34F7C4CEEA;
	Thu, 24 Apr 2025 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745481363;
	bh=FfG/nnDyWcgQMZ6fwmcP4IOeZAVsV9j1/ggv+qo05bc=;
	h=Subject:From:Date:To:From;
	b=oIQoH6zJxxfBSQOovEbeTczkewttcWovyp0GuXPTNsTyFtI9Sk7ptST4JsVyp8PSO
	 iH+4arIXZjbc38ARWq1w/hEHiaIS23TbmNMpCwiuUyWeFkAni7tKugYkFER8/UvuwI
	 QsIOAQ2VJom0yMWomOgepGhCribDZvC1WBkC2MF8wWlAc0Pu/kl4WCKSyweWrZjvLP
	 kzzHDPPQr45iNoojJ1eR632BHAd9hkbPpHSSl81GUq4rYTNFClV4wIlRYU2KUfqbYL
	 B8z5Lt2Q/VZGnBwUaoeO62wlV9H2TG6L8mWol0SAQmNSGKge5fcM0u2MYeyggz3IBH
	 viPdDLOn1d5lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9E380CFD9;
	Thu, 24 Apr 2025 07:56:43 +0000 (UTC)
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
 <174548140196.3249525.17758250817264347472.git-patchwork-housekeeping@kernel.org>
Date: Thu, 24 Apr 2025 07:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] This patch set did some clean up and add runtime pm support for flexspi driver (2025-04-24T07:33:24)
  Superseding: [v1] This patch set did some clean up and add runtime pm support for flexspi driver (2025-04-23T06:11:37):
    [v1,1/5] spi: spi-nxp-fspi: remove the goto in probe
    [v1,2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
    [v1,3/5] spi: spi-nxp-fspi: use guard(mutex) to simplify the code
    [v1,4/5] spi: spi-nxp-fspi: remove the unchecked return value for nxp_fspi_clk_disable_unprep
    [v1,5/5] spi: nxp-fspi: use devm instead of remove for driver detach


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


