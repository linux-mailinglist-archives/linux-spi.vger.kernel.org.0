Return-Path: <linux-spi+bounces-2339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456028A4D2B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F01285917
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A34A6CDCF;
	Mon, 15 Apr 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpdpqVaV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FD6CDC9
	for <linux-spi@vger.kernel.org>; Mon, 15 Apr 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178829; cv=none; b=TQZkifcgFG5P95SGyJLD85nkFxD9vcDHn6DRFTHVnwUfYQAw+JP66dNQvswkoHjy+32pnLjcwdvgwdnR8BEc7Pd3E1dP0kEnV7SFXfJIclWJ/JCuCgsV69uUGUfvMgswI3Rmuy7SyQXVm9uTteor6sHOEzw2a+TFSnmtbmY4dLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178829; c=relaxed/simple;
	bh=F554x2aCNTkyM+bJblFKXRJsg+YqzWBzh2MfJDvZQx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fM7wZXpQB6TXGgTrOJGs9S7ZLykB3oUSzO8fYuJhzMpwhOs5ZHNofq10Wc+gG+45iLKa4DHQd1uSYcvbNSSFgG6uLyesF+ui3SFxO+F7NLE5/il/nouxE1Ns6FCnxujrWRXmZKGyFwrRwN4JTb0ac+LuBMM/WVn8rvi8KTNfXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpdpqVaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F3F5C32786;
	Mon, 15 Apr 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713178829;
	bh=F554x2aCNTkyM+bJblFKXRJsg+YqzWBzh2MfJDvZQx0=;
	h=Subject:From:Date:To:From;
	b=tpdpqVaV1G9g3+dCpOIs/9Rn1Fz/hmt6kQYpm35+w+tXT40jrr3H14QPM1q+HX6i0
	 +xDfxsEFzD3uI3FTCtccaDudgWUgrmNZ2rCLm5F3FTCOIIHwd0OH3JQkanh7z0arzQ
	 LjptoreHDY7bgNho6+nM1P17D2B+gTyjYcETkcd6BvMZK9qbdIRCk7J2lpAmYi/gIB
	 lvYBy0Ctow631iEEkwFMbGwTF+9Hj9ZRrI7EWGEHYLUhTeAk3is6oqeCHlGyidOG47
	 PQ3KJl3WAumtbeQGqW2oZeZ8GQvQBriR3wS4BuLJ163e05Uqd2ZiigIlzySu/SY8Om
	 bdTY35JIrhKhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC6E5C433F2;
	Mon, 15 Apr 2024 11:00:28 +0000 (UTC)
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
 <171317882891.26162.4110447340570971678.git-patchwork-summary@kernel.org>
Date: Mon, 15 Apr 2024 11:00:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: altera: Drop unneeded MODULE_ALIAS
  Submitter: Krzysztof Kozlowski <krzk@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=844385
  Lore link: https://lore.kernel.org/r/20240414154859.126931-1-krzk@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



