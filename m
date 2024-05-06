Return-Path: <linux-spi+bounces-2757-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18558BD0F2
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3751B241D4
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87A13CFA5;
	Mon,  6 May 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phpzu0l0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57897153583
	for <linux-spi@vger.kernel.org>; Mon,  6 May 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007638; cv=none; b=IhjiGNWjtTIratHdL9MrODY4jhILlQEnXtFSrgAjY1QT73/SPT0ROOUVyXlUAYN0VKCgEmuHA7jbkpj+NNDPRVVy2CtcyRt6crSymjgYfYuly73gg3S/uRg99Yv3DPF0feLS75YCuaO7CagxFNluij+nYiFzQ/rjM8uvAeYI8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007638; c=relaxed/simple;
	bh=vnYGBg6zqVVhh9REHPLv8QgnZQ5CMZahtTX5TnKwRxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M4CAYbqAOxGiK/t6cS7J3iFoc5Bd4KCXoDtO2N690sgiW4A4MUcAfxR4k7GbHhJQOd35E3I6tXTmJ0yBGRWGG7ZUfuDxpUrM4DfFXQ0cfn82ardg8vzQxNBGfGskBJsHv3DcL1ar/HKSpqr9vbySNbRLVJ0QyiWMnhMPr61KEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phpzu0l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF8B3C116B1;
	Mon,  6 May 2024 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007637;
	bh=vnYGBg6zqVVhh9REHPLv8QgnZQ5CMZahtTX5TnKwRxI=;
	h=Subject:From:Date:To:From;
	b=Phpzu0l0ZAY+tA+T4lSdszecvjPlSfS6YQS3ZZq8ct36HnTEX/++dpjjBB3oEpE7V
	 qnEnbUwyjhl/5nvjwe4048doPrLndASS9uwdQ9Ot4muJFT6gnop/XqnBlqzqY1qosK
	 LrEVnYU+oDLQt5bClfVOyCpEebmWmyeIgsv0nf8uETpY/WJfdafPUynRBrYATuiK+d
	 3WQXsHPy2K3M0+vRtiMxeeevXFy9JLaTG7taaYSxxn77kXh8PWbV2VbWZ/P+HeR3rv
	 rgPjV9fFHQOCn3XYFVna0uSHTSqQ/q/8JeHOvNk+ul9I664o2R4xACGcK9GxVQoBJn
	 yNIBOrVtMnRmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C818EC43334;
	Mon,  6 May 2024 15:00:37 +0000 (UTC)
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
 <171500763775.4736.17573017872091529712.git-patchwork-summary@kernel.org>
Date: Mon, 06 May 2024 15:00:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: pxa2xx: Cleanup (part 2)
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=841169
  Lore link: https://lore.kernel.org/r/20240403171550.1074644-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/5] spi: pxa2xx: Move number of CS pins validation out of condition
             [v1,2/5] spi: pxa2xx: Drop struct pxa2xx_spi_chip
             [v1,3/5] spi: pxa2xx: Remove DMA parameters from struct chip_data
             [v1,4/5] spi: pxa2xx: Remove timeout field from struct chip_data
             [v1,5/5] spi: pxa2xx: Don't provide struct chip_data for others

Series: spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=845407
  Lore link: https://lore.kernel.org/r/20240417110334.2671228-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/9] spi: pxa2xx: Allow number of chip select pins to be read from property
             [v3,2/9] spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
             [v3,3/9] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
             [v3,4/9] spi: pxa2xx: Remove outdated documentation
             [v3,5/9] spi: pxa2xx: Don't use "proxy" headers
             [v3,6/9] spi: pxa2xx: Drop struct pxa2xx_spi_chip
             [v3,7/9] spi: pxa2xx: Remove DMA parameters from struct chip_data
             [v3,8/9] spi: pxa2xx: Remove timeout field from struct chip_data
             [v3,9/9] spi: pxa2xx: Don't provide struct chip_data for others

Series: spi: dw: Auto-detect number of native CS
  Submitter: Serge Semin <fancer.lancer@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=847500
  Lore link: https://lore.kernel.org/r/20240424150657.9678-1-fancer.lancer@gmail.com
    Patches: [RESEND,v4,1/4] spi: dw: Convert to using BITS_TO_BYTES() macro
             [RESEND,v4,2/4] spi: dw: Add a number of native CS auto-detection
             [RESEND,v4,3/4] spi: dw: Convert dw_spi::num_cs to u32
             [RESEND,v4,4/4] spi: dw: Drop default number of CS setting


Total patches: 18

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



