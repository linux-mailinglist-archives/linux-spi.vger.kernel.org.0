Return-Path: <linux-spi+bounces-8748-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CE2AE6DC8
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 19:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AF0177848
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F52E62AC;
	Tue, 24 Jun 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+EOByzk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB62E62A0
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786856; cv=none; b=HgVMB9KvTAr8U/jbUoXtYYVqw8aU+HSKktWq6VwHgpnzJsNixlRAbQGsSRW3LpWYge9+mVF6EIQhob6Z/W402gsmyeBLfBlzYK3L0k6Z8exieAo7V2CdyfmcRzP0LjAoMV64fx8maYePxnHHlh8ueneKd1r+kg1+RArVXN2WB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786856; c=relaxed/simple;
	bh=oiW95KRfx3q2VZqBjzVI5ljoFeEkzEC5qCIsDPOsTQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uFH2bRfDc63WUONBxb4+KZxSMDPeNoUTnpv5CDMfyGyzyKmTnbG9q6lmpCIMftfIMtDEm3waWxyKv04Y3crXkFWn1JNfXKxqtsW/rA1SlzNlD/Vj4nJnopeUb/kpej677syzeZjsV0qQf266/Im8F5XhiZrFU0KUhuwdYcXJyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+EOByzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB27BC4CEE3;
	Tue, 24 Jun 2025 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750786855;
	bh=oiW95KRfx3q2VZqBjzVI5ljoFeEkzEC5qCIsDPOsTQA=;
	h=Subject:From:Date:To:From;
	b=C+EOByzkqVDEqSmfddiMkeJOjPBO9DbMAIxvvQxAg8GIkBtN5PDS8DB5WfJ1RmLSo
	 8wWq9DRZSSLCcElPkPq+nfqlt+Cqk81HXb95ksTcJ6Hn60U8o/i3HgQPIT0xkQ/6nG
	 YfR3w96jyC+EB+2qN12VxKzb6NrrRVFN7LJHlmPkq1R5UhJY4J+uaE53Zg4whCo6R8
	 2ZuPG2Tzxl4yuXSk0YZZ3SivDor5wZ9bQUlHjM4VIj4ZEQZmHfkTrPoChWraQ8ObBe
	 A7kTsbG7oXOp4s94+p2jhZorZAN2ommg7Pgt14oLULWdAGSHOlr7t/1C3dR9V57lyx
	 hXtIzizGsrdsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A41E639FEB73;
	Tue, 24 Jun 2025 17:41:23 +0000 (UTC)
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
 <175078688226.3985612.3467070511309992167.git-patchwork-summary@kernel.org>
Date: Tue, 24 Jun 2025 17:41:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: microchip-core-qspi: Add regular transfers
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=974284
  Lore link: https://lore.kernel.org/r/20250620-finer-yoyo-0bcae988a299@spud
    Patches: [v2,1/3] spi: microchip-core-qspi: set min_speed_hz during probe
             [v2,2/3] spi: microchip-core-qspi: remove unused param from mchp_coreqspi_write_op()
             [v2,3/3] spi: microchip-core-qspi: Add regular transfers

Patch: [v1,for-next] spi: spi_pci1xxxx: Add support for per-instance DMA interrupt vectors
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=971620
  Lore link: https://lore.kernel.org/r/20250613023236.126770-1-thangaraj.s@microchip.com

Patch: [v2,for-next] spi: spi-pci1xxxx: Add support for per-instance DMA interrupt vectors
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=975102
  Lore link: https://lore.kernel.org/r/20250624033028.74389-1-thangaraj.s@microchip.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



