Return-Path: <linux-spi+bounces-6113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E519F6DAC
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 20:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBCF16E7C1
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49441FBCB8;
	Wed, 18 Dec 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpcXE/zW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706A1FAC50
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734548415; cv=none; b=ixxqoemDyjcA/VLOmzu7HmOdVlrChTXQ2DxzISScrA97TsO/MG5lKuteDj7Q5RCWqjcv7wJL1E0k0FuUEqQgMmcOMxzvkC6lAYbzNcV1phWhtrjvT2vaUbfPgNkGA90hTXwpC9wA2NwAzDoXmrspU7nDcpY/1sYfRv4ZWm3Pums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734548415; c=relaxed/simple;
	bh=SDNOD0sQdF6960lh1w+l7cRjOU+2z3OpUSy7s+x/zq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=t+5x2l/ZjbsY63Mb4OCsRIZVYgKqxiaIMR1u6/qymUGBPF7a3NVVWegYauWW2n5J5z5cy3YCQ427/26nv2E3q69uufdljadWCr3o/e2+gnoQJpjbwbsfAmoOr6UdNKwTgR+H5RVDBN5KKW92KesLYMa3VoeqrYiZWGxqdX1ADUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpcXE/zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1296C4CECD;
	Wed, 18 Dec 2024 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734548414;
	bh=SDNOD0sQdF6960lh1w+l7cRjOU+2z3OpUSy7s+x/zq8=;
	h=Subject:From:Date:To:From;
	b=gpcXE/zWHfmbpSp4xungasaKA/cpdijmaRqPbK8LgOzQ+4OvSVsAXXKUmwa9GVfkK
	 TpqzYZRpjWlEmKGbtgNVdlhFvYJlTuRdr/SMJUL6k7fNQ+id5vidDDbuXQqFXQ8Nf0
	 +mPYZ0dlFZD/LJhPb5X+cm7aRE/+5Ndp8avGlsHnPGZEnUzv2tcf2xZ7TCl6vr/mS1
	 gGTzutrpmIvlWEmGrnI5bnkdujnIaDpDiVxznc3Iq7MbajtqCxD514Vft1sPylPDBe
	 MGPUQRlqCig+qXBkLrmKKXFXY7taXwYqIJPD8JYQc6Ey05OuByFJmXmZOYStT5ZaKO
	 XHeztRoXTSpQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 762633805DB1;
	Wed, 18 Dec 2024 19:00:32 +0000 (UTC)
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
 <173454843087.1702780.2903167146614613691.git-patchwork-summary@kernel.org>
Date: Wed, 18 Dec 2024 19:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atmel-quadspi: Factor out switching to Serial Memory Mode to function
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=919177
  Lore link: https://lore.kernel.org/r/20241218151754.365519-1-csokas.bence@prolan.hu


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



