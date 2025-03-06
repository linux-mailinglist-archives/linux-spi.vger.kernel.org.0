Return-Path: <linux-spi+bounces-7072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01775A55899
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 22:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59935188E7BB
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B2207DEB;
	Thu,  6 Mar 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br+NGEcs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2378207A1F
	for <linux-spi@vger.kernel.org>; Thu,  6 Mar 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295998; cv=none; b=RYiQVhaFSQPt08LVv5vmILCdLMnQNFiJ2JSpcEWsgYg09Omfe+FjWuqzhv8O0tueXZ5CRJf+axh1mGcw6Hqg6z/QP8DECjD2BUg6tbaWtxLAU0vU7yJIXBTaQ3bmrWsl712BkzbWjuWZypHJKFmStYYWKqbYLE8JGvBphTpvmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295998; c=relaxed/simple;
	bh=TLkBLIioKXe62V4e0/uYX0XpoIbNEAkynCmbFC/OEQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZNZy1WGjNR3x318xH9lhU+FlFunn0aykrqpDmvTAUkbsVSOk8zS6F/haewiCDBkAbEYCjX1YvVQSGOmqngn+yYLQBBfe+FACTV3IsdyV6rdO2CNcmWJRDldMM6wFyCkHqQr7K2C4u4sD9ertCQ69IehfTVdIfkPsT1dD67LnJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br+NGEcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494E7C4CEE0;
	Thu,  6 Mar 2025 21:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741295998;
	bh=TLkBLIioKXe62V4e0/uYX0XpoIbNEAkynCmbFC/OEQo=;
	h=Subject:From:Date:To:From;
	b=br+NGEcsjHVJH/htg0hZ+FF5ROPlFMKgcOsNBqUWQFdbyaErRsS9S0CbzD0PvVI9w
	 fMOaAD5qP05YK+9MsSJ9pJZLOSWcgRcWz9vJdFuBSkf8E0FXYCqUHD/LoqIOJhKoyP
	 dbyB3p/UF9kkaGw2BhcB4sP4eyEnUnRtgyh0uzssIGXrZPHey5bOkIJxJK9YxeJb7s
	 atZdO+WStrS2dgakv2ZejXqFLMLSaGJbgoCpT4hODuMI8glKYKVjF1yrm/kTYGVEhT
	 r/OtAqkXgrX2iS4jwvvtLenFJdvpXqbaQAYQ+vzxT1RqhhBIYes0MIAn6o+DyY/gvX
	 sYCUyEnAYKP3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1D39380CEE6;
	Thu,  6 Mar 2025 21:20:32 +0000 (UTC)
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
 <174129603126.1782458.12386314021793581437.git-patchwork-summary@kernel.org>
Date: Thu, 06 Mar 2025 21:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: fsl-lpspi: Add i.MX94 support
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=941128
  Lore link: https://lore.kernel.org/r/20250306170954.242707-1-Frank.Li@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



