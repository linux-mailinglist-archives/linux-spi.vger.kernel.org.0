Return-Path: <linux-spi+bounces-616-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD1837EBF
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 02:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B6E297C6E
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4E13B782;
	Tue, 23 Jan 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndoMfyCf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EB12837E
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970762; cv=none; b=OK9n4n1xnzHFAbF7Z0DKALQZCRNtZPmgLhW9+dvlEhz1bBa+w7/nm7mwRL4vD7ECo32gU52/wNJCLNKIs0oWR0KBnaDECICs/MovubHXheKqFP43hG5g05hf2oB6FY4DuTmi08o0lMgaSJoQQ9oL80Z2HuYLpI1+X062+TVpx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970762; c=relaxed/simple;
	bh=pF8fR7RAjOYP/LXnL9h1EVC9EEWk1w7KLwUt52wl8dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FpqYD6yYhxhEXRepC72k15dpCKOl4JarFbsPRPRDQBtd/mx/5Ye8bi2U7DRRUgoPKwN7JLG6jAlxLHbRAvnKfrQyv8WsskpYQy7XLFAfci/gCfueICM8PMaZsKgT+nUA/kStA0k5iZofKyolFhL0X9uj72o8iHo8MOmdC9O893M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndoMfyCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39B26C43390;
	Tue, 23 Jan 2024 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705970761;
	bh=pF8fR7RAjOYP/LXnL9h1EVC9EEWk1w7KLwUt52wl8dk=;
	h=Subject:From:Date:To:From;
	b=ndoMfyCf7sJ/qyJeDDV52nHw2Jfy5/LV2jmoD0uq40VIXAIyL7vcqNM6CSc8k8i5u
	 oFaQ9uesBUZ7aEWQ8/7ezadAUPdrU9gnDBYMNehQsoAWOV8R/6MsKKobULVuYaii93
	 NtCQrRH7gMxu2nKsh+i0iKnOBNdIrFJrBDlj7aQHGnc8RfewIvRDExev0cyA4TsAOo
	 YJ2T2Uu2YL4kSr0o7l0WyqCPNHbjOU8NcM35HMSqEnmO7m/Fukv5gmn7RE3yFX1UEh
	 JF9JrlwydtjaK6FsOuZpKWVZx84JdQj91J4c+Tcv+6hrBgchu3cO72boo/GJL9fDvS
	 JMqgjWAyCJ2MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 261CFDC99E0;
	Tue, 23 Jan 2024 00:46:01 +0000 (UTC)
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
 <170597076115.27993.17295495518282254628.git-patchwork-summary@kernel.org>
Date: Tue, 23 Jan 2024 00:46:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: intel-pci: Meteor Lake fix and Arrow Lake PCI ID
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818593
  Lore link: https://lore.kernel.org/r/20240122120034.2664812-1-mika.westerberg@linux.intel.com
    Patches: [1/2] spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list
             [2/2] spi: intel-pci: Add support for Arrow Lake SPI serial flash

Patch: spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro
  Submitter: Sam Protsenko <semen.protsenko@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818307
  Lore link: https://lore.kernel.org/r/20240120170001.3356-1-semen.protsenko@linaro.org

Patch: spi: Raise limit on number of chip selects
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818416
  Lore link: https://lore.kernel.org/r/20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org

Patch: spi: bcm-qspi: fix SFDP BFPT read by usig mspi read
  Submitter: Kamal Dasu <kamal.dasu@broadcom.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=815537
  Lore link: https://lore.kernel.org/r/20240109210033.43249-1-kamal.dasu@broadcom.com

Patch: [v2,1/1] spi: spi-imx: Use dev_err_probe for failed DMA channel requests
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=815653
  Lore link: https://lore.kernel.org/r/20240110085403.457089-1-alexander.stein@ew.tq-group.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



