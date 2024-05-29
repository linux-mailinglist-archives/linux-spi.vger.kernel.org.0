Return-Path: <linux-spi+bounces-3126-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39E8D3A5D
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617A31F22EBD
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF417DE07;
	Wed, 29 May 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jplFHyjf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42415B97D;
	Wed, 29 May 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995405; cv=none; b=ZdUsW+aNLsZOeN4Th8OAiVN5b9hVO0P6aukGMXpq5m8tgbo/XzDR3Lsnb04ty3HxWNtja+EbJU3N1wW+Joiiyg950waytMLM57nUMI6yIohYnOIVsGdfWRoGcGNxRpPQ66IrfGPG+1xabpqQf5Y5y/TOGXO4aTPK4zT1a2kZ2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995405; c=relaxed/simple;
	bh=9VTxAFuwXMVGR8QCr9KFqS8UEt1MJDSjeHSXAiGvkYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WdY7i9LKAP1ETqBCOc9EhoWJ5HtnDKdZnC13Y1xSXPzKNF3Z/9eROqXiSQHQCu02XMmOn77vVO7df+e6DR5B7pSbOM6fiABTk59zG76djJfSBhu0cZOT1EN92nmTxPQq3FcMhe7Ngn50yQEEc6sxe3mNGfogsAogZPNgWx77kUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jplFHyjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB70C113CC;
	Wed, 29 May 2024 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716995405;
	bh=9VTxAFuwXMVGR8QCr9KFqS8UEt1MJDSjeHSXAiGvkYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jplFHyjfl5mKem+XFTnxrZE6kGguINK7gyfk7X2VTV8EEYtSJjek0PSh+3nMxIRHE
	 Eb076fIMHNUwJID1VmSpSbVJB5ap36XWLKRUQMxqX56s3eJz+6T4F6bzQ0pd6WkZPZ
	 iWvQVH6BQbpCR9OX7VfmJXCQVqv5YhP2Te0dmSxRdb04cxQkhICDitgtBhsUuAlWkG
	 Ld6jfJX2qUiKE6l7+BauRKa18C3sk1HMl1x6qi2+CPT0GYsdWf+qBn5wmwI0qUTo5T
	 VcUN3Q6T5OTUeC4OWJ5/rZuJxXqxyvaSOSt1DWYZksTKt9FVa9yJ/cvBYPrkHXpfGs
	 jIzYAOg9KzaBQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, Witold Sadowski <wsadowski@marvell.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 pthombar@cadence.com
In-Reply-To: <20240529074037.1345882-1-wsadowski@marvell.com>
References: <20240529074037.1345882-1-wsadowski@marvell.com>
Subject: Re: (subset) [PATCH v6 0/5] Marvell HW overlay support for Cadence
 xSPI
Message-Id: <171699540330.118008.2661040654002810758.b4-ty@kernel.org>
Date: Wed, 29 May 2024 16:10:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-2ee9f

On Wed, 29 May 2024 00:40:31 -0700, Witold Sadowski wrote:
> This patch series adds support for the second version of the Marvell
> hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
> change made around the original xSPI block. It extends xSPI features with
> clock configuration, interrupt masking, and full-duplex, variable-length SPI
> operations.
> 
> These functionalities allow the xSPI block to operate not only with memory
> devices but also with simple SPI devices and TPM devices.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: cadence: Ensure data lines set to low during dummy-cycle period
      commit: 4a69c1264ff41bc5bf7c03101ada0454fbf08868

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


