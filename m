Return-Path: <linux-spi+bounces-11655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F74C92DED
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 865E54E1401
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01524C676;
	Fri, 28 Nov 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqm44Kb9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801221770A
	for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352995; cv=none; b=aIesgLrwBjcmGzqEqxMPqxnHpc7z8W5MzE6F0qr+J8EqUM3GHn374ymtLMsnp/d/6npAd4RWAyZRC2Yr1quYAmUvjJaSvvxvxdjp4ZBGQ4hXouhIjgexhs8R1PRrDt3U+WoJlMSeE6mMt/I4n/U+mLqno2tIaPtMq8eH7He7vGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352995; c=relaxed/simple;
	bh=32VxNtXAZnOAiHM85TIvKYhr8v4Dk3t6YzPEH3YR1Ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XsFmnWf2kKfUtKsEHE3owQ7Go7FvQrTKkAp+s3J/QCUj4N+7BRsxRRC/pu8jL5cIalQGDQOO8ZkcGmf+6H9tRSh5mG+FD0rFhzMHwmJQtxiBo1kX+cgNs4bJG4RW8nkrnGfXvxYUGutrONrLyfQWHZL6jQcCUr49NsxRI+s810Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqm44Kb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A1CC4CEF1;
	Fri, 28 Nov 2025 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764352993;
	bh=32VxNtXAZnOAiHM85TIvKYhr8v4Dk3t6YzPEH3YR1Ys=;
	h=Subject:From:Date:To:From;
	b=mqm44Kb9Mip5uUZwGq0k1jA0zA74RXqiVzPkD5PZBwF7U4KaJ3E4AFjQG07lJxohR
	 cgilxtlhj48WtVZ8aGkuvY4nA/Mj2yPBPWk9UbakD0vRooGBKs7pXbn2bkx4ssPlLx
	 tObbvVbg5tFxNtlJZMngn9DwoevR8apxUbc6fqalWjOrgKqluBQAfdCpW7SGl8g7kL
	 R31TlKYMqCKmGFJWEtxF4dH1DT9BPuzsyPGK2T2LaNKuKn7jfVspK9Eu8J68U8lIX4
	 ayiWd/gnQsIJvhyIrgXtu70yXQ8FU/4Y4kZpRoPjHAQCeKrgq01ONE7MFQhy9IxUZn
	 iCaM/WYcb8Oxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BB8EB380692A;
	Fri, 28 Nov 2025 18:00:16 +0000 (UTC)
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
 <176435281539.748759.5142514739059084054.git-patchwork-summary@kernel.org>
Date: Fri, 28 Nov 2025 18:00:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: microchip-core: Code improvements
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028421
  Lore link: https://lore.kernel.org/r/20251127190031.2998705-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/6] spi: microchip-core: use min() instead of min_t()
             [v3,3/6] spi: microchip-core: Replace dead code (-ENOMEM error message)
             [v3,4/6] spi: microchip-core: Utilise temporary variable for struct device
             [v3,6/6] spi: microchip-core: Remove unneeded PM related macro

Patch: spi: ch341: fix out-of-bounds memory access in ch341_transfer_one
  Submitter: Tianchu Chen <tianchu.chen@linux.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028565
  Lore link: https://lore.kernel.org/r/20251128160630.0f922c45ec6084a46fb57099@linux.dev


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



