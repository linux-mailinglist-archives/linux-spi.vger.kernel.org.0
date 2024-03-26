Return-Path: <linux-spi+bounces-2044-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0CF88CF89
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 22:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04B81F67B6F
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311213D884;
	Tue, 26 Mar 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyxL7Z0+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5813D881
	for <linux-spi@vger.kernel.org>; Tue, 26 Mar 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486829; cv=none; b=e0XqQmOk9DfdKKj6inYabf0RtfKilSBy0jvDBpy609MDuo2HnRPYyZWSi6aD20QdBYxWWU6JFY0gyKngZrJSiucZ87Ff8wCL8ASldZ4R0KIl5TgmVQ+XB9hno0SyoLoHNx7/nOomPL5gwL7I0rYv02K9aczFrQdIhjp90jrzCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486829; c=relaxed/simple;
	bh=kQkEHnV6Qju5Tt6me+o4y+iTGDm3IhmuBTk7pgE/MfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ip55RQAwnulW4Kp9mI1dvkStebGTZWZGF762MFg3HY5+mgr9WeP7ZHU2IJus4p57z4Fi4pL5mDJobxFF3aSZVsUbfzfjNFNED6BNqfIWdfLlUpSLkcKVYqfAOvcvLPQ1WgQfGej+zY7Cc3V+DLB7yOPQNfEJUqpHfW04vevbaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyxL7Z0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F34E4C433C7;
	Tue, 26 Mar 2024 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711486829;
	bh=kQkEHnV6Qju5Tt6me+o4y+iTGDm3IhmuBTk7pgE/MfM=;
	h=Subject:From:Date:To:From;
	b=LyxL7Z0+XAiaIC9b/YNgtPQG0lP0JcXCNZzD+NsxFKwu4JsurVpJZxbVpghcVxPCV
	 LOg3jWhIpXCFP34Shfm+BrfcNBnWma9aPHx0bbLKnKKS7sDm2kC2iI3PPs9cLTFZa/
	 XB1aE5K4rb7INLogJcvL2nuIiytOiQCkP4dULXgm0fJ9PS2arM9f46sfPhRIRQa2zB
	 gPNDLHbL/toGmx9vvUwDNbXIwGP6ZG2dpqTCrL2+qjK77r7IEysBryu62J+n+CDsQY
	 hVcWJ5xq+RUjQ378X6EDugeswcMAKl4Ea3d+ceUZzLe3doASv+QGIqNH0DenBFE4jc
	 e7l7eWWit5yNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFECBD2D0E9;
	Tue, 26 Mar 2024 21:00:28 +0000 (UTC)
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
 <171148682885.4554.12538899366026746361.git-patchwork-summary@kernel.org>
Date: Tue, 26 Mar 2024 21:00:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=838517
  Lore link: https://lore.kernel.org/r/20240326181027.1418989-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
             [v1,02/10] spi: pxa2xx: Keep PXA*_SSP types together
             [v1,03/10] spi: pxa2xx: Switch to use dev_err_probe()


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



