Return-Path: <linux-spi+bounces-7600-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2145CA8A924
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 22:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F033A4646
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800424BBF5;
	Tue, 15 Apr 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNoTCdvj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8023F296
	for <linux-spi@vger.kernel.org>; Tue, 15 Apr 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748398; cv=none; b=Yae5gsrEAvQecPFc4zwtdEFuzsomeG6GX3cXr0W5WaextgjgY9SH4sEaZumLxBFxfvXBgkZuTlEg+fERf4SlU3rMFuVIxLisk3pROlt/c1e+SpchdaTTMREGeE9uTUIbns72YYuhMvuw7I+rWXSy+SxnMmI2srBaJykCwPXJo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748398; c=relaxed/simple;
	bh=e0mMulbVCMgPboFTidZwhtSB0mgxAJhkFOOKtpvGZo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bZfCDUsTx6XYUuebd3/0yRW1v0VFFR5rcN39IMGZjKcnJdTKoLBgHY9kB0z8idZLHWn0keiYKRFpHKfArNysZcGdGenTJi9MfAnuxNpmj5j+UOzHlhTc5xObIHn8NG+x5vsGhh90TnW8Xafg3k5URR1WzWQPaO8ftcqAvncicaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNoTCdvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA07FC4CEE7;
	Tue, 15 Apr 2025 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748397;
	bh=e0mMulbVCMgPboFTidZwhtSB0mgxAJhkFOOKtpvGZo8=;
	h=Subject:From:Date:To:From;
	b=GNoTCdvjYbwgcVb+alAL32fb5hUnLgbWjHCT97/Em6ryNdRNi7BT4jFM/T9FvfEw/
	 P+Gf4jGWU6eqP1eSaBHNZPua+vysRZeJ0rNEJn2wT6WX9xoTPfsSbHhMMQ6z8D0BTz
	 RNREt5BrladgA6sRrFr3xsHv4nBaz3XtKFlLQHocKYVUxdSzcq3J9SWwBKQODZZiXG
	 gi2GQpYkNWVXoQzQnlpdSz8XReThlxEfJ6+P2X2+TJ1zoVKWJ6MbFPeeiBOdA/0b7A
	 RUBkrN0xZtq63o9xb1qL6IiQYhq5qe3ATG0G1hzvCNzY/BOyx2V67mknGd4i8IR3kf
	 uXqtEpeo/U+ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB293822D55;
	Tue, 15 Apr 2025 20:20:36 +0000 (UTC)
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
 <174474843557.2765712.13809177505433259150.git-patchwork-summary@kernel.org>
Date: Tue, 15 Apr 2025 20:20:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: tegra210-quad: Improve reset and tx failures
  Submitter: Breno Leitao <leitao@debian.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=944756
  Lore link: https://lore.kernel.org/r/20250317-tegra-v1-0-78474efc0386@debian.org
    Patches: [1/3] spi: tegra210-quad: use device_reset_optional() instead of device_reset()
             [2/3] spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
             [3/3] spi: tegra210-quad: add rate limiting and simplify timeout error message

Series: spi: tegra210-quad: Improve messages on pathological case
  Submitter: Breno Leitao <leitao@debian.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=948959
  Lore link: https://lore.kernel.org/r/20250401-tegra-v2-0-126c293ec047@debian.org
    Patches: [v2,1/2] spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
             [v2,2/2] spi: tegra210-quad: add rate limiting and simplify timeout error message


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



