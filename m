Return-Path: <linux-spi+bounces-5065-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DC598AF74
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8D6B24282
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A382187352;
	Mon, 30 Sep 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1C9iKl9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695818734F
	for <linux-spi@vger.kernel.org>; Mon, 30 Sep 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733030; cv=none; b=W5i1D96oj8OQ0M7i8nF32SwFSdlbJDk/69CFIf3408elRmIQppkrlO+s63tqjRpL+6E6w0Y2NJ0oAhYq+mb+mcie/Vt2wsn3z2keP6p6ikfDEYh0V25GBGKKthhFNTSRJQ2LG7ds+2AuI+2wnEttoTp/9pm+Lfa8qGuEM80QyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733030; c=relaxed/simple;
	bh=Aak/cIOP4wPG1vJUtyQtftqgnAaM/hMHUaSpJRTTAD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N1c/9pec7eyd+rLD5frtuPgTLdBmojUn3jcIMM1Oi5MrD7u7FAUQPqKbqr+X5iam0Nq2oESeXlX6EZWtijQLtEthCtLrrnACVM4guyhFceISagWtKv19KbbmaugppXb01glhOyxuZY9mw1PNWpkAZjuAcuod9xJdXJP8huTrRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1C9iKl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE26AC4CECD;
	Mon, 30 Sep 2024 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727733029;
	bh=Aak/cIOP4wPG1vJUtyQtftqgnAaM/hMHUaSpJRTTAD8=;
	h=Subject:From:Date:To:From;
	b=s1C9iKl9nGJqYuG4e1jdq1U6QvY4gQ3Z+nVoc37QY2wuTBN0I2YxPyo8R4qNZYAWj
	 idgUaxjdoScbbYo31EuaHjHryjLmFBYeM9NffO/Xt1szOeY3v2s34gX8ee4QVbr9w8
	 2k9mszn8jurt9m/X1DhE9u3alPmEV1XkRMUJUed4MxLWu+yeamb2bwMRGUNk1MZRjR
	 uUDZ/U/n6i/WMHF/tMN/HX9akl7blRZ7e6xMu9YEFhdyK6ZP/0aybVAXHOmEp5wzTZ
	 JLeQ2yhyBayLd3NC22Z9TjdAf3Rs21w9qyE3mo9DEoJdcXWER4IfrDxU93V+X65oqX
	 zv3h0JlOwQznA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 008DF3804CB9;
	Mon, 30 Sep 2024 21:50:32 +0000 (UTC)
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
 <172773303155.3980850.7131908363612405898.git-patchwork-summary@kernel.org>
Date: Mon, 30 Sep 2024 21:50:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: atmel-quadspi: Fix and add full CS delay support
  Submitter: Alexander Dahl <ada@thorsis.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=891104
  Lore link: https://lore.kernel.org/r/20240918082744.379610-1-ada@thorsis.com
    Patches: [1/2] spi: atmel-quadspi: Avoid overwriting delay register settings
             [2/2] spi: atmel-quadspi: Add cs_hold and cs_inactive setting support

Patch: usb: Switch back to struct platform_driver::remove()
  Submitter: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=892765
  Lore link: https://lore.kernel.org/r/20240925113501.25208-2-u.kleine-koenig@baylibre.com

Patch: [v2] dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI
  Submitter: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=892767
  Lore link: https://lore.kernel.org/r/20240925114203.2234735-1-amit.kumar-mahapatra@amd.com

Patch: [v1] spi: fix typo in the comment
  Submitter: Yan Zhen <yanzhen@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=890370
  Lore link: https://lore.kernel.org/r/20240914095213.298256-1-yanzhen@vivo.com

Patch: spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=887484
  Lore link: https://lore.kernel.org/r/20240906022828.891812-1-ruanjinjie@huawei.com

Patch: [v3] spi: airoha: do not keep {tx,rx} dma buffer always mapped
  Submitter: Lorenzo Bianconi <lorenzo@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=891932
  Lore link: https://lore.kernel.org/r/20240922-airoha-spi-fixes-v3-1-f958802b3d68@kernel.org


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



