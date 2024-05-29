Return-Path: <linux-spi+bounces-3127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B58D3A60
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979E3B2696E
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559B17DE18;
	Wed, 29 May 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH7Ljfx1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E315A861
	for <linux-spi@vger.kernel.org>; Wed, 29 May 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995429; cv=none; b=QSr1M2NccFQhs+ZVI0Aq5InvEe42HuUUzYsHAvHdqLcwtzGSyuxggBUqNt44MpTDPSbtUo1ZDFdcCnPsu4wzJ0MK5dwGqX9TK8R9msQxKpZyvRY6Eh0WPELYIwrQmt2hq0fjTvaNBkrq2YWrJiVN5c3HHX2Vw6kkI9XO7w2tjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995429; c=relaxed/simple;
	bh=XMcqWPab/mPyAANto5jeUF7NKRg1t3LCcsUioRPFDIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FTVI07EvAv26iKoMAWe9OUgA1AfTsRSUOo8Su45GQHlS6RnuU5psK/vJLwGRfTcC+nnd/pkhOhneybp7KE9OUXPieezidux0Y3Vm6MpICGBq6d8C2dyt3SKtcTlB9+p3Mgq6QN/3mT9iYHt72smv2aJilj10ptK38kXx/HzZ0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH7Ljfx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E9C2C113CC;
	Wed, 29 May 2024 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716995429;
	bh=XMcqWPab/mPyAANto5jeUF7NKRg1t3LCcsUioRPFDIU=;
	h=Subject:From:Date:To:From;
	b=MH7Ljfx1T9EH50lnsc1qRxCT/mCxFz0sbbxxbBvZviGiH00L+MPp4E7J2YSMpg3Ei
	 6i8dtUhUvLsbAh/lGV6oAQ17pimDmWAiBjxCSrMBfxAm1yF+cLCwYQh/kfHZ2XoFJo
	 6rhBT0New8hdTi/g/7xlY/OSV0vPHkaJ3QIGjRgkL+C/Vj1lUf3let7eARzb4fG/sD
	 iiWSB0S9dSKOuS8GJcgRb0OQtsb1X+/Ku4CGLumqAjmbguwgdFzgGDU7OS80HM311m
	 ZkDJ+CRJ12Y+qzCZ5QLt5uPS4E5XMu4tOZGNgXQKZXDiOeRWsEHjOzYMkl47fMWCdO
	 e9Y80hb0oAzUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53EE3CF21F0;
	Wed, 29 May 2024 15:10:29 +0000 (UTC)
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
 <171699542929.14348.10529472484060751336.git-patchwork-summary@kernel.org>
Date: Wed, 29 May 2024 15:10:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Support for Cadence xSPI Marvell modifications
  Submitter: Witold Sadowski <wsadowski@marvell.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=839888
  Lore link: https://lore.kernel.org/r/20240329194849.25554-1-wsadowski@marvell.com
    Patches: [1/5] spi: cadence: Add new bindings documentation for Cadence XSPI
             [3/5] spi: cadence: Force single modebyte

Series: Marvell HW overlay support for Cadence xSPI
  Submitter: Witold Sadowski <wsadowski@marvell.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=856855
  Lore link: https://lore.kernel.org/r/20240529074037.1345882-1-wsadowski@marvell.com
    Patches: [v6,1/5] spi: cadence: Ensure data lines set to low during dummy-cycle period


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



