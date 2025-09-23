Return-Path: <linux-spi+bounces-10231-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4DB94F3F
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EE018944EF
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C153101A3;
	Tue, 23 Sep 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMYlqlJ1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1342DC79B
	for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615607; cv=none; b=bj3DXb87V+TAow/UXZ2HXNWzWUE35AO1W2e3+K/igeEY1227Fcu2YfK2wFPwbVkXRo62bWt7mQ6ppoiMirGSHnYGcfeQrDVGhhnjs05nJ2ZhtSS5eU2FNsrQPFDNCtJkv2C9SZpog7SDo4NvafGWWAiXmScYoe91krxyWLVl+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615607; c=relaxed/simple;
	bh=cBnnrsm/Z90fogfaIlv+Q3WqXbmowsLnC8hxv/w9bAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FtoumisPCTDl+UB9id0bFIYFnSA3DKT9UZcU1JYZsZhmu6xJFpeNaiO2ck/8iqk4iASS25dtIUQTJJkySGrgA2RyR9MgUCrNmpoqFaBXkgLXoSqF/b/Qk86XkcIUH7tmnP5bjoMIlpD15iDbyUcLnCqXzYsRp0bT4ThcNEKCL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMYlqlJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C709EC4CEF5;
	Tue, 23 Sep 2025 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615606;
	bh=cBnnrsm/Z90fogfaIlv+Q3WqXbmowsLnC8hxv/w9bAY=;
	h=Subject:From:Date:To:From;
	b=AMYlqlJ1i9X+n24V5BYIDK58BMIsQ3ysJcjWmxupAJ/XFuVsZxrJJshZfqp9FLS4K
	 YeIos2YV/H/IpQhP6QTnMUh0TKep5+LKl7ecbpWKWlheikQLzwMDoKApmdmOMPD2ZC
	 Yw9HlwqTTzWofzHrUg2IVEAt0qQf/nbGpE9GoSejENwn1yDAnTMPG8McfSL4M88pTB
	 zB7S0yH3MOPOZ/kY3GZiwoJZSt4GYjzJs+f20BlI8d9mC5XmoQjNYixXW4MLrZzn5b
	 qFwjgUTHItAjhQNlRS5HrE5/kBvQkv8MbFjutBt7cxLravvnkt7Q/g4NiBi8y7W7EG
	 mhQurOIgsSKWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3796C39D0C20;
	Tue, 23 Sep 2025 08:20:05 +0000 (UTC)
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
 <175861560380.1328717.8932406500343320899.git-patchwork-summary@kernel.org>
Date: Tue, 23 Sep 2025 08:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: omap2-mcspi: drive SPI_CLK on transfer_setup()
  Submitter: Bastien Curutchet <bastien.curutchet@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1001629
  Lore link: https://lore.kernel.org/r/20250912-omap-spi-fix-v1-1-f925b0d27ede@bootlin.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



