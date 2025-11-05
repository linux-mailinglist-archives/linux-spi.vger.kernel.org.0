Return-Path: <linux-spi+bounces-11047-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42742C36A0A
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0293B6139
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125B3203AA;
	Wed,  5 Nov 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDqBNeLS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D12E62D4
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358253; cv=none; b=Ozb25BKPPGvc0uvua8ema8XiBHjc+AZr6M0zoCI91fV0W5/EkpgUNIlkVbhhJD5nky/+LWtiSwa3vgFXZK8vrfJloXL6emccBZutqtKzZQhi30s1T42RE17RWfBXD+bExjgTwTDvMCnfXEWJWFQZD+FGkGCJIuXRe08J4kiSqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358253; c=relaxed/simple;
	bh=85aE37cc6ISFolMBh86Psrb56FV6kjDMnrWUBvEuZEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EPLveMuyG38ItuF1tLlWOhAuya8/aNUtbP6D+r020gsO+474WaGdjhnRjSjYjMRcR96/XfH3VSTX5Fov5CGDzSA8xuKSh9zzEn+2IxBPweRzmWIiTtJSMMzzVBfJdKZnNTSIqP5PbbSrSWG0o+XXgU4oYqo+9H6vxnOPZoMsh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDqBNeLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE39C4CEF8;
	Wed,  5 Nov 2025 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762358253;
	bh=85aE37cc6ISFolMBh86Psrb56FV6kjDMnrWUBvEuZEo=;
	h=Subject:From:Date:To:From;
	b=lDqBNeLSMdTNy4iq3uL2EfHBWkFxTbsHpJWGSJO24J9DDBFo9hUrO9NiLNXACgTdn
	 xKcKSG2YmWtFAKHaqd8GLe9sBPGGxkaYJHg0lwmzkkSFTyJRO7lQ2VQ+9HcAuE0lY3
	 z9zQ865BRnQn09TTFW8WEYrm1Z2hzGp9U/uOC3026WHxLGpwn2IHT5vC2QCIU9E7Gt
	 /iTEemMeZaaXGllowy17lzzWjYyLSuYCja6uvqxUYsVL/TVULPafXALv7NRDx07NdT
	 Vek5NsUvi6oyVW66jt1pxVHsUuBZuwii/GtRqIjkKAVFAoq9THVCglHt04YZsuJAim
	 jKmYmZMW0Z5/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3A380AAD0;
	Wed,  5 Nov 2025 15:57:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176235822619.3666102.2400668258025493151.git-patchwork-housekeeping@kernel.org>
Date: Wed, 05 Nov 2025 15:57:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add support for Microchip CoreSPI Controller (2025-11-05T15:28:20)
  Superseding: [v1] Add support for Microchip CoreSPI Controller (2025-11-03T16:05:14):
    [v1,1/3] spi: microchip: rename driver file and internal identifiers
    [v1,2/3] spi: dt-binding: document Microchip CoreSPI
    [v1,3/3] spi: add support for microchip "soft" spi controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


