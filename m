Return-Path: <linux-spi+bounces-2368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641248A6985
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B611F218E5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF14127B5D;
	Tue, 16 Apr 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enNdvBuF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C086259
	for <linux-spi@vger.kernel.org>; Tue, 16 Apr 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266428; cv=none; b=VEuDG4eFfH4e/yKWfR8WJ8UQAijJbSMHxYGxEMTrqw3tMsWv+tm07KvE3fGDoAn6OUweEGucwKvHAx3LY3EJIwRhnvdfnvrqzXascIXoXm3Z1aLFU8FbxT+IODd8cftly1gY8YSKQVODGRFYoZ/Z7NXGsCKms1NZArw1tjbxCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266428; c=relaxed/simple;
	bh=c5hQger0LSL//3qeyY1dWCVN8LkkVODJM6LmWt/YK14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FlM+kWa3QUcZKWEv5nd8IQehppFe/lnTTd6rCcbm/6vXbgv1hWqa/V2d8jCQMvA735zRghVwRcFadOcLPEvjAGgw/YwzwVzeZPvJK3VYduSdMSqngh83pYQG7tnbPVXAdQIANhdYSVUB4FLXAQ7H1bb24OKlrguS5VO2h/8FS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enNdvBuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20E8AC113CE;
	Tue, 16 Apr 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713266428;
	bh=c5hQger0LSL//3qeyY1dWCVN8LkkVODJM6LmWt/YK14=;
	h=Subject:From:Date:To:From;
	b=enNdvBuF/c8BwnJ+3nqok2afxuOlSfpASWZDJ+zDSnYINO6Y5xHPqG6h29kvx0wN3
	 CSHZhUra61UH1QlOQBAbKCsDLzrphXv8uxnpWMPkQxQzZXyJ7MY5L7sWrqJ+/yFzxl
	 jvgyZEKgsy15EuCJoEPJy/Ge7n1NrdnSiSENP5czIPUHOSbGkc1WWpmgVqWqVY5X1p
	 T0sqKyKGEsBJF92ORyPAqveh9gGwD7msDddv1eZxmzVELNVL+30/hrqQxAZ0A/5M9P
	 z8PNeE8PNy5aikS8MNvTBUWTriFts1kC0ionl57ccWVG/Eo5SRiezj1I8y1qdq14Zc
	 +ANyUXaXJMGYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 068CAC395EC;
	Tue, 16 Apr 2024 11:20:27 +0000 (UTC)
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
 <171326642790.6844.7473810923328136065.git-patchwork-summary@kernel.org>
Date: Tue, 16 Apr 2024 11:20:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: Consistently use BIT for cs_index_mask (part 2)
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=844762
  Lore link: https://lore.kernel.org/r/20240415184757.1198149-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



