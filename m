Return-Path: <linux-spi+bounces-8750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F6AE6EE3
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 20:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593B917E58F
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68B225413;
	Tue, 24 Jun 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7lLQJO2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6A19DF4A
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790980; cv=none; b=kkEk5BFzDo5PQqJeuv3yAiWbAtqDmthneR/fK3jbZ0xSqDAKEnZF7XfzwCb+SsCowyZp6n79Z8TTfM2sVYH1xd8u6XNCrA8kCuNzibKnbd6d+WAwUF3k/1ZXCid6/dC4DA4p8F/TsbMELoz2Plo72Ru9FW4PaWFIGQgMGCjeHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790980; c=relaxed/simple;
	bh=Jh4Wnc/BL9QjmqGL3EqoZfGQ3ZhlV4CCc4xqyCaPHe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SnNjkyTLLvgcLvGvfejlxllHCZA0opcG7TGuCZIRL8Xl8Zu8gI9bHqMIV133QE8TeLarIAhSWeqYBZm5AACn3NXzY0dVU6d4OZMofTmyBlbxfRJmscRW4RhnBFK3Tj5btX+TrM3uLBHn1gc0bcCoHtUP0It5EUcZQ8Tt9CmNPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7lLQJO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D038C4CEE3;
	Tue, 24 Jun 2025 18:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750790977;
	bh=Jh4Wnc/BL9QjmqGL3EqoZfGQ3ZhlV4CCc4xqyCaPHe8=;
	h=Subject:From:Date:To:From;
	b=K7lLQJO2mOomvjGKQhWxvKY2HNcMJGU0XrjK6PCAVccysUoFnf0vnT5x9XktZ7ADs
	 gl3pRVcHRwqyKLF7y+Uw73bwSjCTEl7/TUJYoDl9AnSdDYF6qN5mSjn4zuwuLZkUVo
	 j3R8HDTqMfQKInPY0YLWu6p1WCkVLsasgXRp0E46Twh5EuE8RezHrPemxXQJ92FtaZ
	 wXpMVcWVFqk7aoivN1OtcyMql7Cl3UvWkbn9VMUWAUXVRXhFsRiCo/BovtoygjI8NL
	 7GlPScqWyOO72oZViWA941hoZ/eyEFPmciikgAh+kutYr0ytZ6G7Ia552oNGQZJsmO
	 Jfmb2PfUSjc7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7489A39FEB73;
	Tue, 24 Jun 2025 18:50:05 +0000 (UTC)
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
 <175079100401.4002645.7613322737550422893.git-patchwork-summary@kernel.org>
Date: Tue, 24 Jun 2025 18:50:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3,1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
  Submitter: None <khairul.anuar.romli@altera.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=972298
  Lore link: https://lore.kernel.org/r/4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



