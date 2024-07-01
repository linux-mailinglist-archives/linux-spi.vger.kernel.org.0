Return-Path: <linux-spi+bounces-3722-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC491E811
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 21:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FCF1C20D50
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B4143885;
	Mon,  1 Jul 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syiRZ8g1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA92C8C7
	for <linux-spi@vger.kernel.org>; Mon,  1 Jul 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860431; cv=none; b=CvGi8U1gZRPqmlfi0eA2xlvVkeJWJI4kLXDLwRUqMJvvdHmJPkAZBjvibjTP+W5aWdpx+XzSNyxuWVQvdLAPRTyJzycSdufo5/SPVD8hs5hrt9MH1muCbTr1OCFZ2YeSY+ZU+2gng2wOikNwhhcwQLPGCIgwR4vXCyA/+DgH0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860431; c=relaxed/simple;
	bh=v4fs3CGaxJjUTKEtajc/8Xgm568UePDWVkEjwJQ3WDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SyUhrbwnW9aepQ9IMxyMC0kKwhQNnKLgLCY2CeyBmdgvti3AkNDEwBN0u0E0L3J+NfREQ7Mdc5N1H1bgumpjjmxeCufOABbpjG7o9wiwrWtTSU2r0bq0aBfK3EFDFrscBWKYCqtz6XtptUxK9zVENp/9IxvwxLVDsbOIXH72dz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syiRZ8g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41E1AC32781;
	Mon,  1 Jul 2024 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860430;
	bh=v4fs3CGaxJjUTKEtajc/8Xgm568UePDWVkEjwJQ3WDo=;
	h=Subject:From:Date:To:From;
	b=syiRZ8g1aOZFP45VBUKjH+pGgOpkwN8+OPEKFamnwnF/KDlUEdISiuv87ZZOqHhpb
	 Y2Zndn+FuEXEJvfALFjxrHUVrgo+NFzMxe5s1NnEPmBuYgHL4ciBoROFGrUWiA9wRv
	 qi8QQmskK45xELLR8QBtIsRqiQKc3uQARERgj9OVsLrF5biPog+m+pJNMEu5x+GF/X
	 f0ETg5Ba5awKZcs1L4nyX3zU4fFM2CKdxWRYcGHqLOJ1SL/OMMXlWu6pWL1RhXJpm0
	 u83Zm09RDnia0kXS1nWIAq91lzv3/wier9nETbdC1eW5RyOi7aWohEGrsWjbwD9Get
	 0YhpJWysRuvOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DF5CC43446;
	Mon,  1 Jul 2024 19:00:30 +0000 (UTC)
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
 <171986043009.3139.11438954172509482942.git-patchwork-summary@kernel.org>
Date: Mon, 01 Jul 2024 19:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add basic SPI support on TH1520
  Submitter: Kanak Shilledar <kanakshilledar@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=867116
  Lore link: https://lore.kernel.org/r/20240701121355.262259-2-kanakshilledar@gmail.com
    Patches: [v2,1/3] dt-bindings: spi: snps,dw-apb-ssi.yaml: update compatible property


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



