Return-Path: <linux-spi+bounces-8409-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589EEAD26D1
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82020167976
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25A220694;
	Mon,  9 Jun 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baqs8bDf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653C220680;
	Mon,  9 Jun 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497630; cv=none; b=gNPfeYUkpMpQPM24eHcFJewsBgSXjfFyvt8C61Bx1jMeEQ6TRuWAk0rYBWdXLnmTqnheZsWjadwnHXD4CH/8QKB8gQJp71OagcltHIUb7Bza7lhy09BgwGXPynFqjv6UQCEfO2jvSJ8QlQfIjniz+Ms8rFK9wo/EeyLoRlKYlA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497630; c=relaxed/simple;
	bh=WkskF7yY6PS38zNeUQMj1TocoWOUUzllmyGJbAAnZRQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O5gdIXoCBQwLzxCDD4nZAFelk7AqeenUy752aVKp2NfR7a+NqIU2/orv8SQel0q1wHvJqlebqz7bhKoZm0Ob2y5wZRLzZr/KplA1ikAbiqBGJsqcJveRftjxWk+WuQqlmynq3iq8gJG1+ljMLh1D50dqWd+MPCpgY/C8yzmzKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baqs8bDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E25C4CEEB;
	Mon,  9 Jun 2025 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749497630;
	bh=WkskF7yY6PS38zNeUQMj1TocoWOUUzllmyGJbAAnZRQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=baqs8bDfRb/ATfWq3EQNIB5DYO3L7e3nRa/CEwPHLj6kCIoWyEzhuqjsI/N3OlUaN
	 5BCTwOfmZPgwWur/fopWv0e72chobUMIn4hK0MwroElpsUy9Hr+3o1OfzoDXMGBiro
	 0RbmVxQJrOrgmaFDCDAX8ZECxArWt6j+rPlUaohwmkJTG67R9xa/I9P7KUi1L/lfgW
	 uoR4mKffAhzH1Hk4/2FWztpDHWdKcHhu1T8I3HapIm6NJvCcOMLnC3WahXLpSCUZ0u
	 vXckoxjadAxYL/6/qn09y9k20KlTPtXXP4ilANt+eWLdp0pOYLCuNGzqEul0LC6qJP
	 len688AMoYFnA==
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu?= <felix.piedallu@non.se.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 pascal.eberhard@se.com
In-Reply-To: <20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com>
References: <20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com>
Subject: Re: [PATCH 0/2] SPI: omap2-mcspi: Fix SPI CS behaviour around
 cs_change in SPI transfers
Message-Id: <174949762925.256775.674413382110648047.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 20:33:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 06 Jun 2025 15:37:23 +0200, Félix Piédallu wrote:
> These patches fix the behaviour of the SPI Chip Select of the OMAP2 MCSPI
> driver used on TI SoCs.
> 
> The omap2-mcspi driver supports the use of multi mode (multichannel in TI
> documentation). In this mode, the CS is asserted and deasserted by the
> hardware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: omap2-mcspi: Disable multi mode when CS should be kept asserted after message
      commit: a5bf5272295d3f058adeee025d2a0b6625f8ba7b
[2/2] spi: omap2-mcspi: Disable multi-mode when the previous message kept CS asserted
      commit: 10c24e0d2f7cd2bc8a847cf750f01301ce67dbc8

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


