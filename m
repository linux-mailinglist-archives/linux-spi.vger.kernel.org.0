Return-Path: <linux-spi+bounces-3055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 381BF8CD7FE
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 18:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B807DB2297D
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F0BE78;
	Thu, 23 May 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE63SNT7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB7AD48
	for <linux-spi@vger.kernel.org>; Thu, 23 May 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480038; cv=none; b=htQv5Vc1xwH0U6NnbKEjTsAquVxDY2izmX++JDuXVOgo88HxSuoXLZa9VfXkqlaKtoSJxCGx7/YbESOF/phg93slDvmO2uDIultlFB88QBy5PCkPIMTGWOJLRqRDN5EQFsrBIOAMfhNMGhHGlvt30t4UQ2jfaMS8OmBCHbGHChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480038; c=relaxed/simple;
	bh=44MYa9s8TWj0pSViT/DfVN9Yd1T+i6P+FKuhcLF/Gf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JN0OOvnxmr1nuqCeaACSSmvT3ca9jqnBV0TwiBXbr4KvU084fKnyD6690wtMgzt44Qg4i5tI8MOgTbA4QQ0ZSA2Xts0G98gPPk9KzV8k/h0N6O6g9BL/lF9kpul9qt7gkSS6XBGvX0qzOpXtz7Juv1aJmzv5KWoMiLan9Dnif/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE63SNT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3A58C2BD10;
	Thu, 23 May 2024 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716480037;
	bh=44MYa9s8TWj0pSViT/DfVN9Yd1T+i6P+FKuhcLF/Gf8=;
	h=Subject:From:Date:To:From;
	b=nE63SNT7Sb2c+UbgZ5j3iFHDPySRYndzb+2X9tJv87aEkwNFCWKUa8sf5tFXOR2DU
	 LM3zzWO2xK17LmlUP7hNl3PzbRow08J/VXVCw5eN8LiQqlXiJ86rBUswgZ2iYc1IDe
	 w7+p5UX6QqeOzisrkxpnv8dswQUTrMukJBJ2mtI34vZl7GAfHZYUFgjwqTbGIbiU+4
	 n7monVcy0wfgcsHMy0jL6Th/VFzBLnVhTarRXs+w8kT0sx9Bg3QCMWR++cEIsOh0S5
	 eqD1WDkgGeajq1MO4yorCoxrIoa0G3gK6XQUS72zFb0Wx00TkP3xnxLagydcDKrGB/
	 h5yO2cozmoKyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D6F8C43617;
	Thu, 23 May 2024 16:00:37 +0000 (UTC)
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
 <171648003750.9972.5214585992324644379.git-patchwork-summary@kernel.org>
Date: Thu, 23 May 2024 16:00:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: pxa2xx: Move PXA SSP bindings to the correct folder
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=854072
  Lore link: https://lore.kernel.org/r/20240517171103.221856-1-andriy.shevchenko@linux.intel.com

Patch: spi: stm32: Revert change that enabled controller before asserting CS
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=855286
  Lore link: https://lore.kernel.org/r/20240523103326.792907-2-u.kleine-koenig@pengutronix.de

Series: soi: Don't call DMA sync API when not needed
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=855095
  Lore link: https://lore.kernel.org/r/20240522171018.3362521-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/2] spi: Don't mark message DMA mapped when no transfer in it is
             [v1,2/2] spi: Check if transfer is mapped before calling DMA sync APIs


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



