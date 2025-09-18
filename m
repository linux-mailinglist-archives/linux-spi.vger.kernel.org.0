Return-Path: <linux-spi+bounces-10132-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C2DB8629A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E551CC11A8
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97F30B51D;
	Thu, 18 Sep 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfEKllaF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1A2641C3
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215405; cv=none; b=nQNSiCaLE/TmARu0cNhwTfYQVHbGDSSYlD5tqqufKLjhvv8hyeAeVwoOmEU8SRd/QYYYGcQdNQVo0ohvKiqKNC32Fh4EYCs1T1HtNS5gBSzOId61TF1t55IBu4izUES133Tynx+1bdsSVk/r9rYk6rOqblpNZ+cVaoUpMZ6phnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215405; c=relaxed/simple;
	bh=e8BPkXjwehDMyApOIwxVVg5+J/Hmj5HlQEfSnMSJOYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fSWL+tNtwUEd10NF0jd0ZluMXRQijojo2Oe4CgJFIuqzBcS60O/sV1853eDYlMfn4nbfXIevc/EM1e0iLSlINxyPxUee8jtGon7azXDMgDsaIAMMGFEoMYGEEj3gfJBrol/+vVTc58qH79oR2tAwulWAUxkTMAEU14xnE/TFTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfEKllaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EE8C4CEE7;
	Thu, 18 Sep 2025 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758215404;
	bh=e8BPkXjwehDMyApOIwxVVg5+J/Hmj5HlQEfSnMSJOYQ=;
	h=Subject:From:Date:To:From;
	b=nfEKllaFoSFKym3uSqNIukwNEleFqrE0jLe0N8nrpnf4yiyKoX/+rzSyRoaPNO6H3
	 2wiBaWUaYrByOVRI56RL4gCQwBJxMshm/tj0AS9l6TQVCoKoQYn3ID61ft3M6Wddql
	 5RsJI2VOsd1de/R2+fsm+mM/Nc4k1G+Iiq+mUAi3ooFPceWj0RxS4IM7u/9i4z0jlE
	 +yFw/i2MTH4EpzoahihaYRFMGQ0YzduO1We+ip66gLCAwHkMU2RgRN2uZrNPLeOQSq
	 rJ5kTAh/7bIqrkt2s2S4rtsLeI9nSKXPvwl1rOYKtWUjce621Rr6AxRGQBZHeOmsI5
	 NjWmX1lg8DZow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B209E39D0C20;
	Thu, 18 Sep 2025 17:10:05 +0000 (UTC)
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
 <175821540423.2504783.17593646318258550488.git-patchwork-summary@kernel.org>
Date: Thu, 18 Sep 2025 17:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: mt65xx: add dual and quad mode for standard spi device
  Submitter: Tim Kuo <Tim.Kuo@mediatek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1003192
  Lore link: https://lore.kernel.org/r/20250917055839.500615-1-Tim.Kuo@mediatek.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



