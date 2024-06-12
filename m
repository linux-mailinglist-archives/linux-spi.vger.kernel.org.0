Return-Path: <linux-spi+bounces-3391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7843C9059A9
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 19:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B01D1C226C1
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF918307F;
	Wed, 12 Jun 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUrug8k2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF3183078;
	Wed, 12 Jun 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212189; cv=none; b=ohUVm/dLewI3jbyDh9lj9URbm0D6E0EpW3XuoJa7Rjd9zNP1DXRru48tacAeAUXufTPVnbgecn3d5HA29uUfTfIhoaDV7QDnt0M1SwvJl3CbxcMsJ68qSltCnQL8gxnNCFqoH+Il5vDwIHPGGpYIaqRE71ll+zT2l6zgSL1lP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212189; c=relaxed/simple;
	bh=jO1NtpsGofSi9Yqi3CIJvIl68Fxc6ZaYrv46rvHzG/w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ErIIAPIqka0wygjltvRBf0t7qDV2s63tY/C8BXxcLKPIfhCzKvpbsTwq/eq4aL5188rKalIc0zEa2pPJDoKFp20+2ZT/Ah5Bt5SF93d7PpS5YfCHfGa9VIz1JZTJBRR+5STWgqG0tSzDDbQ9KE98xVTuGtffxhP3FspFMJemC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUrug8k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB99C116B1;
	Wed, 12 Jun 2024 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718212188;
	bh=jO1NtpsGofSi9Yqi3CIJvIl68Fxc6ZaYrv46rvHzG/w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JUrug8k2I9ErwFj6lvPdQfT3D6cqHpJLNS+1LURCysupLKLQnQG4ueKJQSy+IQJK5
	 dFAP0yit/fXKpLf8Ki5HJww5hjvN4GQSQvxuVJr4s144KicIIW6HK2sgsIYAiTl1UI
	 VBscCpQKEmsIond+Apu6z2lJ9erikpbmP+IkhsIBIRNm2oSomWT88JuRhv8iNda5kI
	 l5biSWyam/6utJ4UVRbaYLmcREfuWcxxJslYxbFOd8/gZvkLUfuRBJKKwyeRHGl82V
	 nIB23scJ2r6Nq1A5aepa3eWXwQLHmHwJSjevKh/W/wDLeQNdRWplbGBkmi0cvIuHIg
	 jo9Pb/5nhRjNQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
References: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 1/3] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-Id: <171821218634.232443.8700166548372962724.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 18:09:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Tue, 11 Jun 2024 14:25:54 +0100, Charles Keepax wrote:
> Refactor accessing the SDCA extension properties to make it easier to
> access multiple properties to assist with future features. Return the
> node itself and allow the caller to read the actual properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/3] ASoC: cs35l56: Attempt to read from cirrus,speaker-id device property first
      commit: c38082bf223fb4a3f2bdf1f79650af53d3499dea

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


