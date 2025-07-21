Return-Path: <linux-spi+bounces-9149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765ADB0C85E
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440021AA0239
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634FC1A5BA4;
	Mon, 21 Jul 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrfubV2W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70422338
	for <linux-spi@vger.kernel.org>; Mon, 21 Jul 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113667; cv=none; b=VjwflsgHhZ+U25/7V/goFOkT39MkmjI3QfGu7HN2/MTJGlVJ83IdzQUR2sS8EnN2seSrufrzdK2f7CAcE+I5bJG2bQFKJtGGvdaMX6oLAt9ORs4FjZTMPRqGMoTkBlG3X8/4WGPnxKAsk+O/aEP0H31TdqiNbyC09xg1sMGWJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113667; c=relaxed/simple;
	bh=CgGurTQLI8hPOLHkcfyfPcL80kO9aCUp3g7SflV9whA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E2w/GQKqMp6GRqUa7eKmNkABwymY9++sRaFr4Q70b4dxHtYPodyu6lpidjveoozK0p3z8+sHpCxe3iz9pRBFGVBi8CFCmDdiEo853cTfTTHf0OB1+b0ROOiOSpHY9nhnignbU0pE0Wsm0qw76/t4OD1hljjJJ2sgu7js2lHdwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrfubV2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B64C4CEED;
	Mon, 21 Jul 2025 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753113666;
	bh=CgGurTQLI8hPOLHkcfyfPcL80kO9aCUp3g7SflV9whA=;
	h=Subject:From:Date:To:From;
	b=TrfubV2W+0SCJInU5J5Iv01h9Q9wUKsWaowb+JbMKwd1tvtmEZcdjx1Hy8jQy+lGg
	 XejlIvvRR4KC0ZVIXI/WPt7EG7isUXc9ChMs03qVGE83M0yPc6e7pndBBdlzeuNl6M
	 8KO3+uyjEpjLUtJG34qqp8oAUWjXswTrTpjg48wwyNfK6l1fWugyDOSkmyQ5Q5kZ5f
	 VOM8BwMjZ77tpeDR2uyJcXg5VrNwUJvIavJHEAdUBVJabOPn0K2f5OUTKraVFQCImb
	 vQdNBQNNGG5upjMl1P05bAVlxLGlQxaXYV4e/kNBHCok8RX2msMJZlIz/nQSFFpEbi
	 QNJLcFC1obpDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1DDF383B266;
	Mon, 21 Jul 2025 16:01:26 +0000 (UTC)
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
 <175311368530.106474.14119764419010897225.git-patchwork-summary@kernel.org>
Date: Mon, 21 Jul 2025 16:01:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spidev: introduce trivial abb sensor device
  Submitter: Heiko Schocher <hs@denx.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=983941
  Lore link: https://lore.kernel.org/r/20250719063355.73111-1-hs@denx.de
    Patches: [v1,1/3] dt-bindings: trivial-devices: Document ABB sensors
             [v1,2/3] spi: spidev: Add an entry for the ABB spi sensors


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



