Return-Path: <linux-spi+bounces-4901-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815197D562
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49ECB2838FD
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9211B85FC;
	Fri, 20 Sep 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6g7Xr53"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8F1E498
	for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835427; cv=none; b=db53MmpTo3jdFBvSwCruRpWg+CmU2Qx/fcirjQVr/NVNDgwWLQXBr1/vBnnVMQ5Tzv/uwSMdoRvPgc8rWrLk1eGwBjqXaiP2vTacOTJwNMZOIqo6qQi7nOcpkoXxO++t2RiGbSLRW++sEhC/2QTKOBkfRz3RilKm2TslALR9Jps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835427; c=relaxed/simple;
	bh=55sgyxZiPQbl9MHYoAnJZt3Ogw5HFMmOQVMtOQwQ0a8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nD5YSdPIUY2ohbZY7piyV08cK2TCBWGr2r5oSwIV72GPQ2146tiuddGEG39Lpz85ZMYJFBc/nxdA6258JtUJ8imDIoPLXKCa8jup+1yWako5y6PiNJVpbxyOCJ5KTop8FAUN2E/3MuzcHC9+9cMas9znwPZMi5eAkq2CEYoNNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6g7Xr53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB565C4CEC3;
	Fri, 20 Sep 2024 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726835426;
	bh=55sgyxZiPQbl9MHYoAnJZt3Ogw5HFMmOQVMtOQwQ0a8=;
	h=Subject:From:Date:To:From;
	b=b6g7Xr53PEnhUS3kzPFZ4mC+jJw+bPDZUadZhuYi5l7MLMKMucnW0Hm0FhYsBdpzg
	 KdUbb4Y37bmGgQXENJZj01mvNTrLLtiTzbI7d/nIEqfrKeMwG8lUDS+8l2NfpcUUVV
	 kcGCI/tUMm6QVteKv9iDEOHUGgjoTR/4bL9DLU41mxf2O33ZP1Vgt1sF+D35Lx2dJF
	 VIxOwvI/dsimiwJsJpKlm+kvMZXbcemOhHH1ZgQUrJwrSMUhI13YUWU94bIE9z0duX
	 v9O8lv8W+eem8C483B0auEMgSXQChn4g3DEagvgPTgoP3TMOJx+H+Fg+sqNWuHchAE
	 AqM6jRh4Q6IaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4A433806644;
	Fri, 20 Sep 2024 12:30:29 +0000 (UTC)
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
 <172683542818.2197516.1586587306567275258.git-patchwork-summary@kernel.org>
Date: Fri, 20 Sep 2024 12:30:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: atmel-quadspi: Fix and add full CS delay support
  Submitter: Alexander Dahl <ada@thorsis.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=891104
  Lore link: https://lore.kernel.org/r/20240918082744.379610-1-ada@thorsis.com
    Patches: [1/2] spi: atmel-quadspi: Avoid overwriting delay register settings


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



