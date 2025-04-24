Return-Path: <linux-spi+bounces-7747-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EFA9B605
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 20:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616D51BA2022
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB8F28DF1E;
	Thu, 24 Apr 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvDaD1iv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A228DF0A
	for <linux-spi@vger.kernel.org>; Thu, 24 Apr 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518307; cv=none; b=Ot1dnY4SZjD30lFIHWiVcwoo+Ragdo9RyceoIJEeGXILsRFTKmrGKnT9EzsvKU0uAJBc4AXhMFoVVE24BZ8b4GgyJi20dlQYka+tRzNXeBC7es2vI/Rghl8EakO9IcAtnhiPClmBit7pkHKETDDA8ZSbq6vht29gmzb6g78S9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518307; c=relaxed/simple;
	bh=aQhcJx5JAzsZTy/f0eMj8AkXToaUJi6+KL6IE2UfbTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hOSJA8KF1rJeLc9M4fpx13YXxeR1teKjY7a3Z6gvAy4GdzjAkg1NLITr5I1Zx4ElCc9QvY3NlApXQ9eE028tQ3teoLjy5GjUgHVYyvurN5Xj5hxiE3fxgViS5821bJ5u1bAc047rwuoyzXbB1fsO/rmgBVO4cw9hCZbBZrgujT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvDaD1iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C67C4CEEA;
	Thu, 24 Apr 2025 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518306;
	bh=aQhcJx5JAzsZTy/f0eMj8AkXToaUJi6+KL6IE2UfbTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pvDaD1ivd4Gl1U2cusDdNX6KJTmYAqRAnlbvAdCTTq0p7yWbq5Kd08D4EkAM5U75c
	 dglvgaDOx8svYMm1qGveZZX552EjmfS5wLUAJOF+wh1+MimV/cyDgHsEGgCWcN1LRs
	 9Hnr7JmbzGodxlCbxUvrOe2SeOUJH7yd8PVW63w5AZiesCVVACR+JbFZePK+ylLv5L
	 W8zs9x95el56k6JVjqVIdWldm1fa6OWaj4OkpCXMLEJHzaESjl5bpdrjaXtm5gePP0
	 z2A6FU6b94ZZJGBz4eVqwHCrjt3xaTiSn4Dk2mpSF5MJLY5Do0K5kGJbIvMLvY4Fbo
	 h4CU1lkfobe1Q==
From: Mark Brown <broonie@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <2585fa05-60c4-48c4-a838-e87014665ae2@gmail.com>
References: <2585fa05-60c4-48c4-a838-e87014665ae2@gmail.com>
Subject: Re: [PATCH] spi: intel: Improve resource mapping
Message-Id: <174551830587.713123.8932739949996007218.b4-ty@kernel.org>
Date: Thu, 24 Apr 2025 19:11:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 09 Apr 2025 18:25:01 +0200, Heiner Kallweit wrote:
> Let's use the pci/platform-specialized functions for mapping a resource,
> and pass the mapped address to intel_spi_probe. Benefits are:
> 
> - No separate call needed for getting the resource, and no access to
>   struct pci_dev internals (pdev->resource[]).
> 
> - More user-friendly output in /proc/iomem. In my case:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Improve resource mapping
      commit: b50a1e1f3c4630f729629a787d891d7b4348007f

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


