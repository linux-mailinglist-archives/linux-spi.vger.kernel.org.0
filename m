Return-Path: <linux-spi+bounces-12460-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9FD38A71
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 01:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD55302C4E5
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755032F1FDA;
	Sat, 17 Jan 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXNWEKcD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303A2D94A7
	for <linux-spi@vger.kernel.org>; Sat, 17 Jan 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768608001; cv=none; b=WskholR6CpjN5qgZAEHfbtRSEreJM/rBL1VZaz89CaP1fQlSsbKv15zHIERLq3XkOHcrHd8gJDcX2lg5Zer1VKgdFbf3GhvUgHa++vQC84b3/E3LTPvASxgxjHpxMfeNpKvmkhtK+QQQ4AvNJ0ZZyoQ7V51QOc0/7rfWEuUDBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768608001; c=relaxed/simple;
	bh=V9sK29g1p5L7gGT16/FNCt2O4Xzs9alkyoMDkJ74J9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Tn13j7lTHRV4ZgFC8gHzdCtGD4UeMPS156CT+U3bIBaLIbEQ8kxm7OxDC7KXbqtg8KUWQNmfOaCvND/eLPbwgVtVHPGdbJlP4sLRr/sKIPUmyseRJccENPzM+qmFUb5u7R51AL6bGRGBA1sABcENl4vZKeLDUItRBiDk57S5+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXNWEKcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073EAC116C6;
	Sat, 17 Jan 2026 00:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768608001;
	bh=V9sK29g1p5L7gGT16/FNCt2O4Xzs9alkyoMDkJ74J9I=;
	h=Subject:From:Date:To:From;
	b=bXNWEKcDVIyE3drRro/VAhllPszAJHBoldrq0lLGjtAiMFmvJLKrkVRx2FkzEuc3U
	 mxfTF1xGXTHvM1icbDZKg/Rj/EQKW9PKknnfKhgYyF6yOYsslhe35Zo3jWaa4HWr1S
	 bLPhZQWb5lmJzUCvcLB6eiLGvXLuuNKwD2XPttOmiViqAW8eRMy8qTU7cTUE4AjUnS
	 cp31OpgFeFfbE2RUhiifFn7IJZsh69x4cMTeFOJlE+H68SQ7PDseQDMKCFFqvgn+Yk
	 QDT6XRF9RkxkF1dGfPnxUqnbTOmo/3WdBTcOunrayZuKGYXv0iDk4TjLw6XHZ+ZC+1
	 l3xy+44/2Bo5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 000BC380CECB;
	Fri, 16 Jan 2026 23:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176860779142.841133.2407003647584011366.git-patchwork-housekeeping@kernel.org>
Date: Fri, 16 Jan 2026 23:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: xilinx: use device property accessors. (2026-01-16T23:35:33)
  Superseding: [v1] spi: xilinx: use device property accessors. (2026-01-15T00:33:28):
    spi: xilinx: use device property accessors.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


