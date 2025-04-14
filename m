Return-Path: <linux-spi+bounces-7572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB0A87D27
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AF188DEFE
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A25264FB2;
	Mon, 14 Apr 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXF9nIJ6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F411C84BB
	for <linux-spi@vger.kernel.org>; Mon, 14 Apr 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625520; cv=none; b=ZZoxFftSHGadrVIqNp102QGExouWdJuteUPCYHz6YYmJ+2Bseine9100qJXdy27s9DXpzH0trC3aDQ8gNEu7P0ou3+X/mmzlR/tj91Pfc4n5UrSXjvXGlpAomj8xcK7lC1QwatK/5sqgvgHsWecJpPdhFFn/ydj60IW75BtvLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625520; c=relaxed/simple;
	bh=oqzvS1cWE9l6qlNdQPy3BGzI6QbmDw3Eem//LFv6YOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dmE+n04TqouFsIC5U8RzzFKUZ2QQb68R6dsxb0ufo3OkuMqirvMgLyAnDYhG/DEppFRSgDZ1S51Q+0vKz21baiu1aW7ov5tUELPRHRA78eGhMeWfikEKPhodf0z3PHEcRyfalxXMXdZn8tfyaZ0ysavRhIRVQPTgpAtl+ATHIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXF9nIJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC57BC4CEE2;
	Mon, 14 Apr 2025 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625519;
	bh=oqzvS1cWE9l6qlNdQPy3BGzI6QbmDw3Eem//LFv6YOA=;
	h=Subject:From:Date:To:From;
	b=jXF9nIJ68Xs7qoOVcAZZOq3vtXEb1+WGF6NNrYCLs+tDtD2+YTrs6UtdqNYcw3228
	 wH/G0uGGun65B71/zCOEe6lTvcNI0vTzvxnwru4zgeqqsvaQ1QMe+r9QUgWAqRUuwW
	 fyIQU7TPAK/iXwSBZlZ5RxY+24c1df8vEP6YJo7+O0Bs4YRW2e/rpAPC7NVpCjh1J/
	 beTku67D8WrVO9z0UaOfvc/6TV4B1oFc2J7f2Evn1ad0r/iJDfFg0bMLUFs0xQS4HN
	 A/eFDQw9ofrKtnQSQe1hx8MkXgsaE4vsD0q6V2za1Fng9m6e3Sg0qyjhuq8nYI2jJK
	 DFbWdCSL66Hag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B25BD380CEF9;
	Mon, 14 Apr 2025 10:12:38 +0000 (UTC)
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
 <174462555740.1828697.8937781048460018611.git-patchwork-summary@kernel.org>
Date: Mon, 14 Apr 2025 10:12:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: fsl-qspi: Fix kernel panic when unbinding the SPI host
  Submitter: Kevin Hao <haokexin@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=946247
  Lore link: https://lore.kernel.org/r/20250321-spi-v1-0-b9939baa64b6@gmail.com
    Patches: [1/2] spi: fsl-qsi: Optimize fsl_qspi struct

Patch: [v2] spi: fsl-qspi: Optimize fsl_qspi struct
  Submitter: Kevin Hao <haokexin@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=952350
  Lore link: https://lore.kernel.org/r/20250411-spi-v1-1-8d6dfb1a9262@gmail.com

Patch: mtd: nand: Drop explicit test for built-in CONFIG_SPI_QPIC_SNAND
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=947979
  Lore link: https://lore.kernel.org/r/99eef91c334f3f2314c2f5671e1eb55211a5ff19.1743150196.git.geert+renesas@glider.be

Patch: [RESEND,v2] spi: Add support for Double Transfer Rate (DTR) mode
  Submitter: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=952036
  Lore link: https://lore.kernel.org/r/20250410130207.3688117-1-quic_msavaliy@quicinc.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



