Return-Path: <linux-spi+bounces-4810-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D830978829
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E46B21A15
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D0213C90B;
	Fri, 13 Sep 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF1IBUHj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BF12F588;
	Fri, 13 Sep 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253468; cv=none; b=r3asx8cf3oCnQ93u/VEE748MhMz624YPUHyB0B6S0BM/Mj+YNFJuuB2dDqJwnGIouGpP+V/yoeGxzxJ3jvKAKvjZd46aeZ/tzUfPPzZ+4RvXoaMiRRCedAfV01rsRcR7o1gnRYf2iJ5I9mjeb9h790PFjqaYx6AzHNY2X0dJh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253468; c=relaxed/simple;
	bh=eaX39mnY0tsI8w1bjjZrn/LIDJuAxjB4WUaMiOm5O9E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bopVgP5Ca6utYPGXdLnclsDgkoFJLUAElwQvbQk5nxI1vlRJyJcvbQSJO8Jw+teaUsIWRrh/yTHiUkyGZcJmvN7OpyFPaIbPoG/PXsqNwQSUM1bT7+BgKCGAuN93m3QapK+6WSojb9/1rv1B0iEcmMPbiCj5aF5mF4W4T+0KLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF1IBUHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9543C4CECC;
	Fri, 13 Sep 2024 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726253468;
	bh=eaX39mnY0tsI8w1bjjZrn/LIDJuAxjB4WUaMiOm5O9E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JF1IBUHjdqV4kmtl+uKKMwyHbh+XdlMNx9QWfilmydsNDK7Zv9/YgbWAZUMBQ9F3O
	 MAkmZzSgvi5D0IednBIdte6jN/T3bNT37L/XAIFU6bON9V0877hGOiXk0+jW0YIryM
	 6ws1qJpEgAU/KXCzslbGrjwY9EYzc+ZHoXgB5HvepoS/gGKEizLPiuVZ7SnfHHs6uO
	 EXD+mh8Eli1XNQv8faoJe+mnOoI4142ztbEf5UJAjwg0cs4YnBVlCuUHgUxMFWseFv
	 vkWRHKE82iVcVHDRacsGMA7vY/ENIWWfTiAyS4sPxYshX91YA5yFFqyF5IzIxLuWPK
	 AvGLj6wEsclRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342B53806656;
	Fri, 13 Sep 2024 18:51:11 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ba736f747a1d58f7043b187c2d1dd97d.broonie@kernel.org>
References: <ba736f747a1d58f7043b187c2d1dd97d.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <ba736f747a1d58f7043b187c2d1dd97d.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc7
X-PR-Tracked-Commit-Id: 2a8787c1cdc7be24fdd8953ecd1a8743a1006235
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e936e7d4a83b5ff6b7a685722f0ba348383af68c
Message-Id: <172625346994.2331887.8726510909126125255.pr-tracker-bot@kernel.org>
Date: Fri, 13 Sep 2024 18:51:09 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 19:30:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e936e7d4a83b5ff6b7a685722f0ba348383af68c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

