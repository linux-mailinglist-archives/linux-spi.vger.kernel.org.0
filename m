Return-Path: <linux-spi+bounces-6862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0599DA39E1A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 14:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4777A3A4D4B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0912417F5;
	Tue, 18 Feb 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEhh56vI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E8236A61
	for <linux-spi@vger.kernel.org>; Tue, 18 Feb 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886994; cv=none; b=Q3XsZrRR88GJvnN2ooBpxYVVs0f4PPCy+LUEZ/rakjvSrjppJqfZpo9z4RhiCJku0C1eqHjgYq9IADJe3owsDzB1Cl6hXeBeXPeWt/DG5lvzmzAxjazHRQXWgNM0RUU/q47hVuC+LiAY2n6LrodG4jCt1wOC6u9JTpfACzaqd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886994; c=relaxed/simple;
	bh=AeoQUKCC9ikEwqHEvlqqHKUEe/ZZSBPR1YduzP3P6iM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nQOziIQ0in78qI8RY1JqTtANW+y/Ht3mk9OUKPLnO0kIKPl7Ga2VV9pWb271Pnvd0BBIRb/o77BEq51N4Ik5XF0FLC7XvCWSBjz8+fRnmU2Y0nA/8PQCpnKB0wq01CJPERe+XSR5x8bwkOK5Dm2g+nggrvlfZGgDD3IAp3A/V50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEhh56vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006C9C4CEE2;
	Tue, 18 Feb 2025 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739886994;
	bh=AeoQUKCC9ikEwqHEvlqqHKUEe/ZZSBPR1YduzP3P6iM=;
	h=Subject:From:Date:To:From;
	b=jEhh56vIuQHg3itW98BRtGOjUpTYLkuX8ChX5eKQrzc8jawW7izrjebfrDuxZGZrq
	 kv0j7kpwNJTHDzM6geX5pp7YJl8FMmrJH4Zo4pFs2iinOTCVlRso9AESJupFx6lowi
	 YPY+mNXwAiquLBzW4X7u6RKdLqm7oLpESc8Yv/7WRf+TzwNE60gGKqCnBYBCmhAyQL
	 GkFYnjyMxPq8NMHK99tvH6KVSSABVSDBThhy12GWp879ZDmKTtngWOJshIYa/Py71a
	 QdRaCt6H+JAZTvuXuSDdTAXMCXWwTV8SSOICtWhvN85zUZnOicNQZKN2zcF5f+EyR9
	 9vsgE1Lqeez0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E80380AA7E;
	Tue, 18 Feb 2025 13:57:05 +0000 (UTC)
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
 <173988702390.4091499.10746172674191189967.git-patchwork-housekeeping@kernel.org>
Date: Tue, 18 Feb 2025 13:57:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add STM32MP25 SPI NOR support (2025-02-18T13:00:00)
  Superseding: [v3] Add STM32MP25 SPI NOR support (2025-02-10T13:18:24):
    [v3,1/8] dt-bindings: spi: Add STM32 OSPI controller
    [v3,2/8] spi: stm32: Add OSPI driver
    [v3,3/8] dt-bindings: memory-controllers: Add STM32 Octo Memory Manager controller
    [v3,4/8] memory: Add STM32 Octo Memory Manager driver
    [v3,5/8] arm64: dts: st: Add OMM node on stm32mp251
    [v3,6/8] arm64: dts: st: Add ospi port1 pinctrl entries in stm32mp25-pinctrl.dtsi
    [v3,7/8] arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
    [v3,8/8] arm64: defconfig: Enable STM32 Octo Memory Manager and OcstoSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


