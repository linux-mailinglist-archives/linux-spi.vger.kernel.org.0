Return-Path: <linux-spi+bounces-7557-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C98A86212
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48B24A1049
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BE1F76C2;
	Fri, 11 Apr 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW21UhPy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47D1F2367;
	Fri, 11 Apr 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385975; cv=none; b=d6xecz09P9GrVPUNk5KW9n8GfxpwbbxS0t4zoS3m17P+98wLizEm2XfSal5ec5WozCIJLNlALhWbIeJCOwE1AXwIsWo+oug+1T9UACjouY/zp11hE4GJLrDzQruTEJkKBABXfxjQEKkOMKlpInpjflf71Wc7o9+Q2JUmmscbnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385975; c=relaxed/simple;
	bh=50MKho9scdY450+yBOEUlGRzF0bQMN2IFcIUceJ+5qk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M2o3X9uUAxSlroiUchA2umCR5cVT2n/4yUz8ptz7/ARY6atXa8PUHa+e59vFcmVAbdepb5lRZaFrFfx3wtDZDEHdWABu5UOg8CYTQi4otQfKPQrVmZU5t0bNdlGgRsWsgSlZqEMAPkntDDKqpUExrfGGG3uX7lNqFWbaC8NksC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW21UhPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A12CC4CEE2;
	Fri, 11 Apr 2025 15:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744385975;
	bh=50MKho9scdY450+yBOEUlGRzF0bQMN2IFcIUceJ+5qk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nW21UhPyHA6YS5aWD+MdM0xs+QcaW291+zsIhZRapOJ50JGA/AN/fqTHsFt5/R2wy
	 iMXcuctpYoHuiWM+4Bjplwho83ir4midbqdwPr/crzq+Bi/6cd2pVE63SE+HLTs3fw
	 ag01xNQ1XF8unWxl/2+BnRIRhtCJaChJQQi7meVR8cXTH/2bw3XAf6QeGANlea7ai3
	 7n7CizTbL5CcKR0+zDlI/eM3NZLR2Lnmpt2YJRPOL7RgWbM9CV4WYDzAXjX5/O1lE/
	 xJdagwsukS14ZuvGEPFPaVaU3S+XLHpVtnn23M1w93oqcF9UXN4aK/s5IK0pDOKfOP
	 aBQNEVa5d4KAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B538111E2;
	Fri, 11 Apr 2025 15:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <0bdfc1a8ab698e3518f29f4cdd3cab3b.broonie@kernel.org>
References: <0bdfc1a8ab698e3518f29f4cdd3cab3b.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <0bdfc1a8ab698e3518f29f4cdd3cab3b.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc1
X-PR-Tracked-Commit-Id: 82bedbfedd2fc7cd1287732879e515ceb94f8963
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e618ee89561b6b0fdc69f79e6fd0c33375d3e6b4
Message-Id: <174438601313.318080.483450061536018095.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 15:40:13 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Apr 2025 12:53:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e618ee89561b6b0fdc69f79e6fd0c33375d3e6b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

