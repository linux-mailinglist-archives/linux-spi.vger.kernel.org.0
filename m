Return-Path: <linux-spi+bounces-953-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C298455D4
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F0C1C2349A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F6E15B98F;
	Thu,  1 Feb 2024 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgJswnfK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F615B984
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784988; cv=none; b=TmU4w1nZi7oBoNOJv/XaWJBzO53KGOxvsZNvaiFuTvFuV5NIK6Sb+8RYbw+0kHmxvf3lqtQQFxWxrwnBrHXmyg33ujklfifjOswKpNTb+8TWsouNujLcJ+KwD6e4KcLd3DLrdY8yQ2ROIRSNDkIokQnXE6GUV37qdQQr3cUVSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784988; c=relaxed/simple;
	bh=l/BB4Fea1Hu/N0la5f1V2RZF/Zkb3VSUTg95twtMBAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZZ75By8ilkC3hYY3deZihv4aHgZlrTSaSFUD8EwVr2pkyP2Nu00daLESfbJD6ls3NxQGmvlHY60/xxj5cYJ72ERRsuzXKWr0+cZ9crSctI9dtUFIdf9JqGv30V+WpbcxcchXZafioiWK6yMnIVqdJsaLSXzn43bfwP3JCFMaKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgJswnfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A87C6C433C7;
	Thu,  1 Feb 2024 10:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784987;
	bh=l/BB4Fea1Hu/N0la5f1V2RZF/Zkb3VSUTg95twtMBAA=;
	h=Subject:From:Date:To:From;
	b=kgJswnfKfmxthaMv6+lNpT+GakqGqI+Fi3wWoGoPsp4bTdNobkLjlamRRHy17+IDd
	 TMaMj1wb5bT4CqmcAZmIXcxamPjH/9o4WAFOyYdXZ6Pc9Cd071GjHD7w8+gMyDmij9
	 cDGYGIWTomtXddhjUOUEyCL49H64N7cHonrsQhXIOk6dcab4oWJt3NEPYleYoIiLwk
	 KCuFt99qlGdHIxmLsGLBsdHI/Wvct01bgGe6I8tTznyfpxxEBGq+fdJo5ua+Au+egO
	 pPihVAc9UEEgHWk5Hpp8DWD94gcHNPlwhBg2uqQFmFf9E3UX0t4wUBgHgquYRvh1o/
	 m3ZhDBCLHYQUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C65FE3237E;
	Thu,  1 Feb 2024 10:56:27 +0000 (UTC)
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
 <170678498757.21421.14627723377270554859.git-patchwork-housekeeping@kernel.org>
Date: Thu, 01 Feb 2024 10:56:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: imx: fix the burst length at DMA mode and CPU mode (2024-02-01T10:54:51)
  Superseding: [v2] spi: imx: fix the burst length at DMA mode and CPU mode (2024-01-31T10:19:16):
    [v2] spi: imx: fix the burst length at DMA mode and CPU mode
  Superseding: [v3] spi: imx: fix the burst length at DMA mode and CPU mode (2024-02-01T10:01:15):
    [v3] spi: imx: fix the burst length at DMA mode and CPU mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


