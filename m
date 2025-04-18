Return-Path: <linux-spi+bounces-7667-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD39A9312B
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 06:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545421B61E02
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763A2522A1;
	Fri, 18 Apr 2025 04:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa5XWwcQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEC1CD15
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744950013; cv=none; b=rWM/AtJm7IMMjrXf1rSGPiF4SYP/hhAWLJ/W9yXHTfvGy6hLHN6Ji2Rizl7lDajFnYmo3lgr/BNIrq4gfgLvE5rqRHEoSMVz9eabcMm4XMrJML/C+fMpXkMAsBOYrZ+mbacExYIlWi+QcMG/yWm1m5hmlKHgyxpzSxlnC6N2gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744950013; c=relaxed/simple;
	bh=5rzUPL/G5IShvwBog7Vrusz5FbsdJoqxZkEdvGSzNfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gWMrb+no5hlzZfsAwFSZxY098zEweFdo5PYdQUVJwLPHZ7/nfxP9lLPc3VcHYDehmeOcDBQO+nQiDdsPpwwOvkMLv3dcb4qlB3OPplfOKQJIORIuJ1txq6iUUsERpPjLODRcnhNkBYNswk/lTLL/dQA0IrVXXueXhqTruB0GHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa5XWwcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3C3C4CEE2;
	Fri, 18 Apr 2025 04:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744950012;
	bh=5rzUPL/G5IShvwBog7Vrusz5FbsdJoqxZkEdvGSzNfs=;
	h=Subject:From:Date:To:From;
	b=Qa5XWwcQLtuy5FmmexIzbOngPppkwEtw3aCI4+Hm6r7iGZQIGPik9otzM9wBbM8gC
	 zFOSkWRVwjmHMxn4wMHogh7Er97+aRF+tfA1xgmIw46mjRkh46QVTRptsNF94XRLvn
	 zIusZu74fR86k1t7GixvHxjHzVty8TxTEcxG6Fa5ZGlYYT/2/Ugma7DjxuMilTRqrU
	 bCwBZPzdEwh2gQFZt/MInKmloQTnH6hi/kLlAB4vviyqdK4zoIytUhf0FwlXl59XFM
	 UwkNRmJie2ipYdQ9Todir/HJnqzWbV1KB1A1drC7cwyXJWNt69OhMkmCkiNwLUNDxC
	 G3wKvbng3XNQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1B76380CFE9;
	Fri, 18 Apr 2025 04:20:51 +0000 (UTC)
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
 <174495005022.107033.1768239300547738104.git-patchwork-summary@kernel.org>
Date: Fri, 18 Apr 2025 04:20:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dt-bindings: Fix description mentioning a removed property
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954416
  Lore link: https://lore.kernel.org/r/20250417111630.53084-2-wsa+renesas@sang-engineering.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



