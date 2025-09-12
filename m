Return-Path: <linux-spi+bounces-9999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41693B53FC6
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 03:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFB93AE07E
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 01:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D6537E9;
	Fri, 12 Sep 2025 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYBuxpz4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50872F4A
	for <linux-spi@vger.kernel.org>; Fri, 12 Sep 2025 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640037; cv=none; b=nP8mHnqjWFYQK/dz5lwf6VyMK02jYCMRWCBAPLVHeRZ40tL0d5/+4ojeTK/4RUUApafqPpXJGeCy0CrdZO6HV5HR3cHDtVZxmvEs695wM07OQoj/aFDDxqxEVjE+AoVAfxbLsZpPuJH/S42LAj7ybawUxK8ErZlXZBBr2smHvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640037; c=relaxed/simple;
	bh=8yx4fSZ+8UOQMaD9uwj3HaCvs14Gig5SQqD8eeuADLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lJfj4rcpXXGoIf9RVblRK2ge3GTNsLUi9bQUkwFFEU/skRBYP4KGvd83KtZN7lkq/BxRUxuglumQyBoZvbyU3oaUdX5fHXrhgyyayJdjXlTVwk9AFv3Zirz4hZg1QYax3dAkSsw62UNcyEgWWNyrNGR1bBdvuSEHA7H+9R7trM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYBuxpz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B89C4CEF0;
	Fri, 12 Sep 2025 01:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757640037;
	bh=8yx4fSZ+8UOQMaD9uwj3HaCvs14Gig5SQqD8eeuADLg=;
	h=Subject:From:Date:To:From;
	b=ZYBuxpz44Rdiyn86nCdAXwBd5VJBi93CRyaGWThoEaxq9d4vfB+RIGWJqQikSAk5q
	 IDx1DWlSniExQIvNcM26g7j6gVNVlarDJglKaUa4K/Zocnv64GmNraKNvnVxrIBc7y
	 kKDvwQVO24ia697xoADqYDUWgdkGmiHOFNSsNtsP1P5AClCQpKT4w4ROUIKkWVKVPM
	 qiojIQ6fvQdjISPNxmVgWwk6HhQ1r1+I+PpYOAYHRiBqBhNdsP7tt7B5nawVHueTnP
	 CQ2+S076IhO/bYzKkKFv/kt8WG/KpGYwOYZYh41yfVpVXSdFNejrbMAN4Q/Yrjp6Kk
	 ur35ioy5GMRCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE4D7383BF69;
	Fri, 12 Sep 2025 01:20:40 +0000 (UTC)
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
 <175764003952.2365245.15752185669239055825.git-patchwork-summary@kernel.org>
Date: Fri, 12 Sep 2025 01:20:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: microchip: lan865x: Fix probing issues
  Submitter: Stefan Wahren <wahrenst@gmx.net>
  Committer: Jakub Kicinski <kuba@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=996030
  Lore link: https://lore.kernel.org/r/20250827115341.34608-1-wahrenst@gmx.net
    Patches: [V2,1/3,net] net: ethernet: oa_tc6: Handle failure of spi_setup
             [V2,2/3,net] microchip: lan865x: Fix module autoloading
             [V2,3/3,net] microchip: lan865x: Fix LAN8651 autoloading

Series: support for Amlogic SPI Flash Controller IP
  Submitter: Xianwei Zhao <xianwei.zhao@amlogic.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1000893
  Lore link: https://lore.kernel.org/r/20250910-spifc-v6-0-1574aa9baebd@amlogic.com
    Patches: [v6,1/3] spi: dt-bindings: add Amlogic A113L2 SFC
             [v6,2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
             [v6,3/3] MAINTAINERS: Add an entry for Amlogic spifc driver

Series: arm64: lan969x: Add support for Microchip LAN969x SoC
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=991164
  Lore link: https://lore.kernel.org/r/20250813174720.540015-1-robert.marko@sartura.hr
    Patches: [v9,1/9] arm64: Add config for Microchip SoC platforms
             [v9,2/9] ARM: at91: select ARCH_MICROCHIP


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



