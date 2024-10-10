Return-Path: <linux-spi+bounces-5193-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7FB9984CC
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA0B217BF
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F11BDA9C;
	Thu, 10 Oct 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maSilgGq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FA1BBBE5
	for <linux-spi@vger.kernel.org>; Thu, 10 Oct 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559231; cv=none; b=LDFYA6dz76lqTn6neiGgqr5489CCeddKTzALunxVtzjdWbvAs1t804QwRNtSOWoJbO1Kmku/Mh4QsBJY9GMLBDXPvp48YDoq00ijGO7FFTTDoV09C9HPo6YFFQc0EJSoBAlNhx2lX0bUiaELhHF60mGEF9z21S4x1Ps7dxXIdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559231; c=relaxed/simple;
	bh=NOCLz+X7Q1P2uq9m1ISiR0sdAZo885at9YAeG1fmasI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bqdeUu9ovAOqFclR7HMTlS7TxTfyMd+pFPbubGkhseatrt95AKruD61+o2nZkg9aWu2P1S0CIyyJmZsnB7Fgn9Vr5mQugaaCcHRKqpKPzPYHVZz/ESSuC56kxT2kYe7i1nAjVkirz/ZJ95EblY7gHwakfbVFgptHeuFqnmKYT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maSilgGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A77C4CEC5;
	Thu, 10 Oct 2024 11:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728559231;
	bh=NOCLz+X7Q1P2uq9m1ISiR0sdAZo885at9YAeG1fmasI=;
	h=Subject:From:Date:To:From;
	b=maSilgGqGElYid+0KvolViaiw0zn+GZFuRau7Yle+71EH7x6auwEOhv86q3wdMm2S
	 e+MPuEdzgpUSMbf4nCMUgRLrUTWi/a+ALszeHF8jmoJ2P3SnOsSai688uEIk1sbOkk
	 Tu7lwP9ObklnnRfVP2AC+6ESI0tEW+pfWyxkMn7aySuvqjsN2CfXDDiYlROu+IVHD/
	 SRJ+CKFRV59Ssln0st6Dy3gzBuizA9sGOfkTkfoYgttG1sq6+3QqipUPvOTasXmVWo
	 oZADANoJ3mvWW4d5Z6s5IW0o6AZcXRBOT0WrdsF0TAV9xrXwM9rOJh5B52BP80qnoy
	 mKll47KOZPloA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7622B3803263;
	Thu, 10 Oct 2024 11:20:36 +0000 (UTC)
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
 <172855923500.1984107.6182856823393979663.git-patchwork-summary@kernel.org>
Date: Thu, 10 Oct 2024 11:20:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: spi-fsl-dspi: Fix casting warnings
  Submitter: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=896501
  Lore link: https://lore.kernel.org/r/20241008055644.4900-2-hardevsinh.palaniya@siliconsignals.io
    Patches: [v2,1/2] spi: spi-fsl-dspi: Fix casting warnings
             [v2,2/2] spi: spi-imx: Fix casting warnings

Patch: [v2] spi: intel: Add protected and locked attributes
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=897011
  Lore link: https://lore.kernel.org/r/20241009062244.2436793-1-mika.westerberg@linux.intel.com

Series: Add dev_warn_probe() and improve error handling in Rockchip SPI drivers
  Submitter: Dragan Simic <dsimic@manjaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=893723
  Lore link: https://lore.kernel.org/r/cover.1727601608.git.dsimic@manjaro.org
    Patches: [v3,1/5] spi: rockchip: Perform trivial code cleanups
             [v3,5/5] spi: rockchip: Use dev_{err,warn}_probe() in the probe path


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



