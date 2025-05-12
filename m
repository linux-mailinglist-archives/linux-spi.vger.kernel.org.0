Return-Path: <linux-spi+bounces-8079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B11AB36BC
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 14:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EFC174025
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674C3290BC2;
	Mon, 12 May 2025 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9c+BXF1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D3267B92
	for <linux-spi@vger.kernel.org>; Mon, 12 May 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051791; cv=none; b=Y1Ij2ciDpMwPcVuxAiwUZUB2r1+Zx0iY51SKM6XJXdDR+yRYvhxa95P0NBG+THhRTu9FyMv1JSnMIcjGMcdnFSgoI6x4PxmrLzR4tZtq27Xwf2Kvj0phNpx6IrCF4SracB/LhPQPHtnoUF04OGDbLaOwU9L0HJUtxiX6eJXsl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051791; c=relaxed/simple;
	bh=WspmloQBtAlu4nsDzQL5ch/8beE0EoyD7aa41gkpsoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cOgbnFZip/V1y+sSdfo1IgazTlm9jQdCp2w7GiNDUmeMVYKFcbU+YMMq17TUGBzwh5hvAF+fv4PNRr79dOeaDCtg/mV4Pv7FpfDDJNSyoSXm92sT4SJJu8GnjF6GDzANPBugt2vjkxFlhb5yx7JwrNNsu2tBK1i4VqdpFwK7DB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9c+BXF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C610EC4CEE7;
	Mon, 12 May 2025 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747051790;
	bh=WspmloQBtAlu4nsDzQL5ch/8beE0EoyD7aa41gkpsoQ=;
	h=Subject:From:Date:To:From;
	b=g9c+BXF1FZwk3NbqNePrVVQ0hTYuUweZxUvBWNaImicSDhjNldETV5tt8Ypy9kzD0
	 XgtGNNCdYaX322qmEVeuIhVXD+grwrNLWuW+hamZHXUN9l8g7Be4CsR4Ez+UqwqQp4
	 CH/k32fUXXfGJibK5sHArG1ERxNguX0oinyIuFmjOnMX9q7Mj1A+ehhTVMD8bAM8j3
	 Ug14eelkbRR1hpK4e1LtQyu336NZTKZ9ajRpSW532yJ8Dxua06Q6z8XECBJm6ftPc2
	 Mg2T23rlUyOwRqSuQ0i9Zn9slp+LMmJTT6XkdSmLkFbzb2Oar6ToyCE+b/dtJBE7wC
	 1g1B/msIBtSmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B154639D654D;
	Mon, 12 May 2025 12:10:29 +0000 (UTC)
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
 <174705182823.916493.1164512685918402925.git-patchwork-summary@kernel.org>
Date: Mon, 12 May 2025 12:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c
  Submitter: Csókás Bence <csokas.bence@prolan.hu>
  Committer: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=947876
  Lore link: https://lore.kernel.org/r/20250327195928.680771-2-csokas.bence@prolan.hu
    Patches: [v6,1/2] pm: runtime: Add new devm functions
             [v6,2/2] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



