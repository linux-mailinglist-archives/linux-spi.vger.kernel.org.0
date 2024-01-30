Return-Path: <linux-spi+bounces-921-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225B6842D15
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jan 2024 20:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B620B20C98
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jan 2024 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6840B7B3C3;
	Tue, 30 Jan 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq6tL0on"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451AF6995A
	for <linux-spi@vger.kernel.org>; Tue, 30 Jan 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643626; cv=none; b=Ef9bHCjguLmGDL80KXJH1F9L6pMSHEx6ft/1XVx/os2p60xhqOkpQpeiUoCb/HievcynDDU8UIdvmQ8cbMuOCUUOw7tzy4pUg6JUcvdI/dd1JfNwFgrz87lpz5ZjmHlJ1Jx+1lri7VpybVVbcus9PGGKk0aO05uch1LlD8bKQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643626; c=relaxed/simple;
	bh=vtT2wYLPnWHp5Ndv05fnV3tbPH2stYIOjxs8XB9p51g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j4rUSKHHwTP9whe4qGzrRIWiXIxRXmWwd0Mk3y3VshLXHQLdGpkwGm/J2tyCf2U0M5JwuZSnbEqcwWwyLZwASTYtUdDm0VMgfiySfmdy3ntc8XxxuyYnkjfL1wnWx18BqCz7SijyQQeWLi66CWKYTbv9PTUlspXNZ0e9JpYdxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq6tL0on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFB77C433F1;
	Tue, 30 Jan 2024 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643625;
	bh=vtT2wYLPnWHp5Ndv05fnV3tbPH2stYIOjxs8XB9p51g=;
	h=Subject:From:Date:To:From;
	b=Qq6tL0onr5ESYONBzA/koYvPFA74NqgCHivCcF3cTNLQ/bhOKfVPG+aeCSQRwp6jN
	 sTFWaRf3s6do023v/ehhAA1vesWY744Sqe0W4UD1vu72hItF+1YvDx74iy8/dIJInx
	 nBaCkgLZMsryFgeIfhyAK1zAXr9pEPAdFlyifp8czraY7+TMI131hzCT6s7rEPiFKD
	 4JDiV9zeQc6Zocz9QimwbC5UIpgJcYYFz8N980BUwqud+ZXkCPd/7miKhWWQNJwsHF
	 I0VlvPIJS+0aEQt4lefSLCW7mAcqQrViHPAzqbm7BF97oJvCMqW3U1rgp90bFig/vP
	 jXSnjS7RGY46A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91C91E3237E;
	Tue, 30 Jan 2024 19:40:25 +0000 (UTC)
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
 <170664362554.27209.7320956022996780705.git-patchwork-summary@kernel.org>
Date: Tue, 30 Jan 2024 19:40:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: sh-msiof: avoid integer overflow in constants
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=821209
  Lore link: https://lore.kernel.org/r/20240130094053.10672-1-wsa+renesas@sang-engineering.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



