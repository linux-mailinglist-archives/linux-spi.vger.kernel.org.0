Return-Path: <linux-spi+bounces-5611-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE819BBB27
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CBC1C21788
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E001C4A32;
	Mon,  4 Nov 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyDi5atU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046B1C07C3
	for <linux-spi@vger.kernel.org>; Mon,  4 Nov 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740222; cv=none; b=neurwM65V2o9Ju5502uzGL5uU1NMpCNHzWV+fxnqjkZQ/IE+s9nA3RLGXv2Y1ShgYHvSulaAbYbR5LbFo1ubrbYMjKG3RER0VWvXVPXOeI2b00Q+SbGl5bPHOOYCyYCXA817iDOk8K5sgk8W6Uc44QoTvTteFG/GXKO+6YhuBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740222; c=relaxed/simple;
	bh=KwubttjHz3HJfvDzxceTyhb7RIUwDsNlqCPYadsfU+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mVWlpwPtyI8sJ11KwANa0/X56ueJwdWXu0w7YBlG5fHrGmuByihiHqYGxhFBjorZDJGKfq/qAZIpEY/TUklH4GjN8NKcEmkeGohNOvSbrVnXYzZ6BIYQv5Bl2z+jvhYU2qeM0tIekcZwBZF4Qig9RaLSw/B49b2joor5kGG3VwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyDi5atU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2630C4CED0;
	Mon,  4 Nov 2024 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730740222;
	bh=KwubttjHz3HJfvDzxceTyhb7RIUwDsNlqCPYadsfU+c=;
	h=Subject:From:Date:To:From;
	b=eyDi5atUCkZkpkh67VgIR8jJXliSmpRlp1EEPnQZ6Xp4W0I19lh9APG6nks/dg077
	 KGToJag1B54OzT3EjmgbMYcyGL+59ShPTnXvEzN2PQ4sdJm+S07JnjtTYYDqOyoTVI
	 1sii8n8+ylaVWQQrxu5QTy2PggutgvH3N3UTaNi2t1Nn3LXYhyiluf96/56SgXOJ7S
	 YoQsV4HxFuViQX+t1akGulrax2TksxfzKJf1DMc292LBn7LcO4ETrXgzVjNKOQ8/od
	 FGYDpRYTo/eoTa8FaxJ3m2f79vbsnVOLw/JeSy7v7FvyQB8tOMaqZNx8icGvsB2buy
	 vM4jCvy6yWXGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B7C483805CC0;
	Mon,  4 Nov 2024 17:10:31 +0000 (UTC)
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
 <173074023025.4139358.13158936245291508169.git-patchwork-summary@kernel.org>
Date: Mon, 04 Nov 2024 17:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: MAINTAINERS: update AMD SPI maintainer
  Submitter: Raju Rangoju <Raju.Rangoju@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=905892
  Lore link: https://lore.kernel.org/r/20241104062327.1228521-1-Raju.Rangoju@amd.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



