Return-Path: <linux-spi+bounces-7589-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78752A891AB
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181121894227
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCE31F4CA8;
	Tue, 15 Apr 2025 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3vZLrQW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0301EE03B
	for <linux-spi@vger.kernel.org>; Tue, 15 Apr 2025 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682201; cv=none; b=pDNJQ/bPE3iyTCrGmIKyN8qDzns1Rt8yvxJne0Yfb1+YbGEXdO74/QE94DhrlVBG51TzghPaW52MRdVH9ClyqlEmJdPtI6HfEvQa+qe67fEKNebb2+AtqdOGhUNEEyoaoaCfSSvo86JuNoKJ1Pn4gwQmV2w0uJ9bTSDsUU/Z9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682201; c=relaxed/simple;
	bh=xodnIYjJ7nAP9+Hyptuo0Lps/5cD2M+q/EBVNqEnujI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qgNx0rh1BRqbEbzmwNfUEHq/Y6U2QKCxHJzSdp45wHIEXkrgPawHoJFAj6NGwFkmNjraINCaU95SbmoPVxbCG1ZFjQ2O58bD6B4Mks8+MZO5+o1jsSVUzHOTKTrhKirEy6cufKM3iOKZjNOgWrZf301CghkvBRF1cJ0TY+SaET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3vZLrQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F95C4CEE2;
	Tue, 15 Apr 2025 01:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744682201;
	bh=xodnIYjJ7nAP9+Hyptuo0Lps/5cD2M+q/EBVNqEnujI=;
	h=Subject:From:Date:To:From;
	b=i3vZLrQWsu3+xcL4dsz1jzK0qQELNNCf2EaJBqQX/QHsDjbliMLQSWFfqBVFBaNtH
	 Ggh4ghrxF68Ei3Jiasbgifey3D2Q3A/ea5vNtdG9sIe5OY3WRtPTEjXOcDqatrPn3+
	 Fk5CKfRz8ro1xUNnErGsjb5vq0zpmwR83LjmfSiJTQW8aPwi6M2HtpUarAyPhxTK4K
	 +1tmYIzLxD57uvOMGXANlOde4CPKhtogV5ddVe3HEKN+ykt/qDRu3AFIL3YKpkqHyP
	 PP3xEIIPOcK4g2oh35++FU3QS9KokIK4aSYnw5lMmGM4Euif/V4dsl+5Nm2mVBlUSD
	 83i6U7gD77eyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100B3822D26;
	Tue, 15 Apr 2025 01:57:20 +0000 (UTC)
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
 <174468223916.2103800.160813651093289472.git-patchwork-housekeeping@kernel.org>
Date: Tue, 15 Apr 2025 01:57:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] ASoC: add Renesas MSIOF sound driver (2025-04-15T01:33:21)
  Superseding: [v2] ASoC: add Renesas MSIOF sound driver (2025-04-11T01:03:01):
    [v2,1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
    [v2,2/9] spi: sh-msiof: use dev in sh_msiof_spi_probe()
    [v2,3/9] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
    [v2,4/9] ASoC: renesas: rsnd: allow to use ADG only
    [v2,5/9] ASoC: renesas: rsnd: enable to use "adg" clock
    [v2,6/9] ASoC: renesas: add MSIOF sound support
    [v2,7/9] arm64: dts: renesas: r8a779g0: tidyup MSIOF node name
    [v2,8/9] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
    [v2,9/9] arm64: defconfig: add Renesas MSIOF sound support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


