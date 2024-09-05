Return-Path: <linux-spi+bounces-4697-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9496E5A4
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4111C2353A
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665D197A9F;
	Thu,  5 Sep 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMVjCPGv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD214B95F
	for <linux-spi@vger.kernel.org>; Thu,  5 Sep 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574229; cv=none; b=tlPpQLA0xdzOCFIoZ3NAvsNnQMENG5UPS8pPcVRT10+3wmcr02xiPWn0VdiPxwAxrH0zMHmOZNqdWX+bfO5aiQKdXkpd94r3SSkuOPFPY6eFgKw6P+VMyppdoUD93mrcfW5v6fKfcIB7CLRim8vzBSQtRKJnvkAmao+cha6dXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574229; c=relaxed/simple;
	bh=1WOekKqFTwfAa7FxG/AJVpEauEGdJw9pzfBC68BWjNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hWes7XBiUnfdDtF6jUcptiSzKlw85oEXOJs5DUzlJQfxgH2S1Q/l4+HBQ2PtN/AO93tWsLqkI08IRWIPzLeLYCYI664iSLkSdzeFCfQGbn9jFdD/Qb5dMD6zvYFD1dyvMLhFOVAKARaGij45tLOWOfBZrKtHPx7HbFdCeLSYDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMVjCPGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EA1C4CEC3;
	Thu,  5 Sep 2024 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574228;
	bh=1WOekKqFTwfAa7FxG/AJVpEauEGdJw9pzfBC68BWjNg=;
	h=Subject:From:Date:To:From;
	b=cMVjCPGvWKzd1INCw/TfeaF/jnrb8a3wPnDxwwZX7qhPzGim7deURJLZtCsYPj3dN
	 HUivY05FUNrgRRRJ61In5adbbGaG79lPeDLhP88HYdDgUjunTTEf82Hx5G4Ue6HWsu
	 g5z8eOIM0zszwAjebMkYTayPXG4mRs9Bn2UiFD7IBwxDshfo4pzWO8Eh+IY5CRmYwt
	 eBYvNvqfguo62nQaUpEjuilw9a7SvtlDiUXOk99yVETRtCYwma+lY8924eip+syP6C
	 s/GdZtNjyLoh5ANP8VkPVOuiagg6WHfhmYpn8AeL0x3JDuXSJma4lP79ja3hlSzRAd
	 +rwdBvozvSPuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79ADB3806654;
	Thu,  5 Sep 2024 22:10:30 +0000 (UTC)
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
 <172557422898.1859883.3709015599090347881.git-patchwork-summary@kernel.org>
Date: Thu, 05 Sep 2024 22:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: fix the flexspi error on imx8ulp
  Submitter: Bough Chen <haibo.chen@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=887164
  Lore link: https://lore.kernel.org/r/20240905094338.1986871-1-haibo.chen@nxp.com
    Patches: [v3,1/4] dt-bindings: spi: nxp-fspi: add imx8ulp support
             [v3,2/4] spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
             [v3,3/4] spi: fspi: add support for imx8ulp


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



