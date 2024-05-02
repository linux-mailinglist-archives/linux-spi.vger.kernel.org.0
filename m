Return-Path: <linux-spi+bounces-2692-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00A98B93BB
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 06:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C392283F9F
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 04:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE7D527;
	Thu,  2 May 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTq5O56N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392F1B970
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622434; cv=none; b=qZKzYGoEHOiew+NC72UqvH3B+gt0IO8EhAFj0Ggsn1xvDeh9YlRh/dpLfawgiLNTxxp3a9LfbHJtoE3YboE1AO7zZ6HvNECYbA5vSx+Og7rDFSUXA2REe5fjVZllDZV7+UhYzCoZYJiVHRcCVS7rzBUYFUMsXvMK3dWXIdfWWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622434; c=relaxed/simple;
	bh=oCLO82QWPbSoEhhbBqlmKUVqdNKI4CaMV9aeivrxJbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KwUUERg8RutLEiuL9ic3UDoMQjRCuT8lKfAsF6q1qYO87MXaQE1yXBVqywQlucOCQRUDZfhFR9fHhsALsU8VBphMtE9li85JIp1bbcFC7MTxmk80HYjsET54lk9252gqC2pMJ91lO2qlKoPj9MmNXoyR3S9mGt1Wd0DzqwsEpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTq5O56N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D3E6C116B1;
	Thu,  2 May 2024 04:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714622433;
	bh=oCLO82QWPbSoEhhbBqlmKUVqdNKI4CaMV9aeivrxJbk=;
	h=Subject:From:Date:To:From;
	b=XTq5O56NOTroD6735DLtwYyf0s0XdONWJd7ryNFneWVsetUlZYmPwpN2X/L9B63cp
	 gHEbxHiu7uVtTDzUkdNR4gfLY5Ba+SdZIWQKF/KMm28WFpBLWpJ20Bw9mp/+4TGJha
	 nZ9To6YuAbgCjJfRSm59kFc+Zf1f/u38W/84fSRTQkFhRG9KWfMb13JukiVgtI6BJ4
	 HXE0pHLAbmv0LUC9KmY6QQuyS2tNCmKxFHwqn4oag0eQI2iJ/NYqd+7P1shQ9pA1Si
	 uFrn6my2ovhUqwyFJg7Waj13b5Yri6nt8NIqtkdt9GRNPMMwYFdw5MXcgMkJjenSFQ
	 DX9DPq/EoaFlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7737AC4339F;
	Thu,  2 May 2024 04:00:33 +0000 (UTC)
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
 <171462243342.17680.15219814171027631851.git-patchwork-summary@kernel.org>
Date: Thu, 02 May 2024 04:00:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: use 'time_left' instead of 'timeout' with wait_for_*() functions
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=849251
  Lore link: https://lore.kernel.org/r/20240430114142.28551-1-wsa+renesas@sang-engineering.com
    Patches: [v2,1/8] spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
             [v2,2/8] spi: fsl-lpspi: use 'time_left' variable with wait_for_completion_timeout()
             [v2,3/8] spi: imx: use 'time_left' variable with wait_for_completion_timeout()
             [v2,4/8] spi: pic32-sqi: use 'time_left' variable with wait_for_completion_timeout()
             [v2,5/8] spi: pic32: use 'time_left' variable with wait_for_completion_timeout()
             [v2,6/8] spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()
             [v2,7/8] spi: sun6i: use 'time_left' variable with wait_for_completion_timeout()
             [v2,8/8] spi: xlp: use 'time_left' variable with wait_for_completion_timeout()

Series: Add add spi-nand flash controller driver for EN7581
  Submitter: Lorenzo Bianconi <lorenzo@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=849659
  Lore link: https://lore.kernel.org/r/cover.1714571980.git.lorenzo@kernel.org
    Patches: [v6,1/3] spi: dt-bindings: Add binding doc for spi-airoha-snfi


Total patches: 9

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



