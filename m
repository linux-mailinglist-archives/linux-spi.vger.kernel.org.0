Return-Path: <linux-spi+bounces-5529-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E649B3CBD
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 22:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9AD1C2210C
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2024 21:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA91922EA;
	Mon, 28 Oct 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puFMG9i9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B8188904;
	Mon, 28 Oct 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151175; cv=none; b=qph+7SIq0P5zwbUMbKbYzw3r/JzuHls35z1hjpvzUNXCSDsietsfW/ZOnCtY+itULmF+eisUV89lv2tCwWINNQfg7GsaTPzIutCZehXzNCnUkGxT1mpHvXHIPo+vDQucvtK6IiSDsU7513Gxt8s4HQCTYmMzDFkVH+DhJZMWQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151175; c=relaxed/simple;
	bh=HrUzE3rxy10Q5VWplBRJE4pEaVxPL2vTBDydWe3Y998=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FTx0QVeE/yP4kPD04u+7TzIN+VgXUd8/AXreVALlxD4bDIZooX5qBMmzfwpFy6K4HzxK5zVH09c9HWtZBgrkshVha5pyg+ixEXkbBqcbqi/ul8I1ItTbZ/EFw8Bub17A+zUUqLApCTv6SknKNxRhYiIZwKMSNj3bPNgu5W0jQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puFMG9i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3A1C4CECD;
	Mon, 28 Oct 2024 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730151175;
	bh=HrUzE3rxy10Q5VWplBRJE4pEaVxPL2vTBDydWe3Y998=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=puFMG9i9pSEapylsV54V7Twjz3M4zT0F56OhkdYX5j8HzP+cBkmQcAKpxg2hLZJgr
	 qNtw9YzxVhnxTbHKUWNZTYq/1NqVQN3p/uF4MCiLovvlXBDq96A3d3vg44d/OiYnrU
	 k2ZVfS+50Gpgx0XKy+eVaZDf9krDevx6Jr4/U9rMk419KlXbP64fcsid8eGwSkYZik
	 huO8BhFsxEQMjEDr17BNXJFgUQ5cLSrHUd+tc9vFqSd4reJVwX/5+TRejVZNywVm7f
	 YcF3X3vIM6pc9kEYQqUjCY57vDde43uaKQeI+YKThb05m/G3zghDToZAzHvc3+ZS+B
	 a+2AyQ/Z7U70w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A4680380AC1C;
	Mon, 28 Oct 2024 21:33:03 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <e32f70e4cf5a79406b835f85d7923c51.broonie@kernel.org>
References: <e32f70e4cf5a79406b835f85d7923c51.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e32f70e4cf5a79406b835f85d7923c51.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc5
X-PR-Tracked-Commit-Id: 25f00a13dccf8e45441265768de46c8bf58e08f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e42b1a9a2557aa94fee47f078633677198386a52
Message-Id: <173015118232.187664.1465955736871463454.pr-tracker-bot@kernel.org>
Date: Mon, 28 Oct 2024 21:33:02 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Oct 2024 21:13:42 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e42b1a9a2557aa94fee47f078633677198386a52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

