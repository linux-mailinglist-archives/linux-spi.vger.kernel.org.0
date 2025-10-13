Return-Path: <linux-spi+bounces-10604-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8393BD2DB5
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67F174E2218
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB01942AA3;
	Mon, 13 Oct 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdtGJs+t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459918E20
	for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356603; cv=none; b=QKl8i1yRfxc7+4evLa9QlO0iNoatEaSIDBNTJumbpNVs3Tyfn05HlHFtM8ELdZoffBTvO1OgqYaAkqarZL0L3AJfByOZyXFvS/LDLOGcTomHkQveNiuZSISBNxN1cPoYbH33nmcpDfoXsm/LbBdtdz0T+lqkbHcMxhYkZdpJyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356603; c=relaxed/simple;
	bh=aTyIvwmq+9z0oTT93D2RXqZCx4mjOUnFoselTq98cqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Mm3Lytwr3xgenmFU4fYmvjTYctvmDiePGDAxEdxfixzaJKTAQd6BcSrTThv+W/DQrkSF3pJba/lRTulV7b6ZQwRCY2G2o8CgG2aTjYWcQ8lfR7pKJtj+FpRFXL8keRRDHle+OmoBZJAJ7SKQmdXx3B98MXM0LcuG2T/3I57xmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdtGJs+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1154AC4CEF8;
	Mon, 13 Oct 2025 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760356603;
	bh=aTyIvwmq+9z0oTT93D2RXqZCx4mjOUnFoselTq98cqM=;
	h=Subject:From:Date:To:From;
	b=fdtGJs+tzrmLY+ScxZ2Jyr9jsFwgkSqfir3pPhgvyNyPmCKe9VY8+Za3kPeSunUS8
	 HEiIKvdTHZ3cGc/cKyObqQyx5YGyzdL5s9a3x4G4umhDz8Y6QdTia88zvXPM6FLl1F
	 s7HhCUE5WzpRAD/m8JnsKTB2GvK5x9ZIvB725T6AB+xI8nFhthu/tFlLfQOPtkgDLW
	 qA3jGijisj7cQoAalzz9iODOQdh8zmIjN+H2P74ydXYIJQhHbA4ck+/je5kb6a+LO8
	 U+kDwFvIZ1X9WDTrde1mdPxUiAe+ppt4M9TgT/D5WDtvb6mDn5dAedK2EbPdVwCU1z
	 WASc6vKK88BwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E253809A8E;
	Mon, 13 Oct 2025 11:56:30 +0000 (UTC)
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
 <176035658882.2962798.12559901267988511321.git-patchwork-housekeeping@kernel.org>
Date: Mon, 13 Oct 2025 11:56:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER (2025-10-13T11:44:10)
  Superseding: [v2] spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER (2025-10-09T07:10:38):
    [v2] spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


