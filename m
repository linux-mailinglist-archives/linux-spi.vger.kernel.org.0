Return-Path: <linux-spi+bounces-10171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86259B8A823
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6497F1C2239A
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F7313264;
	Fri, 19 Sep 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajYGWtgk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD723C4F3
	for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298208; cv=none; b=h3aKkg8Ea/io9XRPj6WEhixF/HqbNcD7TdQLjI+RHCnbFZcyFi2PYfHPsZhG+7dFI8PbQ6Ipo3K+kFonrlGomUKxOGLcOrFY6fuzEIqrPS/eKrhSI1P+VuLJ3On8aRWAJwemO4V1LDk/rRpWkgpaawQeowCUtAgi6+DKVE267jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298208; c=relaxed/simple;
	bh=L6Mg1aiJdeU8YDtlDC8tWNZWa/cjyxvtbJnAQr5UDVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VoGC8ZI8XBvQkMvnQUiYM83nS+oXfC0yBPiZx5jjFmqQe1Bmvqkz75rfaiqKIfGqGewxKy88uScBF8UqU5VOICybQeA2qJHW3mZIAHJmT4H4T7O5M2ey9fZIqk4aZfIRBvPWMcDqBk0mluAmjVc7hWYCK4nQTzMcj2FW5APZGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajYGWtgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBA4C4CEF0;
	Fri, 19 Sep 2025 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758298208;
	bh=L6Mg1aiJdeU8YDtlDC8tWNZWa/cjyxvtbJnAQr5UDVU=;
	h=Subject:From:Date:To:From;
	b=ajYGWtgk022cz/SJ05h2BnPWJ7mwYBKNcv0AAwMsMb0ZGxvII7mBK8kLjcQNR9GD1
	 iccovK11hK/WaUSrUxQKdoBEHTo1ucP/DaDkKmpAUv8b4Lh38ShCdX+TN/UrbvxAhS
	 fAtmxpDfhrvhEFvVl0Y2LqprtsJoPbkOgaWPRfr/y5rY6OdAiK/m7AzrCBouE0bfAQ
	 0dFcX7L82NYNEBf/9sJpnzFTBFhUNz3i6JvfOwqvrilrnzi6kG764JZD2gyY1b1Bd4
	 qN6Z8gp6VE8U82eJzcAq+Jw7a/rqITAR3c9VbzHpdV9USt/X5j0tcr8XeJMKmZpOdj
	 0MUhnHHIMOlbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE92739D0C20;
	Fri, 19 Sep 2025 16:10:08 +0000 (UTC)
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
 <175829820741.3615947.15303710581299128231.git-patchwork-summary@kernel.org>
Date: Fri, 19 Sep 2025 16:10:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add QSPI support for sam9x7 and sama7d65 SoCs
  Submitter: Dharma Balasubiramani <Dharma.B@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=999852
  Lore link: https://lore.kernel.org/r/20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com
    Patches: [v2,1/5] dt-bindings: spi: Document sam9x7 QSPI
             [v2,2/5] dt-bindings: spi: Define sama7d65 QSPI
             [v2,3/5] spi: atmel-quadspi: add padcalib, 2xgclk, and dllon capabilities
             [v2,4/5] spi: atmel-quadspi: add support for SAM9X7 QSPI controller
             [v2,5/5] spi: atmel-quadspi: Add support for sama7d65 QSPI

Series: spi: spi-nxp-fspi: add DTR mode support
  Submitter: Haibo Chen <haibo.chen@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1003222
  Lore link: https://lore.kernel.org/r/20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com
    Patches: [v2,1/5] spi: spi-nxp-fspi: extract function nxp_fspi_dll_override()
             [v2,2/5] spi: spi-nxp-fspi: set back to dll override mode when clock rate < 100MHz
             [v2,3/5] spi: spi-nxp-fspi: Add the DDR LUT command support
             [v2,4/5] spi: spi-nxp-fspi: add the support for sample data from DQS pad
             [v2,5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



