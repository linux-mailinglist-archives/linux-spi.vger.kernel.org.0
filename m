Return-Path: <linux-spi+bounces-9015-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3662AF6218
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6361683B6
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20CC221F20;
	Wed,  2 Jul 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TViccHwp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5491BC099
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482725; cv=none; b=GUuu45rOgIKtqANqkUbZYw06wGqb3n9R+/J/JFUGu5OBADKWIyT6m6bH6hyDv6X0rAi3TbZWfYa4c+Gi3Y1Ku38tKmo5Ku+DY+eeruLqlms5M155XBoZS/k0V3fekhtYmnFsfWq08erh9vNwADz7kxuzksYfPhmcNdiLaoUFcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482725; c=relaxed/simple;
	bh=zP18jhkuPncJgyRqY0mtnYkdm65EOns44ReAXPZ9ai4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=njOLmnV7fsnCSqsTetKdVAwoN57LzE6MNC5P1nsp1DuqkF514wEg6g01zu3NQykTBPuekB3UL13l3yHTbNCe6C8p/nRjxo7T4RfKfih8Yr72NmZBSpRG1ilwkRv+jIHUppdJ4ZH2JFQwa2CH4ZV7UGj9TIXttS65ZIsYu5BkgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TViccHwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C6BC4CEE7;
	Wed,  2 Jul 2025 18:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482725;
	bh=zP18jhkuPncJgyRqY0mtnYkdm65EOns44ReAXPZ9ai4=;
	h=Subject:From:Date:To:From;
	b=TViccHwpSiEc80/vLtlv7/ERBYpK7Vlw4YrQbMdClx3tX1pRXesaYL8/RPkfPDSez
	 n837Fz1s3PXRZj1/5/8Kei4RchF8fuiI4FEW09Bwt4zeGruxaUzKRBy7/X2ziKXRuL
	 7fxcCSI/tZcqQws+A3aN8l30ZbtVFuZVNCXFbJhRIFUWqix+jA8E6m4ElKJ4DuFTUb
	 dSPCjbTDfFdHLAV6zf4+1ll5UtnvvIKJVaOKyb84Ie4mvWfOYaMwp1905eWITb+1gY
	 fmrPXr8ju1H4i4rlCTbl2jYmE11DJMoU2z9qcsPAMo1FxH+PEgIFnWTyR+wPSY4WzC
	 D0jhQ1fiEudag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE491383B273;
	Wed,  2 Jul 2025 18:59:10 +0000 (UTC)
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
 <175148274935.831772.6455401620011239970.git-patchwork-housekeeping@kernel.org>
Date: Wed, 02 Jul 2025 18:59:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] arm64: lan969x: Add support for Microchip LAN969x SoC (2025-07-02T18:35:58)
  Superseding: [v7] arm64: lan969x: Add support for Microchip LAN969x SoC (2025-06-13T11:39:35):
    [v7,1/6] arm64: lan969x: Add support for Microchip LAN969x SoC
    [v7,2/6] spi: atmel: make it selectable for ARCH_LAN969X
    [v7,3/6] i2c: at91: make it selectable for ARCH_LAN969X
    [v7,4/6] dma: xdmac: make it selectable for ARCH_LAN969X
    [v7,5/6] char: hw_random: atmel: make it selectable for ARCH_LAN969X
    [v7,6/6] crypto: atmel-aes: make it selectable for ARCH_LAN969X


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


