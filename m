Return-Path: <linux-spi+bounces-7770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CCEA9D413
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 23:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801681BC2DDD
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3398221DBC;
	Fri, 25 Apr 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URDyBAmh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED0452F88
	for <linux-spi@vger.kernel.org>; Fri, 25 Apr 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615990; cv=none; b=V5BVIDB+rSYz/F4t9B+/fr4K9rfQ7Nx2bEwIUrXGKyCH6ngMxlzHUAk9OcCAOFOmw/EtFcovg7uud6LYDa2eoS+ZAuC64mFnxreXMO74IPwZvqlCVf0S71Bvev4vB8C/CqNACKMZTXBfVlXmczxMYZCAfxo5AaWMSOZ2NzVfD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615990; c=relaxed/simple;
	bh=FCPm55c8REzp83cU1A7sXg/4IbKk7YLq6bTGVcYTSQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eQn6JtZbwy52IvioC/lg6PEhubzDZK6rApPwpbqDLLfPKD5Oi6zS3NJFSzre1zdkSSTNdud9LvhWf4RDsS13x1fnyAYWEomRwmPKyti5s4WYxD70m5pdscESDkMduJecFN6n0LCKD62uuas/DqZmaMl6ABoBOuuLm9/K7EY2ytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URDyBAmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE851C4CEE4;
	Fri, 25 Apr 2025 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745615990;
	bh=FCPm55c8REzp83cU1A7sXg/4IbKk7YLq6bTGVcYTSQA=;
	h=Subject:From:Date:To:From;
	b=URDyBAmhUVK9jPUamyLSu6UAdm0l5GEuo/o5NOjRsM7KCmSPhwUJN9GdlAJvUFMgO
	 9Pn8QSDJrXUUNjSpb3oD+D3NcO0uE44TZ4+m0OGDclYR4Odl1oTsimCTBd5S0HAyS5
	 IiBnJLyM7fxUc83LXXl9KnmlhfZtYCaaHMkEL2J3ZA3qQ4aKnR4K5pwTM+sDenurv8
	 7ablJdUQLsauzfvisMFb8tvhKc828ZIyCbfn3UPuhVV734z/PAc3RWuPVOU7274AEq
	 R1ltIlO1nsrRjNOkt+0OMchAvQY/L38oiGe7MGQeRQC02X9DG55GsVV4BWGnhIC1UM
	 l9EIcuATDDCwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2EA4380CFD7;
	Fri, 25 Apr 2025 21:20:29 +0000 (UTC)
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
 <174561602830.3844535.934949507715321423.git-patchwork-summary@kernel.org>
Date: Fri, 25 Apr 2025 21:20:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: remove unused 'wlen' member of 'struct qpic_spi_nand'
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=956715
  Lore link: https://lore.kernel.org/r/20250424-qpic-snand-remove-wlen-v1-1-2a7467ce2e3a@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



