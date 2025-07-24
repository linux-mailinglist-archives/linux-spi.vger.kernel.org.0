Return-Path: <linux-spi+bounces-9179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB8B114D3
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 01:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D221AE1A45
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 23:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A4242D92;
	Thu, 24 Jul 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7o+EQAR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA723D2A1
	for <linux-spi@vger.kernel.org>; Thu, 24 Jul 2025 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400397; cv=none; b=gTYU+UvTDu2SbK1HhNTIOrEuvh8gL2KOmUX2kEQvl8XY44ys2KgnEAVehlGKSs5YPbNO2NIIeBP78mNTV2Cne/mACIRP8SgG59be581UmNOFdSjJhC1q8HFXuWA1FtjEf4IlihDbIFkIFrnVHRH8eW2PD+dqLAQDl1hHV/NFQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400397; c=relaxed/simple;
	bh=z6/4MSsFwR2yvhOV1csy7lWT0z64kQ3pBBJv0kbMswg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YkyYlL1omeXpRdvGNnyUebGNuMgrFT0JkZJLV9bDxE3NSBJo6vC2RFwwlph1kdQZEJ7TEFhtlrkjMNKVDxKgTYIjYcq/pHhoJE3bPnEEBh8KPXffKCy5kSEeJnBTplClrnfFf7evmSlBgjWge2HU63cjnqkpgyw9wTEBByr7U5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7o+EQAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E375C4CEED;
	Thu, 24 Jul 2025 23:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753400395;
	bh=z6/4MSsFwR2yvhOV1csy7lWT0z64kQ3pBBJv0kbMswg=;
	h=Subject:From:Date:To:From;
	b=u7o+EQARPHHQx1eZ2wEXAHTMnHQSdg3LGr6P3ghN4DfsQx582xzbIHTd1hoDLOxiY
	 flyhklObqR/8gcyFYZ8txnEewLY14qWCst5gfRhLNy0IbqaE3ipxhulLmCTB3METjY
	 tZ7nYX5JYUiDa2gDv8XrNGbUZLndjsStDpGi03N0/gHJVBq+bTtv07SegeGrHTqiUo
	 Q3OjkwDTDbxv9Jqb00mqNLGPIFtONdflHkTxs1OlMzCrZTJemD1y4qdoRL6/qFq2+2
	 O94nVy4o0jAlHKspOMvX/dZWzybGyzVF3a1e4Vr3SBL7kcbydWc1NGo1tCU96WVXVj
	 sKzQ3B8wW9a6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74575383BF4E;
	Thu, 24 Jul 2025 23:40:14 +0000 (UTC)
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
 <175340041295.2570957.8374068723994203104.git-patchwork-summary@kernel.org>
Date: Thu, 24 Jul 2025 23:40:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add RSPI support for RZ/V2H
  Submitter: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=979206
  Lore link: https://lore.kernel.org/r/20250704162036.468765-1-fabrizio.castro.jz@renesas.com
    Patches: [v2,1/3] spi: dt-bindings: Document the RZ/V2H(P) RSPI
             [v2,2/3] spi: Add driver for the RZ/V2H(P) RSPI IP

Series: spi: sophgo: Add SPI NOR controller for SG2042
  Submitter: Zixian Zeng <sycamoremoon376@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=984066
  Lore link: https://lore.kernel.org/r/20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com
    Patches: [v4,1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO SG2042
             [v4,2/4] spi: spi-sg2044-nor: Add configurable chip_info
             [v4,3/4] spi: spi-sg2044-nor: Add SPI-NOR controller for SG2042


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



