Return-Path: <linux-spi+bounces-11281-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F99C6B577
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 20:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B842135C7D3
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49E2D0625;
	Tue, 18 Nov 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeyyFFd/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498527B4E1
	for <linux-spi@vger.kernel.org>; Tue, 18 Nov 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492732; cv=none; b=hI9GHfkanotWt9i0b7GssmOz6hPYZhqsl73Tj3zV/DcNVWInllLmmpdQXR8YqSoVhl1E5ekVHgq5VRtOWve5Kfc+i53zR86ppe1nL5OfHU7q+gjG2/CzgIjAeadGRwJEernVo0T/xhpZ3kelN5/+Jfn4vFedyjB+rQQDOJaQtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492732; c=relaxed/simple;
	bh=R/YowguZPPTn4St2pMAVF48hONbZX/UsJUVCnWx8WxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=esfYknqY3SCBXyQBDmrztTVxETushmPp5ENvxOM6m2g78Eg3yDvphBWQw+ePHVwKLPI2wuw/UL3svtuhQBFuTA6i41s3BnuzUWQtPE7QuKiLRWZp2vslYAulLbkKWIx3ZlVvjsogT0owcPnrNRjGK0EJObHaVPQZ8wsAeXHs/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeyyFFd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8F8C2BC87;
	Tue, 18 Nov 2025 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763492732;
	bh=R/YowguZPPTn4St2pMAVF48hONbZX/UsJUVCnWx8WxQ=;
	h=Subject:From:Date:To:From;
	b=oeyyFFd/qaLjPPLBSYIaJeaFM0BdNHZXpN7k6xB5OvFMHbkY9ywsfDqri4gW0wPMG
	 OSuDVx4LLO7YBliK1JakJemFOhhZ+hrm+oTXGLjWT2nXNYDplBRGbQhhJQpsRGmsGp
	 zCMZKA8Ly10Z8heOSGVptPROovPe8EIBGxNexdpPgVcwsKOfhOvJEyNKLM6RC89l/k
	 0qF0gkVVr1MSJEMgbUgLYJItNAu581ect5IX4mJ5bkUpGhXuCv884UKiD5xuvHDejS
	 rG6MQ/ilJeE9mzYEa1StY//XlukMhFducE4hRXZ0m3YvgeyHHY/BLeMm2fIh6v1vQm
	 7/vNFZ2E6Q3Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B16A03809ABF;
	Tue, 18 Nov 2025 19:04:58 +0000 (UTC)
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
 <176349269722.70698.14032366213472142991.git-patchwork-summary@kernel.org>
Date: Tue, 18 Nov 2025 19:04:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: davinci: remove platform data header
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1024372
  Lore link: https://lore.kernel.org/r/20251117-davinci-spi-v2-1-cd799d17f04a@linaro.org

Series: spi: aspeed: Add AST2700 SoC support and Quad SPI handling update
  Submitter: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1023439
  Lore link: https://lore.kernel.org/r/20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com
    Patches: [v2,1/4] dt-bindings: spi: aspeed,ast2600-fmc: Add AST2700 SoC support
             [v2,2/4] spi: aspeed: Enable Quad SPI mode for page program
             [v2,3/4] spi: aspeed: Use phys_addr_t for bus addresses to support 64-bit platforms
             [v2,4/4] spi: aspeed: Add support for the AST2700 SPI controller

Patch: [v2] spi: bcm63xx: fix premature CS deassertion on RX-only transactions
  Submitter: Hang Zhou <929513338@qq.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1023993
  Lore link: https://lore.kernel.org/r/tencent_7AC88FCB3076489A4A7E6C2163DF1ACF8D06@qq.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



