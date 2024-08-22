Return-Path: <linux-spi+bounces-4269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4258A95BBB5
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 18:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727201C2105D
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE51CDA06;
	Thu, 22 Aug 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC74wtiz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A791CB300
	for <linux-spi@vger.kernel.org>; Thu, 22 Aug 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343637; cv=none; b=R9HVEl3mN4Evww51WRTxHNa8+4tQ/40akU3M1Gc7nSjJeU6zZK2sxv6hgKVO48Ov0ZQrZJbhSFIVANYidpPRh9DcyhdOFs8TJijj9OWf4fGjOFxZZbYsOnLy54sKFKXuf6eTDikgQMpssHl38pugGcp8nRM6iLiZuSViprYCnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343637; c=relaxed/simple;
	bh=h4Vz0f078DoLk7d9LdwKMbPl405RQ1TxKLYtDRWdS8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hUd+R8UhISG6YypQo2gxKUY/AJ2tczFW+CEv9wLmQukxjSCawTLr86m/H6unOC1m6y7qSNZ52rI8X941Gcx71AKS86QkmJbw2YtBcgq2v37mHV64yws/2rnmyMF8lmhyHL950BZ4AHZP/9vIY+g79TvTXvoPg09YxlNCOoWgZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC74wtiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6809C32782;
	Thu, 22 Aug 2024 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724343636;
	bh=h4Vz0f078DoLk7d9LdwKMbPl405RQ1TxKLYtDRWdS8A=;
	h=Subject:From:Date:To:From;
	b=YC74wtiz5Oc8wt8M7sz1b2EcN0WtjDsJMZ5cK+eXzls3ZVt5G0GxijJq3ynmFTjEE
	 UWVIp6HPZ+2MWURQaGCnTNRaJqjbVkldflPrQv+K5xjrTRTWA1eYFDaHBeE/y3T3Qk
	 NmGs8GIuvabizysS90bY7uChXKEVlFU6lw4uk5bEYOQC6VixISTEy/AsITYpRFaGG/
	 RcLQ4h/OCdcryzttCu9TWtCFggssC0A4LwieV3eG5P2qb/Ujkj5UMP/8ej6xe5pJVb
	 pH3fOg4Jx+nvVKvy5T2lgEDpghjF4znoWbOFb/3YUehdvdwKfG/mu3vazBI/B2HLfF
	 59JGGEhUdLAdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78BA53809A80;
	Thu, 22 Aug 2024 16:20:37 +0000 (UTC)
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
 <172434363602.2376750.2807088424432089882.git-patchwork-summary@kernel.org>
Date: Thu, 22 Aug 2024 16:20:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: pxa2xx: Fix module reloading failure
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=882132
  Lore link: https://lore.kernel.org/r/20240822113408.750831-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/2] spi: pxa2xx: Do not override dev->platform_data on probe
             [v1,2/2] spi: pxa2xx: Move PM runtime handling to the glue drivers


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



