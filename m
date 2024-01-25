Return-Path: <linux-spi+bounces-755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372683C45C
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB961F237C5
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91560264;
	Thu, 25 Jan 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i41abxhh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E95B5B2
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191826; cv=none; b=lffTE+Ym08CqzPjcG+hw7WeY2PVDHh66ZlcIcvdLIQrYpAEBZFo6ihGnKoONMw+XkqHwGNf6RBsRWeSYCg0RUo3juszZevNBS2juHtQi5BSbh6ijtxmCUAVupYtxZmZUfVxWtp2z2joeqA95x991tvLaXWf/orZaCnEM8P5AuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191826; c=relaxed/simple;
	bh=06aN5NbvmDzJQbrUezh2NS1PmbyPzdriELBHFS4ycu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hP/zS6TK1rt6zGNDNXerjOEs7uyQV/ztsJHqXKZoApRP5ykc+4bK2DuNmq0/Fscwlx7UObMwwlAzUJns1I7O9m3mlENIRo947VY73X7GgyQD+D89pC05At0CIK/SAvuYT9L6pLLVe053D2h5cqXIr/GRI9RB+uexBnO9Jl/o2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i41abxhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8880CC433F1;
	Thu, 25 Jan 2024 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706191825;
	bh=06aN5NbvmDzJQbrUezh2NS1PmbyPzdriELBHFS4ycu8=;
	h=Subject:From:Date:To:From;
	b=i41abxhhFu0vbMhR0nU3Ki8vwjXetWoERkh6IUyYijoFIlMlO38jzvBEtLov/KVGn
	 6OcHo8Jd19dpx8vbMZmLsR2O/GZ/Cp3GU5P0U7frClUHLB/w2AF63cOAMVS1jJFuw5
	 qH0KfFO/QjEBbAHHzgI9u4Q3RoUucYpqSG2D0x1qT31VTkaNbh9UIErdJWjDEn1Djb
	 vaQlWvTzLaZiI91C3HB7/WzqOq7oWzLQB2uNQ1CZ9/qjFDGUhe4E87Emhx7c9ICqHg
	 zkwVf71SweJu5fJ2ZIO9T7pC/Ae9eGrZFUyfSZxOBOsViFs/HZKwA6dYtWoh82wBNP
	 1VKwTmlUFtA3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67413DFF766;
	Thu, 25 Jan 2024 14:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <170619182536.13896.7620563274776454551.git-patchwork-summary@kernel.org>
Date: Thu, 25 Jan 2024 14:10:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: arm64: exynos: Enable SPI for Exynos850
  Submitter: Sam Protsenko <semen.protsenko@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818256
  Lore link: https://lore.kernel.org/r/20240120012948.8836-1-semen.protsenko@linaro.org
    Patches: [1/7] dt-bindings: clock: exynos850: Add PDMA clocks
             [2/7] dt-bindings: spi: samsung: Add Exynos850 SPI
             [5/7] spi: s3c64xx: Add Exynos850 support

Series: spi: samsung: Add Exynos850 support
  Submitter: Sam Protsenko <semen.protsenko@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=819681
  Lore link: https://lore.kernel.org/r/20240125013536.30887-1-semen.protsenko@linaro.org
    Patches: [v2,1/2] spi: dt-bindings: samsung: Add Exynos850 SPI
             [v2,2/2] spi: s3c64xx: Add Exynos850 support


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



