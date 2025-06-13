Return-Path: <linux-spi+bounces-8495-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99452AD8898
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFE2169019
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CD2C1599;
	Fri, 13 Jun 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF1oynGM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D62C158B
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808577; cv=none; b=aJ+To0x7g76+RYrl3xZdHfYoH5WN4LyudIdjD1q5ZdMs1DSotk8gCpNvWSLHuAwD99hUwW9jR+XoDQtSE7jQ9gV5kmCT4/SO33g4tq2Ld3Z3m5L6FEWRM9gxOlljoxyJ2S+xylRGaZQqlhFTyjoAnSi1+JcGr0yZmYsFfOE0NlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808577; c=relaxed/simple;
	bh=tL1UjvLCl1CNkRd8bEw+symeoowXXEtSfciD2KE1oPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NA/kHkcC3/bHTg03iz1KuqWBqkQWHYG3r4OJ8PU3WjNOrvINdjCKkk9XL34AJ+W0Mm9IN+mgPvyRXGGqoZawCGHdK29KtiOgLAaVQs9M7PRL9zAh6iqE0WOj/MqRspporxGQmg024Ln3/VnM6ND/ivfKKKw5PAUmYBtPfBX9VB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF1oynGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1471FC4CEEB;
	Fri, 13 Jun 2025 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749808577;
	bh=tL1UjvLCl1CNkRd8bEw+symeoowXXEtSfciD2KE1oPo=;
	h=Subject:From:Date:To:From;
	b=XF1oynGM+7kED9Ob63xytMFaD2y9X9cMrVHnDXm7gU2bo/V02+/bY2JNOQpC5ZHsh
	 Xky19pmPFxhMdFHzLw8yRztLKXGzh8p3lKFyLA05nhut6brQ/6gi2wmgkaein6G6bm
	 dLMyAEMms1hY4eqfm5VSe4fahkXEBdbezD4rMIBaDwd5vNskHy2zOPqNa2hbxzOv5n
	 b13ljK1Yo+ccQSmo5ZCm5+t999chL78OK5Y9mhXM5UNb/9/s1ZAnq6jfVG+L4CFxHR
	 4jhl0w5LyBbi0FC7rjC2lpwNGtDPxA6fWlHKoQrQsRLxX2iecnyCBHHsFvCFzjaFzY
	 qgIFCbiZCQ5PA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01A39EFFD0;
	Fri, 13 Jun 2025 09:56:47 +0000 (UTC)
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
 <174980860664.661929.666831598494062347.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Jun 2025 09:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-fsl-dspi: Target mode improvements (2025-06-13T09:28:55)
  Superseding: [v1] spi: spi-fsl-dspi: Target mode improvements (2025-06-09T15:32:37):
    [1/4] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
    [2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
    [3/4] spi: spi-fsl-dspi: Increase DMA buffer size
    [4/4] spi: spi-fsl-dspi: Report FIFO overflows as errors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


