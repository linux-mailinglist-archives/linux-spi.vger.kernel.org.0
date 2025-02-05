Return-Path: <linux-spi+bounces-6629-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7506A28AB2
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 13:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477AA3A51AC
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 12:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC69B64A;
	Wed,  5 Feb 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7SMm1Os"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6B8F5E
	for <linux-spi@vger.kernel.org>; Wed,  5 Feb 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759809; cv=none; b=mW2DKaYXbdrPm+RZEFNZ4UAsV8n5oFKuHEvo+AxYG/foSHY4sahaQAUPDO0tv7uSVcseVeTVm2CtveI4BMMWn7uRdswkSVD/P5X+wgz5lObKSUtRd4bjEbPDCGEQgFT/PzzluUjYhbF8J/96RlvmXshpTOFPHNeexuwZl72su+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759809; c=relaxed/simple;
	bh=C9c/0BXRMQ2SNgCRCSKlykSTWQ45bK6vQf9MeiGvnyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aa1nDP6712gd9DO8E2fSLb3SjkoZ70hyUCEwOJvsLX2eGIYBj+xPOHJ5Va8baqCWadotyS+SHvbuh/Vny6EIL4o5GzB8ZN7/WFHVwXmJnv+LuJ28eRQKwZatz8vdlZRLSNIupTz3cUnIoZ0bh907C1jKVlcNBrJ0SZ3AhlvVyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7SMm1Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAC0C4CED1;
	Wed,  5 Feb 2025 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738759809;
	bh=C9c/0BXRMQ2SNgCRCSKlykSTWQ45bK6vQf9MeiGvnyE=;
	h=Subject:From:Date:To:From;
	b=k7SMm1OsCT8kAdvLiv/EKXalTbMwrDNo3sd8kQuuUC08MtNJorZlUwd4XmMwfiN/g
	 7BIiSFFzAKM1r8Qb5/H9y2rQ/USDueridh7WdBbWuv4++Kd0t3Y3LzD7IxMm1uxmLD
	 ExnC6yABKIQS0Lfq2Tpx9caYbygR0uLC8xPsiJ773DOH/kT6jYySt5poKFUS7WO7l2
	 /WbHXlD6QfYbNVDwyHlm4jv+0lrvkG/GIhwdDftODv0FTfI9QSKp/IJuVlA3EaXjLt
	 mpVwvb4qNWLvZinCP/c3x//K4wF1c14GKPGQQ/noZZ+3/ClcmD6XxH7h1AE2mNUH9h
	 DQX5HBbxbJllw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F38C1380AAD0;
	Wed,  5 Feb 2025 12:50:37 +0000 (UTC)
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
 <173875983658.746134.7966760867893535919.git-patchwork-summary@kernel.org>
Date: Wed, 05 Feb 2025 12:50:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fsi: Batch TX operations
  Submitter: Eddie James <eajames@linux.ibm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=929595
  Lore link: https://lore.kernel.org/r/20250131200158.732898-1-eajames@linux.ibm.com

Patch: [v1,1/1] spi: pxa2xx: Fix regression when toggling chip select on LPSS devices
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=930529
  Lore link: https://lore.kernel.org/r/20250204174506.149978-1-andriy.shevchenko@linux.intel.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



