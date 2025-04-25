Return-Path: <linux-spi+bounces-7767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0DDA9D15F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FC23B2F0A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68D2D78A;
	Fri, 25 Apr 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgOT38ZS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C51AA795
	for <linux-spi@vger.kernel.org>; Fri, 25 Apr 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608794; cv=none; b=FsQL23EKsgmWSJGhQlqC3+2skfL1e9zBamIasibRqJhAV8bcYYfSBHS0BYPVpI/W1Sd3xMVIImVt13Hn9wty6/8c59+qj9geoOZgvRrprcj5Y6DoEtMjk+oeSbe2wHeaghUhGiN9X8uNNHh2F7Sr0G2wplpsA347fr3TUkNyNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608794; c=relaxed/simple;
	bh=gpo4z6DDAJynLl6JCrDAUvziqHrBeuiT3iMw4Z66ogA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cJlEtdG+qvPhHz2iZM9JVCTNdGs6QyJskbMDa1igUv8c3LJF+m97Dzqh22u9ltAW4rGSCh/yOycAAB7S8Ylerf9RmGRgLclP13KCCtR3k9UcflrmGZIm3odkeEnK4gMRzHbi4/ttsqyQBJyGc65YNLvozoY2aYq8szA62G/WJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgOT38ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04125C4CEE4;
	Fri, 25 Apr 2025 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745608793;
	bh=gpo4z6DDAJynLl6JCrDAUvziqHrBeuiT3iMw4Z66ogA=;
	h=Subject:From:Date:To:From;
	b=dgOT38ZS7TZt2iA+jLMlflr+rjJj1eRhvaczidEKQuuFOW1iA7fGHoaft3urufcBp
	 LBF8e1vYtki7UcB+QEkleaFr6qGDp/Makli+OaMHMqWceGkX2lrNA0BaUyfwhtOP/3
	 NajE03dk9rUQoS1PO5gMeOZyLjXybz8jCxtDUrwuY6FcEL8H4xn8HU/S7maS3GLYA6
	 5DOSIxlixDsusj5VmOl/JJMWBZGeixZXWo+E+snDiffydUd8C1Z2simtLALNhNLTHB
	 z05C5O5DvtM3OQC6bHGYvZGrObxgjobDtsCPcIMsPAGxF9BNwbnYG8OxE6iWnpmIpQ
	 ZFGG3LVeiJYVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3B46380CFD7;
	Fri, 25 Apr 2025 19:20:32 +0000 (UTC)
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
 <174560883112.3810871.17939103003017831668.git-patchwork-summary@kernel.org>
Date: Fri, 25 Apr 2025 19:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add basic SPI support for SOPHGO SG2042 SoC
  Submitter: Zixian Zeng <sycamoremoon376@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=955513
  Lore link: https://lore.kernel.org/r/20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com
    Patches: [v5,1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate compatible entry

Series: Add basic SPI support for SOPHGO SG2042 SoC
  Submitter: Zixian Zeng <sycamoremoon376@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=956817
  Lore link: https://lore.kernel.org/r/20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com
    Patches: [v6,1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate compatible entry
             [v6,2/3] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC

Patch: [v2] spi: meson-spicc: add DMA support
  Submitter: Xianwei Zhao <xianwei.zhao@amlogic.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=952922
  Lore link: https://lore.kernel.org/r/20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



