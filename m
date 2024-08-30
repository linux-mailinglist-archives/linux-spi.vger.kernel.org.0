Return-Path: <linux-spi+bounces-4465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A59662F2
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE21F2490F
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F71AF4C9;
	Fri, 30 Aug 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYfDVSMx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B271A4AAB
	for <linux-spi@vger.kernel.org>; Fri, 30 Aug 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024631; cv=none; b=YobTGAKaqTSthnZECQgq8kDCI0wsXXvulLdtg5D0wxxQtdBdpdeaJaBBfqRe5Lb4MMiPMm1t3ab025nexVsvjwRz4nF3jMXHyZd0BcDATtR2ZjtU8ThkXNZyMcDi0CmX5EqiB3ytR6LZvY2/0QdsvXPF4zRW7FnOii4nPatneU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024631; c=relaxed/simple;
	bh=BkdE+HaCWpQVj2AAuxTwwXElIWNGAC7t4s+SAmoYRN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=l48UffgjovSm1giQ1INSVQ908awC2Vv2xJnFveCzCEqzZzwo+lTAVWF64Mly5uhnPIrU0F+c8t9S4ICuzHJtMGgvPWMvPzkXYQiIc4WHl3rihyqvF4pHTghLBq53vqm/orBgWldbbnbC4TahzfqBBr9VsyPXUx8fh2+tN3zTXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYfDVSMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45696C4CEC5;
	Fri, 30 Aug 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024631;
	bh=BkdE+HaCWpQVj2AAuxTwwXElIWNGAC7t4s+SAmoYRN0=;
	h=Subject:From:Date:To:From;
	b=EYfDVSMxCeDys1lD+a0WPHKA3Bp7AwgHACzA/0twttvDFVevl4OoMvNibhWEawU7D
	 61ddH3kjsiG2bOyTEItuqYnjFeUm/9J61OFWttaAeSyf/s8vWfjRKtN3acIxwmQj22
	 jb95fsY/jZ+e6z3iiAgTsQbhmJyPBiD7rwEpd29ehKfxZnJUAQMpj6RVFaGpv8r9Cs
	 JIEWrZWiqBu1smuXqCuGFdbolazssSWNl4AMJcQoOksP5/8G6KivKHhWBGJ6kjFEFb
	 22Qn1+3ofGqeqI6J7uyq3Re2rxhX8L1PT+HS6ISx12dnqzWMtRgaWCA3UjHD+ZzXv2
	 ihoMZ3Md6sU3Q==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D193B3809A80;
	Fri, 30 Aug 2024 13:30:32 +0000 (UTC)
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
 <172502463279.2593056.3269797085588751035.git-patchwork-summary@kernel.org>
Date: Fri, 30 Aug 2024 13:30:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=883327
  Lore link: https://lore.kernel.org/r/20240826124903.3429235-1-ruanjinjie@huawei.com
    Patches: [-next,1/2] spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
             [-next,2/2] spi: bcmbca-hsspi: Use devm_spi_alloc_host()

Series: spi: wpcm-fiu: Fix uninitialized res
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=883356
  Lore link: https://lore.kernel.org/r/20240826132544.3463616-1-ruanjinjie@huawei.com
    Patches: [-next,1/2] spi: wpcm-fiu: Fix uninitialized res
             [-next,2/2] spi: wpcm-fiu: Simplify with dev_err_probe()

Series: spi: atmel-quadspi: Fix uninitialized res
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=883339
  Lore link: https://lore.kernel.org/r/20240826125913.3434305-1-ruanjinjie@huawei.com
    Patches: [-next,1/2] spi: atmel-quadspi: Fix uninitialized res
             [-next,2/2] spi: atmel-quadspi: Simplify with dev_err_probe()

Patch: [-next] spi: spi-ppc4xx: Remove duplicate included header file linux/platform_device.h
  Submitter: Hongbo Li <lihongbo22@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885090
  Lore link: https://lore.kernel.org/r/20240830075800.3541646-1-lihongbo22@huawei.com


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



