Return-Path: <linux-spi+bounces-10717-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6ABEB5DA
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 21:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE23C585A37
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB7330307;
	Fri, 17 Oct 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXWEVGrV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65233F8A7
	for <linux-spi@vger.kernel.org>; Fri, 17 Oct 2025 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728232; cv=none; b=AewkN7AM8uwKBmDFu/DqL0WipHsQ9516fvCZkkd99I9qI0KtqmyXGCxMWH7FSgY8DBn6Tg2AXnCByjFq8mSNTG1cMUbUGu5biDytK6SHvqFGk9yPJ2SmYTYILJbWnDe8h1tdvUHamc79DRF0yOfBJyfTneNROwdtXJi8qI50nDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728232; c=relaxed/simple;
	bh=+/M90o/1iGMWyOSDlPNjEJgpE+jzkwDJj0tOlpV3cL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tBZO8tBtpX81lk/q1dyph+lDC4o6J+p/FZIrD1DjKkmvrVDyYdQD+Bn43A/uKfq6MWZSGhD36rDOWG+ijO4nbqEagI0schG41IG35Sn+gE9X4cMJshjqGMVAxQ80qBak7i2sDC363kBWlJIigP+rwlGbiGJr36Bm8OuFJgq7rHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXWEVGrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD7C4CEE7;
	Fri, 17 Oct 2025 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760728230;
	bh=+/M90o/1iGMWyOSDlPNjEJgpE+jzkwDJj0tOlpV3cL8=;
	h=Subject:From:Date:To:From;
	b=WXWEVGrVBELitRKDxaFq3kYQJ1AasbqUi0f5c67pAn1Ye09M5vzokB4wZXPjJ71cz
	 pCMq/QZboq2ECyfNx6YN5XtcYBw1g3IeO7SguVISVqZs4zIRgmcSPsBXXXvRybgIEs
	 PNTjL2bVqI86T4Zs2xIO4TB0YSBonXMnB2JRKBDlxLMnYeQM4JDS12yqHip0tUPw5f
	 aBegE4I51Os9HLQD8PxpKilBlbvT7mVxLQoRLkTEalZdVdPtTXbqUcbuDMf5tdyObI
	 YEWOw9sEV3KGShn9I4mYP2dwu2EeNyVUgXK45+myYQy3K1Z0ywgEkiIehdfvO3CBbP
	 QcvVGerjIZ7mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 381DB39EFA57;
	Fri, 17 Oct 2025 19:10:15 +0000 (UTC)
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
 <176072821383.2754288.6541503303080403205.git-patchwork-summary@kernel.org>
Date: Fri, 17 Oct 2025 19:10:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v8,01/15] spi: airoha: return an error for continuous mode dirmap creation cases
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1010199
  Lore link: https://lore.kernel.org/r/20251010192038.1592889-2-mikhail.kshevetskiy@iopsys.eu
    Patches: [v8,01/15] spi: airoha: return an error for continuous mode dirmap creation cases
             [v8,02/15] spi: airoha: remove unnecessary restriction length
             [v8,04/15] spi: airoha: remove unnecessary switch to non-dma mode
             [v8,07/15] spi: airoha: unify dirmap read/write code
             [v8,08/15] spi: airoha: support of dualio/quadio flash reading commands
             [v8,09/15] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
             [v8,10/15] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
             [v8,11/15] spi: airoha: set custom sector size equal to flash page size
             [v8,12/15] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
             [v8,13/15] spi: airoha: buffer must be 0xff-ed before writing

Series: spi: airoha: driver fixes & improvements
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1010422
  Lore link: https://lore.kernel.org/r/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu
    Patches: [v10,01/16] spi: airoha: return an error for continuous mode dirmap creation cases
             [v10,02/16] spi: airoha: remove unnecessary restriction length
             [v10,04/16] spi: airoha: remove unnecessary switch to non-dma mode
             [v10,07/16] spi: airoha: unify dirmap read/write code
             [v10,08/16] spi: airoha: support of dualio/quadio flash reading commands
             [v10,09/16] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
             [v10,10/16] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
             [v10,11/16] spi: airoha: set custom sector size equal to flash page size
             [v10,12/16] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
             [v10,13/16] spi: airoha: buffer must be 0xff-ed before writing


Total patches: 20

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



