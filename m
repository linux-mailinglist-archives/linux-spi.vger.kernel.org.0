Return-Path: <linux-spi+bounces-10160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3436FB892D9
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26EB188EC06
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF53093A8;
	Fri, 19 Sep 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSsGBKbs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911D3081A4;
	Fri, 19 Sep 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279816; cv=none; b=h5fcOIwf11+4JjH0RiJkiuVF/2lGX++GcPp/XTdB7Q2gKoFgym83OlU8q+UBcR7JZ22N3Ra2CkpGj5uhmxwlgIkBRoL2WiMjOKzgbsQjBhd3mQzUEY2FV0s6CWC+BQwuGBxJmc00Af9XBWvS+PQXg7vWNw0T3gImvREUhM+i/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279816; c=relaxed/simple;
	bh=U1yswzr9NJ42cTAHUxi3QmznSW6rxKPBQpnoa3VAfqA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fLlnDSyklCb11hR3niJ46OAiy0uL/cnP1mkdyF7eD7VnQ+jwUMz2FPPQRCYxHRRqVDF+i6VrFcuXNIG5R25y5KTl2p2t+YJGwLFSJYZYA9U6pNj5+li5x/fR5oLwPBWQAUGGXx8fFOCBGAGmPvLkLCxWabPic9sR0/LLce9X/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSsGBKbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042B8C4CEF0;
	Fri, 19 Sep 2025 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758279816;
	bh=U1yswzr9NJ42cTAHUxi3QmznSW6rxKPBQpnoa3VAfqA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LSsGBKbs02r0B+Zf0+JrkYFAGJdzhLvMNxSTJDc4FxhUvnuFkypn2CQm11jYEgCGc
	 CLodiJWQPvKfsyDVyRlmW+nEsXAJXk28W9IOYQMpZJ9MIsEN0F7vilmYcrcdxskpxL
	 adRWvABxUEhzc/ZD0bQwjrP/yucPJcqDV7p/Nmh97NglS/UE8qVRWeFZvsHsWWMLPa
	 pmzIKTeNU+OPp11l5RInd6eyxtP8ZLFeaq3fyUo0sgIuTUsbtgv07wUT+kwTUEALpZ
	 OmeK54n0o/lsnlJsdsu48YA3Jg4LUBCD5dhJ7EZE81w50SgO4wKLjMiANBgCCVF6sD
	 q/MQzQNvhM8Ug==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Niravkumar L Rabara <nirav.rabara@altera.com>, 
 Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
In-Reply-To: <910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com>
References: <910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com>
Subject: Re: [PATCH 1/1] spi: cadence-qspi: defer runtime support on
 socfpga if reset bit is enabled
Message-Id: <175827981475.43867.14880057766309432470.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 12:03:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 10 Sep 2025 16:06:32 +0800, Khairul Anuar Romli wrote:
> Enabling runtime PM allows the kernel to gate clocks and power to idle
> devices. On SoCFPGA, a warm reset does not fully reinitialize these
> domains.This leaves devices suspended and powered down, preventing U-Boot
> or the kernel from reusing them after a warm reset, which breaks the boot
> process.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled
      commit: 30dbc1c8d50f13c1581b49abe46fe89f393eacbf

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


