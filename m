Return-Path: <linux-spi+bounces-8313-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D47AC4F7E
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 15:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45633A67F7
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF725C6FF;
	Tue, 27 May 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYjLT4ft"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC4139E
	for <linux-spi@vger.kernel.org>; Tue, 27 May 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351991; cv=none; b=h0dwDlZYNZsx19GZSWt0RU3EgDKCMwMyG1gayOeTCyg7if0Vg20u7lARA0/GaS7AQg0xs2OrhE1UowD8qjTkES7ecePFjB5FgS90jyFSOGzJN/3xujPh+f/qDIdvBmI8I2ML5DG7ecZ8DZM2UvaAwrX3b9Lu3m1Tb7YsPuow+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351991; c=relaxed/simple;
	bh=CenGoT4G9VoV4N5K+o19kWe9AlmLSAm+A3y8Qef7PiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JzW1krEyRPUABfq8aq9UEN2NAcNe9NbtPJcpx9QsteBZUqNCakN57ahMdyxplEJwjx+B6mVGJMFT+QKutTENdjbH5vFLK40JbrzVDtvYqo1/PTtmGtO42s9oItIHFQgLb8AwUAxmw02fBYZkoUS81WhJ2ejd/P1dCFHPEq18sKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYjLT4ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A512C4CEE9;
	Tue, 27 May 2025 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748351991;
	bh=CenGoT4G9VoV4N5K+o19kWe9AlmLSAm+A3y8Qef7PiQ=;
	h=Subject:From:Date:To:From;
	b=rYjLT4ftKDERQN2U3RWq1mBgxbDwdiP+Bv+TLJzrAJEdXdF51M3WEvoeRUL78gNI5
	 sBESbuaKoejSl1WhJlsRyZHyKL6gaAH3wi+cKBBZFoTLtuQCiLiBUHwi9UkAUTLra0
	 wQ9uV8YBbdDkwO2Vm2iA5v0JGInGquyvx6agWA1wG8+8Ssv2KOsFITtTgPBGYYvP6F
	 361O6nFlz8ih4sP3dYAGywWvjPgrhFOCfDEn88F0jkWekJiR97fVHG0QX2ZBTFi40p
	 GEIVUpyvXJVRZv6zVU4Vh2DEJObYG5Yx0thLVyyKnIyLFSyJgQLsX4RFix4Wz8y0qh
	 V38nraPcZ2nTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7479C380AAE2;
	Tue, 27 May 2025 13:20:26 +0000 (UTC)
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
 <174835202497.1634553.14865685847138227085.git-patchwork-summary@kernel.org>
Date: Tue, 27 May 2025 13:20:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,for-next] spi: spi-pci1xxxx: Fix Probe failure with Dual SPI instance with INTx interrupts
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=966624
  Lore link: https://lore.kernel.org/r/20250527103244.26861-1-thangaraj.s@microchip.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



