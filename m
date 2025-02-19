Return-Path: <linux-spi+bounces-6878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E60A3B686
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 10:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0037F188C969
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43D1CAA95;
	Wed, 19 Feb 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3nrt2aZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E011C7013
	for <linux-spi@vger.kernel.org>; Wed, 19 Feb 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955380; cv=none; b=gW9kdePvkHO3hVotFHRDR9FqFrOYxMMdro+qmqBaDN0V0xwV9fxwnuvNaRb+TfLiv1LWB1Kf/uPuaSJsN0kOgAi2Q8wOIeCvKNrr0kjAswlhNm3OADYZZ2PNEaJ/eT9nozGvrb+J5J67YyUZ2Dkw6A0McA6+NSXcAiGSWoYXAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955380; c=relaxed/simple;
	bh=Ttwf9EQP27i0LErqAghOFj3RCk5WfgDWjjtahLB7wms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TeYe+6P+7+xUxabACjsbur0J2bTRvvU/dcECZ/sf8jRckMYJFhcyf7zlt+lZvJklVgbLw+TnU7j4rVFW3ZqcXSoB3jKZwTcyj0omd60IOtT8816rbl+UtDsy6ZPx/94b2nptroUWGHd9REm1rSgXhMbyg0WyakFQQQwx8kr0ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3nrt2aZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56960C4CEEE;
	Wed, 19 Feb 2025 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739955379;
	bh=Ttwf9EQP27i0LErqAghOFj3RCk5WfgDWjjtahLB7wms=;
	h=Subject:From:Date:To:From;
	b=q3nrt2aZH7RYtJjlNgnLnhTDQFasQbJiUghpX1GX71Ntef6nu/0UMrAaqgToDgfS8
	 zsPUsWe1iUS1BOVDohqIT5D17oN95pEYXFw3vdDFWsS7KcmlWOPgrY3maI65+qd7Cg
	 kYLgYMqpbl13s9+UhqcER44r5l6TEbe5XfKIJYV65ZRVYCs0n7mt0H5a5tDBIFUXWi
	 83t3GPaBq2yH7KSOY6V9cuk5kJvq2aAiTBHYfKdzcbswErGZ9QawIalc5hycfaTkwd
	 E+7ZdeTUqVL30NaRQ26qkSVjjWisF6AUMaSfJ3L2sj9St9boTCvY3fyM1VxX2p0Y/6
	 QI93ThBykB0Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB029380AAE9;
	Wed, 19 Feb 2025 08:56:50 +0000 (UTC)
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
 <173995540958.515462.3412877819708606425.git-patchwork-housekeeping@kernel.org>
Date: Wed, 19 Feb 2025 08:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add STM32MP25 SPI NOR support (2025-02-19T08:00:56)
  Superseding: [v4] Add STM32MP25 SPI NOR support (2025-02-18T13:00:00):
    [v4,1/8] dt-bindings: spi: Add STM32 OSPI controller
    [v4,2/8] spi: stm32: Add OSPI driver
    [v4,3/8] dt-bindings: memory-controllers: Add STM32 Octo Memory Manager controller
    [v4,4/8] memory: Add STM32 Octo Memory Manager driver
    [v4,5/8] arm64: dts: st: Add OMM node on stm32mp251
    [v4,6/8] arm64: dts: st: Add ospi port1 pinctrl entries in stm32mp25-pinctrl.dtsi
    [v4,7/8] arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
    [v4,8/8] arm64: defconfig: Enable STM32 Octo Memory Manager and OcstoSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


