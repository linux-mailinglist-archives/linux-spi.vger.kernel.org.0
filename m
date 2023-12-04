Return-Path: <linux-spi+bounces-131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B5480392E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 16:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D471C20A6A
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526E2C876;
	Mon,  4 Dec 2023 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/fjcjt9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4392C18A
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 15:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAB6BC433C8;
	Mon,  4 Dec 2023 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701705040;
	bh=WRAirgKWIuIBrIrJrvzoQK6VPm2geb3sxSlm8+x//4A=;
	h=Subject:From:Date:To:From;
	b=S/fjcjt90Qr0Ra3W9A2UBd+50hIvwkqmb3Mz1k6et8bH+ek0cMtCbwUWeSF5HnOy/
	 1835NrChVcJTKtiafUYa9jf6WRQZVPJCHLngUNAbyDWkLBOwLBq5ywMoFV9OEkDCuh
	 nBvw5yy0svXtXqn6QqnpYUdHa3oOiGnwFRUWcQb1cO3LvAdO0ESxzW2YbZ+las+OeG
	 NqA5RqFi57euuEtTSo1I3xnEppaV5FYCUg1WeVUa4bZrYqbAXcmZLdIE0zpyy673US
	 Wcz5SnnkvP/P+dmsQSl1uMwzB8wmZ9KcCL3SNskX3Nwbj+uy1yDEQLM9dFhhhoU0+w
	 mQJjlCSh6wplw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3469DD4EF1;
	Mon,  4 Dec 2023 15:50:40 +0000 (UTC)
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
 <170170504058.7858.12969906804739818662.git-patchwork-summary@kernel.org>
Date: Mon, 04 Dec 2023 15:50:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spl022: fix sleeping in interrupt context
  Submitter: Nam Cao <namcao@linutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=805351
  Lore link: https://lore.kernel.org/r/cover.1701274975.git.namcao@linutronix.de
    Patches: [v2,1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
             [v2,2/2] spi: spl022: switch to use default spi_transfer_one_message()

Patch: spi: cadence-quadspi: add missing clk_disable_unprepare() in cqspi_probe()
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=805141
  Lore link: https://lore.kernel.org/r/20231129081147.628004-1-yangyingliang@huawei.com

Series: [1/2] spi: atmel: Do not cancel a transfer upon any signal
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=804442
  Lore link: https://lore.kernel.org/r/20231127095842.389631-1-miquel.raynal@bootlin.com
    Patches: [1/2] spi: atmel: Do not cancel a transfer upon any signal
             [2/2] spi: atmel: Drop unused defines


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



