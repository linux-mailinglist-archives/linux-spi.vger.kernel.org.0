Return-Path: <linux-spi+bounces-8739-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB49AE6316
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1453A8AE5
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE628CF6D;
	Tue, 24 Jun 2025 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy/IeMGZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2D28BA92
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762581; cv=none; b=du8V1xYjEbCqj6DYX7ID2nvTslqmi5g80BNidPzUws1b/C93UK4N+0S/v9IwgEM/dM+xjsZ4ZitWplt6F1ElLN8UhRUYMaz2YRJVem2N9d958TO4sT0jVQ02gtydilhSv8jJJ31OQfdHMC7xqvDd+O6UU+CFR+cvIN5nWGn445w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762581; c=relaxed/simple;
	bh=BrZo4DU5rtalwWBOso2sXRcWQqTWa1f2DI6wze+g4N4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M2tvSnWKbH/Yi1OD3QKCm9OVdYsfCBXXrBP4RPZkANu2MiBPhrCjLYbAtEWiqtAJqJc0xoyI2evWKKFwmceGp9Xu57IIxOHStleA7dBMMxbm/ri26CisJBdLZ8jmj4Jsi3mOEibyY93rGzTNlJFHMZc6oM3nHQOGf+U3ndouD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy/IeMGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A46C4CEE3;
	Tue, 24 Jun 2025 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750762580;
	bh=BrZo4DU5rtalwWBOso2sXRcWQqTWa1f2DI6wze+g4N4=;
	h=Subject:From:Date:To:From;
	b=gy/IeMGZYnRoEOtqNylI7hJK/2fXro725t/AWda7pDJNzn2nKjk0EtL2faQApVzfa
	 Q2qD++MBhOHvgKaj2pTCPgUXcRoHuO99upU1u1FZPQu5+RS9SGedUVpKmGdQiCoFFF
	 n+KbcM1ZMBdEhE9MwXLsF5k2mRXnUfWC/UQ64NEOHj6yC9/wDCOUAPTVYEEzjAgFQE
	 XfLGM418eejXfxq7G5CCZ3Fdy0dtTDPV9EQ89nHZF7S3/ya6qiV00aG7oRmZu5935t
	 NtrOBLkIPW3zFw9X+0ze8ChG26dvTWcSgxtVzb6Snh3pXV96Bn8KGMPHlKulesUYjc
	 do78aNm6B7TvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2238111DD;
	Tue, 24 Jun 2025 10:56:48 +0000 (UTC)
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
 <175076260680.3497095.7205535661246349531.git-patchwork-housekeeping@kernel.org>
Date: Tue, 24 Jun 2025 10:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spi-fsl-dspi: Target mode improvements (2025-06-24T10:35:30)
  Superseding: [v2] spi: spi-fsl-dspi: Target mode improvements (2025-06-13T09:28:55):
    [v2,1/5] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
    [v2,2/5] spi: spi-fsl-dspi: Use non-coherent memory for DMA
    [v2,3/5] spi: spi-fsl-dspi: Increase DMA buffer size
    [v2,4/5] spi: spi-fsl-dspi: Store status directly in cur_msg->status
    [v2,5/5] spi: spi-fsl-dspi: Report FIFO overflows as errors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


