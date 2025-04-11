Return-Path: <linux-spi+bounces-7548-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13629A8515B
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A731881E3F
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E322AD14;
	Fri, 11 Apr 2025 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4jHdqa9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B43FC7
	for <linux-spi@vger.kernel.org>; Fri, 11 Apr 2025 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744336580; cv=none; b=EyxMwUmoon8jhHdN9ETF6fc6kc0PC+7iZ/lndGlpZMiujry4gkoroMKGye5R1TH1JkShv2hUHrUzj49Cb5Y19ELHwqqoqG6AZhgQ1wiTwBMPzplYp3G71mGUi7lt/uGseOP02NqrxY2/8857QsQXIaS6He/HiLB3Ayzjh+IyCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744336580; c=relaxed/simple;
	bh=XVb71Lh141yxb1MD/ywymqebZMREqN3rmBH8Yvbrecg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MWw0hWWFTrtI2fQEsIQdfstY9OWVsRT9k4o5sPcqtYYDJp9rQ5Zd8fNR6jFPjo0SwfvrFwq/bYFLanZbMaORsqwVXTS+VA6+KiJQultdn3C3yYBILGcRtMRRiHAHtaRzguee4pXGi4eu5PXlTHlU8yI2mjBBWmOIKMMTgDW19R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4jHdqa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3346C4CEDD;
	Fri, 11 Apr 2025 01:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744336579;
	bh=XVb71Lh141yxb1MD/ywymqebZMREqN3rmBH8Yvbrecg=;
	h=Subject:From:Date:To:From;
	b=I4jHdqa9uFCKV1HIvoW40H8MO8mYv2QKX9lYjIYM4jEHFQpjXnJfHxVrEeOzNSJP4
	 11oQjP06NL9qb8wmjSkpZlKtVLNjjEOKPx0Co4MBusPVaGcRdBi82Y3jwtXueIpEtW
	 p79/MM0dup7Oo7Z5gAJ5x6JRX4K0iok9SWpvinBypH6rSqAH4Rc1TPLCbxKApWw15s
	 Sm4TN5rFNfpExxF5B4cHyfd6y1sAKG7HuOdhnVy+w3A1JViLh7l7zt0qXJz7yO2uPq
	 dPwdcp4VetyWQvQDz5CibZ1Vy/E4+2xE2356EDv1UPEnWtezj4+FPqEqwnS583Hv1g
	 6D/agN08zSf2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B361380CEF4;
	Fri, 11 Apr 2025 01:56:58 +0000 (UTC)
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
 <174433661666.3901879.15198672536401106596.git-patchwork-housekeeping@kernel.org>
Date: Fri, 11 Apr 2025 01:56:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] ASoC: add Renesas MSIOF sound driver (2025-04-11T01:03:01)
  Superseding: [v1] ASoC: add Renesas MSIOF sound driver (2025-04-09T01:04:34):
    [1/7] spi: renesas,sh-msiof: Living separately from MSIOF I2S Sound
    [2/7] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
    [3/7] ASoC: rsnd: allow to use ADG only
    [4/7] ASoC: rsnd: enable to use "adg" clock
    [5/7] ASoC: renesas: add MSIOF sound Documentation
    [6/7] ASoC: renesas: add MSIOF sound support
    [7/7] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


