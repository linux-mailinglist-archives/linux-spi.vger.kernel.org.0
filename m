Return-Path: <linux-spi+bounces-2346-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDFF8A55B9
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FB71F21A2A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BED14265;
	Mon, 15 Apr 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBa5dg6K"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C59757FD
	for <linux-spi@vger.kernel.org>; Mon, 15 Apr 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192983; cv=none; b=mWGer83HwgNO4HAmR9GZMnrdTeqO9ARICeM/6Kg7Oa/Xo9mMyqBJ5cMFrsTCT2SzxNI4Xg9IA53nV6E0Mp5yPFSirnfOXDOV7fM4wTQexIaXp2vWgpqqMpeBnCi6PI1tR41by1Dq4VYWlJ0KoPH1CM4D5xblMS6m3uXrovjErTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192983; c=relaxed/simple;
	bh=89BKMFm1vsrkO6Ppsq+4hkUVoeTTesSKmk/aBmC0kHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WTTUKr1XBMgKChLDlEYz1vCiCYzneCZi3ApJ4oU0Xx9H32CiUhUbQrWZXkouLAciv4ac2F6/FLfz3fri9ujZRu+yJr0St5l++zYZxLsh8i2Cp8//iiP0if5hZf6oVsZCADPmc5xB9Fp1PgRZXpu2WMMGb6lYt31+bps56L3XA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBa5dg6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 885BCC113CC;
	Mon, 15 Apr 2024 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713192982;
	bh=89BKMFm1vsrkO6Ppsq+4hkUVoeTTesSKmk/aBmC0kHQ=;
	h=Subject:From:Date:To:From;
	b=cBa5dg6KWCgpUExFWp+P6skY+Bn3FyjINmhM7e0TZb3b56qVNKeq1AHoski4sp7RP
	 baeRBZwSsC52Fym8+puQAGBFRwo/rKdoIZFhXa9uKgWm/fNmxpImgIOilE+qgh/b3S
	 xEt4mWoeiKBQL6/WF0GfG60nEAv5unAND25c/r7d/G4O02AtFj1/NbzM6LXZwu6Dec
	 Re4fWfsLFAa/mZ2T3W6hGj5HZZxvFHzeskEoXEy+c9duKJfyLX4jjuIi5LwQuii6n5
	 Z4NcNAXBIfqmronvHxpi+mS50g/GhnPIGH5cBLO6dacTn2u8XjKhhoug8sh4607l3X
	 eHtYSdjRxYSgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74D86C4167D;
	Mon, 15 Apr 2024 14:56:22 +0000 (UTC)
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
 <171319298247.20188.15502083452984249751.git-patchwork-housekeeping@kernel.org>
Date: Mon, 15 Apr 2024 14:56:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add bridged amplifiers to cs42l43 (2024-04-15T14:09:21)
  Superseding: [v5] Add bridged amplifiers to cs42l43 (2024-04-11T09:06:26):
    [v5,1/4] gpio: swnode: Add ability to specify native chip selects for SPI
    [v5,2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
    [v5,3/4] spi: Update swnode based SPI devices to use the fwnode name
    [v5,4/4] spi: cs42l43: Add bridged cs35l56 amplifiers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


