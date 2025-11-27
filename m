Return-Path: <linux-spi+bounces-11642-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACAC90127
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 21:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48B7C342790
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71313305E09;
	Thu, 27 Nov 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYciBtoK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42F30507B
	for <linux-spi@vger.kernel.org>; Thu, 27 Nov 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273601; cv=none; b=VvPvSsFsgTko9shVg1EkQdAx1Qe9nwC/wGijyuSiWEYVrQ81ePoPoQk2bYyTQMVn8Cohx0iYuMz0N5AH0Cg9n+CJSqHrC4rUO+Ds2JHMDSg9kAUqg3k10Y3izHu3ANCcWamgEYWT1dW7XIL4hy3dQBbWuiegXbnzHkO16AHJcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273601; c=relaxed/simple;
	bh=C30n4yqxME8Aa9G99evU05o6c03CHI94F+hn5blT//Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kZ5pebHJhWE7e5Vap45sq4hcQTc1el1KYwYasjSjCPF4kDImnrJOoeHhxQ7RCE+SoqHRgnQrnb6H9D7CnE1ODNUzwzfLfE2+iC2EiSNHpmAU3OE485EShYMkAqCDQgXCD3N5rxDoaZcU5tyR1taZt/OfsOOVvElMYm3x/wKVgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYciBtoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D002AC4CEF8;
	Thu, 27 Nov 2025 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764273600;
	bh=C30n4yqxME8Aa9G99evU05o6c03CHI94F+hn5blT//Y=;
	h=Subject:From:Date:To:From;
	b=TYciBtoKm6tYyC7BX4tIOwLGwRPWOrqgMtyG1fBypRxUJBdjBD2tPc7rJpaChcOlP
	 KCO+BaOBsQVFTMAGAlxlpRfwSilLOnC48inq1T7LVo/p/fAapTBdr52VQgNSQx89Xs
	 9Z2vc3g6khcfU7sOkGWPDNSdThs/JosRuhZFjPox/6nXEJSkxQK6JVPRUIWn2dxeQV
	 fchciO72/xlZSQ1E8x9wVGfJm5Ifec8V3Be7Ov4abCwgDe1inu/oCttJ/WSdoyNqE2
	 NNiesg/LXl3HX0lTat5J/Diq8tSLCuAaQmqkyQjL3yYnkPox2qf3SE98NGBwMfdMfR
	 4/OHe+ZfMzYmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 034AD3808204;
	Thu, 27 Nov 2025 19:57:04 +0000 (UTC)
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
 <176427342347.17501.3355693924161858106.git-patchwork-housekeeping@kernel.org>
Date: Thu, 27 Nov 2025 19:57:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: microchip-core: Code improvements (2025-11-27T18:58:57)
  Superseding: [v2] spi: microchip-core: Code improvements (2025-11-26T07:54:41):
    [v2,1/6] spi: microchip-core: use min() instead of min_t()
    [v2,2/6] spi: microchip-core: Refactor FIFO read and write handlers
    [v2,3/6] spi: microchip-core: Replace dead code (-ENOMEM error message)
    [v2,4/6] spi: microchip-core: Utilise temporary variable for struct device
    [v2,5/6] spi: microchip-core: Use SPI_MODE_X_MASK
    [v2,6/6] spi: microchip-core: Remove unneeded PM related macro


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


