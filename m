Return-Path: <linux-spi+bounces-6636-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDAA29D98
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F60916789D
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E751FECA4;
	Wed,  5 Feb 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoJDeMmU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA481DAC81
	for <linux-spi@vger.kernel.org>; Wed,  5 Feb 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738798806; cv=none; b=Sye20W6M+FHiHwASM0JhYhzkDQJB9n4qPB045fWHPCiC9Ec7TiHbbxHDSrxLbGdjVFus3KPfWA1W0tS0yFLHZZbFohQ67QlP9aGLEJ0IGeWPHHMOhiJyPwjAoApHJZwW84SiKMksbp7zFITfJHvTd19XY3DagYR0Qa6qzDHxDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738798806; c=relaxed/simple;
	bh=byb6QwKBzvp5yXo1x96WhzdmCwsr7/ZZ21csPzkj+/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UFaX/aom9l2bkxdEZL/Rgi1kq1+GPtJazT7vXjP/XM9DPx/N7LSseVIo1Mlap13PkQjDahWUtmiulMXNAmuU+m5EFR/ISnOfdo15zefQGta2mTFzOk5ZEtH/xi48KHNbUokdkmUzJUT06x0uFmbEGy580gDwV3aAiBPzmZiAPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoJDeMmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78B8C4CED1;
	Wed,  5 Feb 2025 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738798804;
	bh=byb6QwKBzvp5yXo1x96WhzdmCwsr7/ZZ21csPzkj+/0=;
	h=Subject:From:Date:To:From;
	b=UoJDeMmU6poC+H6FhPbuPHNNcjUya0GD6kHPzXoTkLRTJK/rlLlpJQK6W2ts78Mcp
	 H5NFHLFAHlZ9TkopqJz5uHlYGHJ3yLMulDvRvANptSZzdtr6p2aUZVXWeHHbqLOpj9
	 p9vtC/MMZ4MEY/J7V3veKQtzE7fmZmHvWNPFleamJNQ5zfG2/ox5T6tFj/lExg41LT
	 G5CRAIRUMqHhKch0tZCkRWfKsyO36LnMp5giCM/JXAXB/BUeDp6+ol+DSQjT7bH6X5
	 QTfvzzr1arIk2Ss2QWaYiSpG4ja5ZbZa6R5bDThirqka5UYyY+ueYQfUaNUMssfITT
	 HL6w+FwOk9NTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78988380AAD0;
	Wed,  5 Feb 2025 23:40:32 +0000 (UTC)
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
 <173879883086.942111.12209533975420517151.git-patchwork-summary@kernel.org>
Date: Wed, 05 Feb 2025 23:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: Replace custom fsleep() implementation
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=930815
  Lore link: https://lore.kernel.org/r/20250205130624.716039-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



