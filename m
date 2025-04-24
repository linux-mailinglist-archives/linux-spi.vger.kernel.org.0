Return-Path: <linux-spi+bounces-7748-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51171A9B624
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 20:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C68C4A8049
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCB290085;
	Thu, 24 Apr 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csmT97oE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510728FFF9
	for <linux-spi@vger.kernel.org>; Thu, 24 Apr 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518789; cv=none; b=BckRKG+Hwqtf/BF5foTWLIlRx1vkh1CLTxy5mbJrO+/BswwayyCBwbgtdbWtP5PRWMgsxsvX1DyoYyVBaDR3Pb7Hhf3NI36h3VMl1xGMIwbBzY0vi1OAnat7v0Goj8uIklThpzI3vCi7QiVkZ8r9mlwQXPP0jhGnSMofjvbptvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518789; c=relaxed/simple;
	bh=j2+MA6BCqkdrVOckflOIAp+fbfB23AmkeooqtoolKVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qD5E9FefqLuBdu8RKpSs2YVAvnAA8rcSTN/GRZUR1vTrHLYu3DBHLinK8sYbuQpfo6v9y6vbH36/mOZc/EMRuQc2qKJooVRW4fNrEpdNA9BjqIqMrdEcAUL2xox+zrYWnGLgE7qC61o/A/NRK/l5evd5YyGyuFQDghATYWyS3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csmT97oE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427C4C4CEE3;
	Thu, 24 Apr 2025 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518789;
	bh=j2+MA6BCqkdrVOckflOIAp+fbfB23AmkeooqtoolKVU=;
	h=Subject:From:Date:To:From;
	b=csmT97oERcHDMkCyJOI+aVS3URQyVsLmfV/Hr/YU3WhWHEHrw6q238nGwFwZSa5ye
	 XvSuaLHNdwusM/CdtyqM1uHZyRqonmoADqE0mTZHY/lsoXNarcpQV5b7cKnC3Cha1K
	 CgDqcVSaV4/tgsyfuQZdoNqBRJKNmensRuex3TYt/YWBmAAHWNaI5uXy6Su2Le4byT
	 bx7BPFK0CIoxTNIEFGzI1EzMSmewyaTg+6akeL35xJM6BDqTCNotSGSUlKy3wUL/FD
	 Ux3DmKJYJ2WlB2sEBFh06krIE29W8wmS7irIeg0pvXvNH6ssI0dzrF0atxgyeRwByh
	 DW005+OhExhjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEBE8380CFD9;
	Thu, 24 Apr 2025 18:20:28 +0000 (UTC)
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
 <174551882754.3443031.14781963511490590200.git-patchwork-summary@kernel.org>
Date: Thu, 24 Apr 2025 18:20:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: intel: Improve resource mapping
  Submitter: Heiner Kallweit <hkallweit1@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=951657
  Lore link: https://lore.kernel.org/r/2585fa05-60c4-48c4-a838-e87014665ae2@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



