Return-Path: <linux-spi+bounces-4694-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6779B96E568
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4ED1C23001
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732B71863F;
	Thu,  5 Sep 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fasfKlZt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DA8F54
	for <linux-spi@vger.kernel.org>; Thu,  5 Sep 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573632; cv=none; b=lC1V0puFvlCspTmgtgbrJkQ4BAbOP47lLIrbSt9uttgBQ67cJL0gG8KIRZkkK+cZuhA820FBfgjPZTzjVtDjxVFGw2AsCdzLBpQAwI3mtq8VFbSW9ib7xdmb1+YObsAfQJZIDHMSksO16GOpKrcTn3PS9JYC4kqa8LBNNk2L1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573632; c=relaxed/simple;
	bh=GrrZJlUTTnxwIOX3v+3URVIJkAZr3ItDgfWrqlRwxj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=J85oqz6guaMeLQVY6cY/V9bJ7PJKptnm1AJaTuijAJ+7lh1gCwqSdXQj0wjaItSEVO6y/yI+J+CQy7fvqMu09ge7GBAwcztQV9NZUJJf49wUnxQM6LoZUMNtUHj8M4NO26wzP7695B3rfmqAQHaxX7IcKIL5/6s5WtdQZ5V2AzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fasfKlZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D44C4CEC3;
	Thu,  5 Sep 2024 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725573631;
	bh=GrrZJlUTTnxwIOX3v+3URVIJkAZr3ItDgfWrqlRwxj0=;
	h=Subject:From:Date:To:From;
	b=fasfKlZtuIoAFexXUP2RUoJ4x9587T7O8U+wM+6jAC343J6EQMBC9sC+iQ/kzeU1N
	 66gsE2ZQcaC7S/VVbCgU3tmcDnHJPxV6CaU1g0KoQEOf4D30+nYxwb5Z7Lj94qpUg1
	 LhRIfc+zu6QKGTXHA2QXNahdBmmpV++D0/0sik4lTq/BiqRCTXqNpbsPcoQYAq56Cs
	 BIr7WecqGvpeXz5CRmiyK9L5L5KLxeMMVpKKzz+0oI4WEEKc2/IHbjO1CSFQTccisw
	 wctfzW+RJEEbNYym3Or7fu9c2SJtHhaOlXbvJJ+35itgQ2P3lzGcHHQz1wggBo6pB0
	 WU0pNRDMzjqAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B27973806654;
	Thu,  5 Sep 2024 22:00:33 +0000 (UTC)
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
 <172557363221.1856961.15539455419362904764.git-patchwork-summary@kernel.org>
Date: Thu, 05 Sep 2024 22:00:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] MAINTAINERS: SPI: Add mailing list imx@lists.linux.dev for nxp spi drivers
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=887326
  Lore link: https://lore.kernel.org/r/20240905155230.1901787-1-Frank.Li@nxp.com

Patch: [1/1] MAINTAINERS: SPI: Add freescale lpspi maintainer information
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=887319
  Lore link: https://lore.kernel.org/r/20240905154124.1901311-1-Frank.Li@nxp.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



