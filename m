Return-Path: <linux-spi+bounces-6725-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B8A2EEFE
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 14:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81011621A9
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF344230998;
	Mon, 10 Feb 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLu/IuA8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8822E406
	for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195773; cv=none; b=I9qZtUmR+gn8Bu/Ejs+kzsJC94aY4Mm1OZgAvUpCg/xO/jTkdoN+mew5ijJqYxCXEDmkQj3WtGTDgwg1AjIJVuMZUsidp7I45MJQ+DKE46bkofu4NQUmGxVgvAHe6vq0JejMnRwawrFBKM7aSdBQ7KBtO2zxpbD4SrSkmUMwlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195773; c=relaxed/simple;
	bh=yYBKxM33+au/Us86FurF4R91SwgHLUuVKwq5LqnMnsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N3Os6TN6g50FwC1jC/Vv0y1p+PU43w0cR1ERuTQhPKRePSRv573lgunDEFgZMRZLfPhtqBiBtUpVAhZFOuY3b9QAJCq684quZN3t9tf9ul8hRuikXP/G2vS0MWEE+t8DPJiL39YQWvOe6WMsIpBVhlvk4zEMG8Xltn538+QFcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLu/IuA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714A7C4CED1;
	Mon, 10 Feb 2025 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739195773;
	bh=yYBKxM33+au/Us86FurF4R91SwgHLUuVKwq5LqnMnsM=;
	h=Subject:From:Date:To:From;
	b=BLu/IuA8T4VaxLiFtJ8djH+I//hnBCakRxawpyd+gQgyt3IV39cSjTviEquk2++29
	 pjy9VQ/2Pud3rkcBc98MfNeFwuLvh3gUqG4oduTpL7ODcx2pd1m0R1nqdWy5HsIX4I
	 t61VXmjDYQo1gnx7biUTu401jFKpW3ijoaBJA5oaIwJshxTtnbGuqlv3Lp3+GHk99y
	 JLnrcIKGfxpCzVw4ADs52CosmgGShukea8QLggwGWBqKebIwulrioStcCQNH/+yiAp
	 zPlFovDTjUhY3opmnMqx61v7MxTFDx2mnOK71HwY6j18pzvmI5czhe6s16c9QPfBhh
	 +3DaWbi6kuY6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340EB380AA66;
	Mon, 10 Feb 2025 13:56:43 +0000 (UTC)
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
 <173919580184.3768396.3635376241615287822.git-patchwork-housekeeping@kernel.org>
Date: Mon, 10 Feb 2025 13:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add STM32MP25 SPI NOR support (2025-02-10T13:18:24)
  Superseding: [v2] Add STM32MP25 SPI NOR support (2025-01-28T08:17:29):
    [v2,1/9] dt-bindings: spi: Add STM32 OSPI controller
    [v2,2/9] spi: stm32: Add OSPI driver
    [v2,3/9] dt-bindings: memory-controllers: Add STM32 Octo Memory Manager controller
    [v2,4/9] memory: Add STM32 Octo Memory Manager driver
    [v2,5/9] arm64: dts: st: Add OMM node on stm32mp251
    [v2,6/9] arm64: dts: st: Add ospi port1 pinctrl entries in stm32mp25-pinctrl.dtsi
    [v2,7/9] arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
    [v2,8/9] arm64: defconfig: Enable STM32 Octo Memory Manager driver
    [v2,9/9] arm64: defconfig: Enable STM32 OctoSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


