Return-Path: <linux-spi+bounces-4581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434396ACE0
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 01:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B45C1C24226
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 23:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A321D6DBE;
	Tue,  3 Sep 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls41LMNZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74D1EC01D
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405957; cv=none; b=WZCSV9fodgAsr/dtUwcGg4ciKDVZKb6368jBuuCeZdh29X8uHLmTUigSbDb660o1dS62TGymbJ+B9R3wGIEgueygDoADGmCjDxAT3o6CqTNDm0xXAT2TsDB6avoPBumc6G0Llu8WXDl96lqkeAloWhrMHyRsygaJzvg0POzJkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405957; c=relaxed/simple;
	bh=ds8mp0Tuh/AXcRUlmW6fURizcLpg4Bui9zZkFRn2FPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=INVJE45At8qyKVdPbC0OMi+OX+NBm6B3SUJc6mIbnh0tyQt/0RyoUn6KD+RG8zXCGAaM4/x07vKdit7taxILU07ekDgH3t42zWTO9Joq0gcyMM9G4O+TFqz3HARoOEfak0f9Wvj02R32IW6bEbH6C77AIzfyRMQ1Iv80ODoYlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls41LMNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DBCC4CEC4;
	Tue,  3 Sep 2024 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725405957;
	bh=ds8mp0Tuh/AXcRUlmW6fURizcLpg4Bui9zZkFRn2FPw=;
	h=Subject:From:Date:To:From;
	b=Ls41LMNZEDlAdw+e9We9RnYl6hX6jV3SI2d6RH4k7i7fHlxR9Y04k7kq4pRENcqXb
	 htbQThHz7lDci4yf7CaO6A+2v3/jPVy9ZTXiFTWeuZIAqkDj1uGf4hRz4Ele2ptjZw
	 DjBdP9e2EFifYlMyA6tHC36qwVM8mvLI8fUrX/gPKrPSvJA2L1+DB+IkhEdpVhP1cV
	 aNL9kSUAFzTPksyeapkwcD30ka06Cvp7U6O4j0U4JufBPucIsrRHZE6khNKOorPz94
	 JmnldOB4PPxuBdB3+2QIbbatLFdFn/QxZJRffr3WuT18dcHkxAGi9ZtjBQMwnkKG6L
	 pSv5mLcZzWzjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD73806651;
	Tue,  3 Sep 2024 23:25:57 +0000 (UTC)
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
 <172540595641.476470.4915428492077639977.git-patchwork-summary@kernel.org>
Date: Tue, 03 Sep 2024 23:25:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
  Submitter: Fabio Estevam <festevam@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885988
  Lore link: https://lore.kernel.org/r/20240902184655.932699-1-festevam@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



