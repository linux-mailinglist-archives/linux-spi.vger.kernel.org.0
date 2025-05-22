Return-Path: <linux-spi+bounces-8240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB36AC0CF1
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450351BC4BC6
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFB28C029;
	Thu, 22 May 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7xs8jBl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDA28C024;
	Thu, 22 May 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921083; cv=none; b=pLP7EjCe6L+iI2s6JTGPSQIrVrpmPWaCzuTOLV1+MpfcnOSMxNw/eaGO1645RGfOLkiYjWLkdSa3beQQL1ZLCjnZOrZqPc0ag7RtNddOiMiEAnMJWcXrv6bLLfy/eAEfPd7FhS4pOsZFH+vutYPvviTckYS2FBCl1ev/j6M3Dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921083; c=relaxed/simple;
	bh=8ZTvGvDUJAfLw4xOksgQHqakW9CG3O1HIFZUeE/PAu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k8Qaf1S/MVgqSpagr6hiOVsHLgtKgxEI3yK/y5NJsmxL3AUO+QXJzBLiDa/SKQ1zKju8dHHJNx2BwAciSqEANj63UzHF01mwiswD4qcwsA0ZGtNcHBtrZ/3drmPOKvr6s1kC1UrL1zVZ77EExixovSzUNfEX5isDfqiqjS0qjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7xs8jBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54414C4CEED;
	Thu, 22 May 2025 13:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921083;
	bh=8ZTvGvDUJAfLw4xOksgQHqakW9CG3O1HIFZUeE/PAu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m7xs8jBlPNmXPsGwZwoQrTC4NYw5bFAMLGYnF/MmOucBrvOHb4/oraN7uAJnYgc//
	 G9sMX7A0eEFEMJFOGQ5QB0wKGGUTGZpusxiMdeapjZIYdJXKP4rSpq8DbfHu0LHrIc
	 8pLIsZ7ig8XTrGcNMKByCTDXVWh0a2dXBAUKuCOI1bcf+d5/iigKZMlnnZoTRonVCP
	 +F2HWFnYVwFs1tFD7QT5MCXIUfcXtwHT0PWCdHFddzvb4EGGJVnzoRaVsQ1eTfz2HI
	 U0aeelt+p2o89Qxo9jOdlW6iLpZArVcTbFH47kX27NUhfPzx/TV/Qbzz7NJA655GE7
	 efHVfkx6h4ELQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2025052213-semifinal-sublevel-d631@gregkh>
References: <2025052213-semifinal-sublevel-d631@gregkh>
Subject: Re: [PATCH] spi: loopback-test: fix up const pointer issue in
 rx_ranges_cmp()
Message-Id: <174792108209.84499.17148093262330532612.b4-ty@kernel.org>
Date: Thu, 22 May 2025 14:38:02 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 22 May 2025 12:59:14 +0200, Greg Kroah-Hartman wrote:
> When a list head is a const pointer, the list entry for that head also
> must remain a const pointer, otherwise we are just "throwing it away"
> for no good reason.  Fix this up by properly marking these structures as
> const.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: loopback-test: fix up const pointer issue in rx_ranges_cmp()
      commit: e7f3d11567c2c79c4342791ba91c500b434ce147

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


