Return-Path: <linux-spi+bounces-11518-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90008C85D06
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E38DB34D4AD
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DA22A4EB;
	Tue, 25 Nov 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIDrwo7G"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354C18A93F
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085329; cv=none; b=BKuKTta/ahJjaRVoEQNSCLjC5nSgQzSnHagtsTaeVWIjH1QmHDxANrOBnXOCx1PpG1MKAO0ryZVqIDRVBaE8OBdfu91r5mxYLUQrQ2KwsGPPaV8BORbd0EVsiR8bNvL4dIbgZh/HkDM6ULnvqq/DyH4fEmrPjF8CjPxItPthCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085329; c=relaxed/simple;
	bh=pGHbz/eH+XIIzyPgstWZp9dmFnGlHzcCANeCZ/YPMnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nuZH+w0EkFNRh97UWghgbeB1iybCqDEhjItTYh1feXYhgEt+iXYxv+/UICj9lvf35VaSxI9clEsJAFcYsfNUZq1NF4kgzBrvEyYZLtLBSZPPNfZd7EqJV1tZI4p9mQgqYtTrFQ/Ce4x1dsx7DUdaOov5QPfKq7LcyBLaxG9hyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIDrwo7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C50C4CEF1;
	Tue, 25 Nov 2025 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764085329;
	bh=pGHbz/eH+XIIzyPgstWZp9dmFnGlHzcCANeCZ/YPMnU=;
	h=Subject:From:Date:To:From;
	b=BIDrwo7GAWxOWlxkuPNWZJfr4nUbP2Cugtg2NL5JG03bJw42j0df7wGGPi81ZpJMC
	 S1o12eyC8GaPyTJtYwjSIZYqlcg4tk1kOY87WFcUMN02vvaOzIQI1xFlNrFtm2HSyG
	 oPc0dZlLhXe7MX6QDfFbyR5cZQrMehIyux/PDKwEzcSRFXmTauDV+v7EixAwY+xXOh
	 Pur/Q+L5sbGn5jwSxjNS87A69qO9yYjNKSpcsdmQhRtgPrhsJ5FWAQMPqCPgSvLSjZ
	 rAMhmsmGy57SZzZJPCQCHbiXuttn3kPttEV2k1sf50YDFIVEM7N9z+kztsixPUmn+1
	 vmtaj/TOTU6/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1A43380A944;
	Tue, 25 Nov 2025 15:41:32 +0000 (UTC)
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
 <176408529131.810393.9119781522413201195.git-patchwork-summary@kernel.org>
Date: Tue, 25 Nov 2025 15:41:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add RSPI support for RZ/T2H and RZ/N2H
  Submitter: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1025424
  Lore link: https://lore.kernel.org/r/20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com
    Patches: [v4,01/13] spi: rzv2h-rspi: make resets optional
             [v4,02/13] spi: rzv2h-rspi: make FIFO size chip-specific
             [v4,03/13] spi: rzv2h-rspi: make clocks chip-specific
             [v4,04/13] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
             [v4,05/13] spi: rzv2h-rspi: avoid recomputing transfer frequency
             [v4,06/13] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
             [v4,07/13] spi: rzv2h-rspi: add support for using PCLK for transfer clock
             [v4,08/13] spi: rzv2h-rspi: add support for variable transfer clock
             [v4,09/13] spi: rzv2h-rspi: add support for loopback mode
             [v4,10/13] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
             [v4,11/13] spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



