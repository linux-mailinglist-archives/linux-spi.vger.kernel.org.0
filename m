Return-Path: <linux-spi+bounces-1295-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5552851849
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 16:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4437B1F21B4F
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1B3C48F;
	Mon, 12 Feb 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL2uVHcy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F725740
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752428; cv=none; b=AomN0K3I1PKZIFSFk438+qHGmlxs+UZIWmMd48T8yNA9uTlnNYkbE9TXaxL1xHu/MUfq1gZuAFGiMhRS5PydZzfl9oXBU/hSGOS+6ZvCF9LWzD8999fSh8blRdw9KKtjiWPQwkqIbJscIw9kQAKWnZ/NPmZV1HGNzBzHLtvLx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752428; c=relaxed/simple;
	bh=uYZmuA3FUtPCnef/LsoREd1+58UuKZ32xfGPLGUQUyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=b2bmFbeIb4ekhe1VtWG2U/dFlH2uM76gLJH/OkIVb6Bmj6WJP1n3+p8Lj0G3fVNM4mQJsJ+rDtI2VxmF9b+5zq1xXiiScT356p+x0CTHbli3+3+vjCFNn5n+Ga7v1OxWS1FtolBPHs8f7uKJ7WCjnV7X/pCNaXT9/k5JhqbMXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL2uVHcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9828DC433C7;
	Mon, 12 Feb 2024 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752427;
	bh=uYZmuA3FUtPCnef/LsoREd1+58UuKZ32xfGPLGUQUyI=;
	h=Subject:From:Date:To:From;
	b=kL2uVHcyUSSCxTRrWE6lPvs22rYmnVaom4y1YMzawf7dNPZPHcBYM+hG8Px8tg16g
	 qI9sGBWAW2cmoXlASNugGQ31+C1/+6NfVa2+AUniQBOjGq6w23VIXxifzOw6qu6PV1
	 EVw1+cUcK6QOta2EHC8ywS/kBeCXZwysN5juUhzEKypJoGsgWCgFkVh47pS/5h9s7A
	 mxWdcvHne9OM4rfGsaqmWZlGrmKxF5bCdi4Y8M/k/68hQthsVk3OAeHJHb1ejZK3qe
	 1UhIOP2o3xPY8zpgkrzm6r+fl0SEOubXtJYt1owbmG/rPnJ41leA1uc+rm+TC0HwHK
	 CN66w7BSzNPcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74D94D84BC3;
	Mon, 12 Feb 2024 15:40:27 +0000 (UTC)
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
 <170775242740.29829.7692727061190715325.git-patchwork-summary@kernel.org>
Date: Mon, 12 Feb 2024 15:40:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: intel-pci: Add support for Lunar Lake-M SPI serial flash
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=825116
  Lore link: https://lore.kernel.org/r/20240212082027.2462849-1-mika.westerberg@linux.intel.com

Patch: spi: omap2-mcspi: Revert FIFO support without DMA
  Submitter: Vaishnav Achath <vaishnav.a@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=825191
  Lore link: https://lore.kernel.org/r/20240212120049.438495-1-vaishnav.a@ti.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



