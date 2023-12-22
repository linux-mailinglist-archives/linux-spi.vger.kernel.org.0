Return-Path: <linux-spi+bounces-340-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FD381CABD
	for <lists+linux-spi@lfdr.de>; Fri, 22 Dec 2023 14:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4441C211F2
	for <lists+linux-spi@lfdr.de>; Fri, 22 Dec 2023 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7DC18B00;
	Fri, 22 Dec 2023 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX+e06KF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F27199A1
	for <linux-spi@vger.kernel.org>; Fri, 22 Dec 2023 13:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BA6BC433C7;
	Fri, 22 Dec 2023 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703251825;
	bh=wS6ixp91A0yIAbOC1KNkVKwmvy9QblF7i9VWAj0w4Bc=;
	h=Subject:From:Date:To:From;
	b=MX+e06KFUVwveqStPx5XtOHptdqPBOccNObsJZ70SdWmZLldvuICvgdED6D9rrYps
	 xuOVlKI3t25AUdMXvMgVouzhUExwN8IoA0+2mSNGG3EUeJbEfLcnvPZSw6PzvNdIKm
	 kpmRRpFaI1khyM8jpzDrs7CyezmC+hJQq8rjJgolZpFd1kZ24ErthaJ2E+OfdAbfVI
	 TCVItir5eQpxvji+qFRNoTgXSqiRrTkHk5PZr7rKIuWdu0ryurNSNSHzkFZl2o0gpm
	 PSWVYCnUbpOjOkQ0giMPWhJ3asZIOebQrR6+VQ9MGtdngyLG2m7UY2jGL83DTyn17b
	 oVLuVZtxQ4f8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37975DD4EE0;
	Fri, 22 Dec 2023 13:30:25 +0000 (UTC)
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
 <170325182517.27136.5570005751970424425.git-patchwork-summary@kernel.org>
Date: Fri, 22 Dec 2023 13:30:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: stm32: add support for stm32mp25
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=811107
  Lore link: https://lore.kernel.org/r/20231218155721.359198-1-alain.volmat@foss.st.com
    Patches: [1/6] spi: stm32: use dma_get_slave_caps prior to configuring dma channel
             [2/6] dt-bindings: spi: stm32: add st,stm32mp25-spi compatible
             [3/6] spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



