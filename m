Return-Path: <linux-spi+bounces-6476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF24A1BBDB
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 19:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893653AE2EE
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE41D799D;
	Fri, 24 Jan 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pygbD5Xq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE882D98;
	Fri, 24 Jan 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741816; cv=none; b=fpsChHgViwqIWOtO+BnsIeiw3qAFRC6UX9OLfI/rK0yQWsAXqQF+sHK3qrwqHioOQdtPu17ZK15jfpj4CgKWzM0i9LoFuJ+TUqwKVMHR/luaxiApykOkJxrNhs8ZqPSF/Pnfsk2P5xDOqCw1hGwtBC9lre5JI/QUVfjVY8rOoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741816; c=relaxed/simple;
	bh=T7jQGhGq4kVFYXEDBLMD5cvlMUwyhfACdNERwvYWewk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=sD0RDRf2yAMk4vfgbbW0rP2yZODvJ1EABPrqB05L3WElBpXRNgkF/y7z+3DvueG5FNBJ5RdQry51bloXg2yAeFixbqTlX0M6Y3dfhiTOzLKGM3sJbwK7RRKQdzB1JFhO4UTUVEXrVFVPIcjUFL8pNxyEHW1yAQqNjrtt8W3teKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pygbD5Xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55205C4CED2;
	Fri, 24 Jan 2025 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737741815;
	bh=T7jQGhGq4kVFYXEDBLMD5cvlMUwyhfACdNERwvYWewk=;
	h=From:To:Cc:Subject:Date:From;
	b=pygbD5XqjQb0qxXA+ZypMJiCIGwgWJM0H91xQDAehYeP8N6LINpFDE/F7PDF1g9Gl
	 ZKZ39eoHy86FKI/kTLRWmP+V2jraGdmg2ICt9CHnJ1zZ1ISpuVwMzlh7mbwqppex+z
	 DQelCvPXiwNNZc+xOnwZ6RDwkm1k6Q9Zz5CUE6ld7BAJ9LFYISakRUnuIKgU9MlngH
	 GMD9YhnXXk0HKy1uDmfaWP52VN0K1gybOANw8++o6QPyRS6tjKyEVEasEXdt5QUy69
	 cLYrK2yZpBFSLpeO52olpo5XhSbBFkLnsqJtwYSFfu2qQAY4hoVcKFjiP/Cf/Vm5r+
	 0ErCFlA2TfmOA==
Message-ID: <5dc55026c1c6ad511e0ff918b43b6792.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.14-merge-window
Date: Fri, 24 Jan 2025 18:03:21 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 78b435c9044a9ec321da29d299c70cb14b059682:

  spi: pxa2xx: Introduce __lpss_ssp_update_priv() helper (2025-01-16 17:04:31 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.14-merge-window

for you to fetch changes up to a07eb4f67ed085f32002a1af2b6073546d67de3f:

  spi: omap2-mcspi: Correctly handle devm_clk_get_optional() errors (2025-01-21 13:07:03 +0000)

----------------------------------------------------------------
spi: Fix for v6.14

A simple fix for mishandling of some clk_get_optional() return codes in
the OMAP driver, the problem was reported against stable kernels on a
few platforms after an earlier incomplete fix was backported.

----------------------------------------------------------------
Mark Brown (1):
      spi: omap2-mcspi: Correctly handle devm_clk_get_optional() errors

 drivers/spi/spi-omap2-mcspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

