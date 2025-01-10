Return-Path: <linux-spi+bounces-6318-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CDA09667
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDA5188C330
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB03211A05;
	Fri, 10 Jan 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKTFfBUM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC785211A02
	for <linux-spi@vger.kernel.org>; Fri, 10 Jan 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524218; cv=none; b=QNK+a2Hl0eNOZOAAr/mIZdLXXFx3POetKQawd8l9PufnnuAr6WXtTRsv0WzZLzHWgrJ3EpUWMu3dv5peSHHtYnFRTwrPstCzZkEu8GspYfLdtBLLSttGaj30BC3vZit6hutANGwTgAvXblONWJIwEayZZNXKkk6sVQptaWs4gZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524218; c=relaxed/simple;
	bh=LXq2yRw9z6HHkF+M13VaugZ6W11fpsOdlsRvnQe6WYE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=USCj/i4t8X8oIT/XQKoxCB19oxYqMD5e/MURH2TLdfPY5yGGn6ahOvdMGNpMkOq/fLOS/Oi50UZQwer1sXqv5ccVHDUWpnVdhpw1YJKjKcS0bUOKsfIXW9qnCqpoeCHqjPmlprMaL0Z2kk/wu0v1zU1XusNEcaUSGayUP/O4wTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKTFfBUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79991C4CED6;
	Fri, 10 Jan 2025 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736524217;
	bh=LXq2yRw9z6HHkF+M13VaugZ6W11fpsOdlsRvnQe6WYE=;
	h=Subject:From:Date:To:From;
	b=lKTFfBUMxbK6MlI1D0q0G4z6Vvfz+CDvkuxIi8dP/lF78jzawI0ePBnsMt4WWVy/w
	 0qokSLCjEGrGicO2lUeSvknJe246wBeH7fXiG9v9Yn78FWG3oEzRQJr3by8TL6mqRc
	 hyiNvAdQaQ8XsbuPxjtTTkMtmggpVVvt96766XbSX+Q/RIiVSg5vc7okuvoQqdsT+f
	 FwO6La3VSsdYb1xkIIgFowLGIhI2fjoL149vRLg8Rew1FEC9FqLfSuW33nV6UaeIPi
	 pzhKsx2VLa+SmHKCdwRsZkdyfeqWKmoIKq+CCPCOtc0PCCr0PFJkr70/4Zg33xLAD6
	 oj/HIW2/jkrdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76A91380AA53;
	Fri, 10 Jan 2025 15:50:40 +0000 (UTC)
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
 <173652423893.2110852.7841554627660740344.git-patchwork-summary@kernel.org>
Date: Fri, 10 Jan 2025 15:50:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi-nand/spi-mem DTR support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=924284
  Lore link: https://lore.kernel.org/r/20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com
    Patches: [v3,01/27] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
             [v3,02/27] spi: spi-mem: Add a new controller capability
             [v3,03/27] spi: amd: Support per spi-mem operation frequency switches
             [v3,04/27] spi: amd: Drop redundant check
             [v3,05/27] spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
             [v3,06/27] spi: cadence-qspi: Support per spi-mem operation frequency switches
             [v3,07/27] spi: dw: Support per spi-mem operation frequency switches
             [v3,08/27] spi: fsl-qspi: Support per spi-mem operation frequency switches
             [v3,09/27] spi: microchip-core-qspi: Support per spi-mem operation frequency switches
             [v3,10/27] spi: mt65xx: Support per spi-mem operation frequency switches
             [v3,11/27] spi: mxic: Support per spi-mem operation frequency switches
             [v3,12/27] spi: nxp-fspi: Support per spi-mem operation frequency switches
             [v3,13/27] spi: rockchip-sfc: Support per spi-mem operation frequency switches
             [v3,14/27] spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
             [v3,15/27] spi: spi-ti-qspi: Support per spi-mem operation frequency switches
             [v3,16/27] spi: zynq-qspi: Support per spi-mem operation frequency switches
             [v3,17/27] spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
             [v3,18/27] spi: spi-mem: Reorder spi-mem macro assignments
             [v3,19/27] spi: spi-mem: Create macros for DTR operation


Total patches: 19

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



