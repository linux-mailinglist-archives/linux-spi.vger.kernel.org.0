Return-Path: <linux-spi+bounces-12101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A62CDA080
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 18:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43F2F3011005
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAED3346765;
	Tue, 23 Dec 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0akxyhh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520F345CA1;
	Tue, 23 Dec 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509637; cv=none; b=UQWQGeamrbcSXUAGKlKamd0x3UDAlf+Guh2tSWEvmA+3o6Y4uh8pEeEXfuiX9/85cSYrppTNdZTurbBq1DjrrzxMXHsq8W4VBGJOFU61pWUBwm2kbG8xMg2xjpSMosAAzokrrzSNfXTs+U0qahaRFwRLNRTEUW5CaIkE+tae0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509637; c=relaxed/simple;
	bh=0wuArradXecTpKmefalsUgczkxHSXZbIzzj7SMNFE1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RXAiUl+CLyMwhu+jJdV+X/8tgonrI9IFDtKmYN2iXhteEpdD6aFm4hLXoUTYvHpNotBtvYLWCzW7lXV/yzh8AVBevs8Ep6zYieQhgTOY4a3nWsw0hWhEl9AJoyutkoiLTomguYmnouc+QqEGYbN727/8X2D/MgsYF7Sn0cY6ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0akxyhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C90AC113D0;
	Tue, 23 Dec 2025 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766509637;
	bh=0wuArradXecTpKmefalsUgczkxHSXZbIzzj7SMNFE1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H0akxyhhr+8/5cBMrLyx/2b5re/aDpLMLeNsZ6VId+hiGfwA8w0mzHbu7ZPv7Ubc7
	 8FYhFEDmOIrl+I6s4EEi9SRhYpyLBaaYXrS4tF3D7Fbt9+ylaCpygqaMuCQ3JvKVC1
	 68eYU3G+h55+a17zE0o5TKyiZ/cPkzGDHmGEcPxVg1BD3rRc/1WANZl9XdQXqX2Nj6
	 5KpUNBy4fJQ5y1znIjPvxozWQbR2l0IqLGLkduyWyT58ctjq7idwhGfMOBSyyEbTjD
	 Jt9F6WmzAOjln4fWFYb09VW4eDY3ibpissHoxjv0ons2ytfc9gHrzRfvAa27gQuj1g
	 Sf2xzYuxUM6bg==
From: Mark Brown <broonie@kernel.org>
To: William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251217211026.173946-1-jonas.gorski@gmail.com>
References: <20251217211026.173946-1-jonas.gorski@gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: add support for 1-2-2 read ops
Message-Id: <176650963590.445653.8224229300977503109.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 17:07:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 17 Dec 2025 22:10:26 +0100, Jonas Gorski wrote:
> Add support for 1-2-2 read ops by separately calculating the switch from
> single-bit to multi-bit, and then switching within the prepend data.
> 
> This allows us to support single-bit write followed by multi-bit write
> followed by multi-bit read, and we do not need to reject 1-2-2 read
> operations anymore.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx-hsspi: add support for 1-2-2 read ops
      commit: 0f698d742f628d02ab2a222f8cf5f793443865d0

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


