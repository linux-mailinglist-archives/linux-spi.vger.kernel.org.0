Return-Path: <linux-spi+bounces-608-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A662F8372C3
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 20:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431D4B24ABB
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACF3E47E;
	Mon, 22 Jan 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg7IFTeX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C53E462
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951631; cv=none; b=nSkLo7lUT1Fttp1eoW4Y+xbZw6/aNoe3JL+n9fCH+NtAPpUudk5rPzjHgiJCMiJgQ/hrkKPkUJP14iEPpy9F3VYXN1fSV02AjN7vkpc73sx1Tw9rqu+psgcARAR+/EnJnkZLVoGckdYp4RxeuuZtNisLGPLDs+GPSUAPq27Smgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951631; c=relaxed/simple;
	bh=/5rltzpKwvbOkhZOH4wDSPWG9konqXwMWeCm/srq7y8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oHisvUf8eVbH1QTqP3di8yEGeVFoL1+3r1KTy/GPJotScLWl9T1vjvjLEqlmNifv30AO2R5oG0RyQ4Z+zX5HaUqKI+NPDxmHuaorBWzcIhwwFbAhJCNRXOly2f6KgqjBSIBA+bPyHyUEAiyn6qf4yVJAyk2yzmMaaHSdynY9LjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg7IFTeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3175C433F1;
	Mon, 22 Jan 2024 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705951630;
	bh=/5rltzpKwvbOkhZOH4wDSPWG9konqXwMWeCm/srq7y8=;
	h=Subject:From:Date:To:From;
	b=tg7IFTeXwTGctX6Lz5ens63qQmGdKx5DGtcMZhjQGfg7xm8Gu1lIxFWizxmXcBhYR
	 Sc32nMnjgRu3idiwi8zA7gDgjxP5zT8w/t5BgBaoUQOXS/F6hQVmv99DtTbUlYXzvi
	 7tljygTHk2xtw/LYHbk3YVTIJoWeSqlJyDvTsMCiLbKukgmp65vlWskTt5DIRfS56c
	 LyxFkRgsEuU/M4UyqELQRx4PkQLV9V5nOj09FYEFPGJgCsn+af7WDGZNhqXMSRcO/a
	 UHWGlWDcfwJTnQpFWMDQSMWcJznNtmXnuFMkUP6w8LkkNbMdBbte+E/a2AeJPhB/7c
	 vimWPTQwWicjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6D08D8C9A8;
	Mon, 22 Jan 2024 19:27:10 +0000 (UTC)
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
 <170595163076.31397.1423148979492077598.git-patchwork-summary@kernel.org>
Date: Mon, 22 Jan 2024 19:27:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Deprecate register_restart_handler()
  Submitter: Andrew Davis <afd@ti.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=801994
  Lore link: https://lore.kernel.org/r/20231117161006.87734-1-afd@ti.com
    Patches: [RFC,1/5] kernel/reboot: Deprecate register_restart_handler()
             [RFC,3/5] power: reset: gpio-restart: Use devm_register_sys_off_handler()

Patch: [1/1] spi: nxp-fspi: Adjust LUT debug output alignment
  Submitter: Alexander Stein <alexander.stein@ew.tq-group.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=817822
  Lore link: https://lore.kernel.org/r/20240118121016.3734770-1-alexander.stein@ew.tq-group.com

Patch: spi: spi-mt65xx: Support sleep pin control
  Submitter: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=815063
  Lore link: https://lore.kernel.org/r/20240108120802.7601-1-zhouruihai@huaqin.corp-partner.google.com

Series: Add STM32F7 SPI support
  Submitter: Ben Wolsieffer <ben.wolsieffer@hefring.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=798501
  Lore link: https://lore.kernel.org/r/20231102193722.3042245-1-ben.wolsieffer@hefring.com
    Patches: [v2,1/5] spi: stm32: rename stm32f4_* to stm32fx_*
             [v2,5/5] ARM: dts: stm32: add SPI support on STM32F746

Patch: spi: make spi_bus_type const
  Submitter: Greg KH <gregkh@linuxfoundation.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=814620
  Lore link: https://lore.kernel.org/r/2024010549-erasure-swoop-1cc6@gregkh


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



