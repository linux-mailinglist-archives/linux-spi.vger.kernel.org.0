Return-Path: <linux-spi+bounces-2491-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF2B8B0BC8
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDF528CEB9
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999515D5D7;
	Wed, 24 Apr 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzHPo7nX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE815D5C7
	for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967230; cv=none; b=HozQxLSR7GngQG4wlmi2KCcf+IrM38lyrcRmIfvo4nA33n3qpv0FAVqQDDRextrBsVpuo5ryrRztvjRnq9A17RJ0Ky3znrCEjrfNN6QhD4YJKoMz7YF/lV1pdZO/FH9Yu9hhD5DrFv+uGZDRzvKgsz03Xn2DrtNWOA0vDXpmek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967230; c=relaxed/simple;
	bh=elkDwKDRhZ1wGdFi4Pi6AGV49ZFMPRX3PSRGMDmoRH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N2QBi+YT4PQhNxE0Gww4QmENsDq0R/HqUB8PChhKxX1L6Cv/FVSLyWtS4HyNd0CWecPGdWUkUuCNUEW6/pULRH4adPdH37OI46ehCDpXXHnrMhI+f5UZBhdj2SPgs+UOHQXUe2N1YyyKjhN6ZQXdy/rLy0t+FvIKb9VJALTBYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzHPo7nX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C105AC113CE;
	Wed, 24 Apr 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713967229;
	bh=elkDwKDRhZ1wGdFi4Pi6AGV49ZFMPRX3PSRGMDmoRH0=;
	h=Subject:From:Date:To:From;
	b=dzHPo7nXiphSK5B3LHwIKNnWsOn60xft6VbZvtDBjaFat6aPP2sXZs04TtR4z+ETR
	 UQoe/T6DtR6gX6TnghlJ16yHdZzQZxES7DPWCS91BzuNKslT+CmJWV46IDGzy9eIzI
	 NZKO394Co7vOsVpUpKWCcjiu0LepeJ4f2V+GkHW+KzWHu6foxJl31rUdvMBr2pgp7I
	 1wfhMeANQ+AbwAOcoIpuX7iB1nHsd3TT9M1NEd3OgLaD5gaVMuWzvTYXbWL2jLqKYi
	 t+ir675q/0mPQG96HQmV3oqIaX3vpl4Ls0ztmj3xgk5S4HW8NWAYdObPjTJEJBQkI2
	 yU9D+zqxax41Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B07FDC595CE;
	Wed, 24 Apr 2024 14:00:29 +0000 (UTC)
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
 <171396722971.15319.2670094629926302385.git-patchwork-summary@kernel.org>
Date: Wed, 24 Apr 2024 14:00:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-s3c64xx.c: Remove of_node_put for auto cleanup
  Submitter: Shivani Gupta <shivani07g@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=845625
  Lore link: https://lore.kernel.org/r/20240418000505.731724-1-shivani07g@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



