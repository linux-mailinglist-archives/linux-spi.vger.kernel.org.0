Return-Path: <linux-spi+bounces-7944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA2AAD3AE
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 04:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4351BA0D00
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86BB156F3C;
	Wed,  7 May 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9HfONUL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F33594B
	for <linux-spi@vger.kernel.org>; Wed,  7 May 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586788; cv=none; b=dFo/X9jQz+IxLt9ws62tJCuKWOOI1SAp5Dh8oSJpsaMrnsulKgoJ1UJbRA+8aZjRjFp94IERr0iF8WkHLdJl1ZhID/TynLBscLSM5ZT1iZsjMOAp5tV8bt7hcPQcBGADo4/zK+UfYEzvvAG99cbONoaQLbZSgSMFG4bHEQhwz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586788; c=relaxed/simple;
	bh=X0Z0OocfYrr1ZGtvuMQkU3jNBgoLiBVauboLCQYLNfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qg1Tvv5tARelUwW7DDuGfkAL7bNLSf2aQs36OWM/sSHqcDZXze5mOt8YbYUkTwz/OO/QokRQGckhrhyP35P3iukLZ/UX0tORp1dZpKplXdK06Nqf7m5NKbPNUI5/96QyvGa1Ov6lDYBp8//1KUdDYKrWZHVHdaLAQMKmHH+4GfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9HfONUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C41C4CEE4;
	Wed,  7 May 2025 02:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746586788;
	bh=X0Z0OocfYrr1ZGtvuMQkU3jNBgoLiBVauboLCQYLNfw=;
	h=Subject:From:Date:To:From;
	b=C9HfONULnuxN7bcm98pBiga6qbwA3t4AltUBU5DqtPSGQ2ZO40xBvtFDrNG7jLpzC
	 JgNvCgnQW+/RAtMJFPCO67kIk4vK6AXdzGJFie/3Wfe0B2xTZg8nVz1fFX7PrO45kx
	 mN5jkwrPm0aMEdXvV+R1cKaL1UBoQSrw8roDDrsAlih+96bAWnT9t/ACJkCTVH5Dha
	 ZptwqFuNlde3Ew35H4yXc8lyfBEwyZVKj//ia3aFmVtE46sOYqTUgmLP8MVKKJ3WoF
	 MYEsd41lAwsNb30+KkeVSrGglQir5YEiEQgRZxDZzDcBAG6Pq5FnGPqgzVHQ19Ny+u
	 ESyn3ZtKr6Jlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 382FC380AA70;
	Wed,  7 May 2025 03:00:28 +0000 (UTC)
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
 <174658682676.1725084.15234398742537762448.git-patchwork-summary@kernel.org>
Date: Wed, 07 May 2025 03:00:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: This patch set did some clean up and add runtime pm support for flexspi driver
  Submitter: Bough Chen <haibo.chen@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=957652
  Lore link: https://lore.kernel.org/r/20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com
    Patches: [v3,1/5] spi: spi-nxp-fspi: remove the goto in probe
             [v3,2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
             [v3,3/5] spi: spi-nxp-fspi: use guard(mutex) to simplify the code
             [v3,4/5] spi: spi-nxp-fspi: remove the unchecked return value for nxp_fspi_clk_disable_unprep
             [v3,5/5] spi: nxp-fspi: use devm instead of remove for driver detach


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



