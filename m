Return-Path: <linux-spi+bounces-8746-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C3AE6DA2
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 19:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A931D17F950
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A426CE2E;
	Tue, 24 Jun 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYQkEZph"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E95234;
	Tue, 24 Jun 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786423; cv=none; b=ZEKctD4m1NsQJ+Oxy4aXNxAvfsr1A1JeUgnJCk3KUaPruUf8FIwICGfPrxO8rH0dkmqELVxMum0Kv2ZT59PozLS1CZU9l20/A54DyrnQUHjqDMKAoz572U0kR+4j1kPwiVzczLCCwEz6A0PUyd4j4WGYUqoKljC5cXo8fvrIskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786423; c=relaxed/simple;
	bh=49075kBqXb4dYxt5pzpnktXrUUakSrsdjGpdp8Ie9T0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RVSXqEte3VfdYhZ6LkjbDTmpSkKsq6VJLZh/wux4xgs+hp9fsP/nLh6GEXZIUMBrLOLW0riRS5PObtgsIDtFJ9jpE6UL7POXzzmx7Pw/HI4CfiAg7uWDb0A1hG9SveAr/AQS9DTsgr6aGktOUAOQ58z1VlpCgxvl+f6gC4AJVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYQkEZph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC099C4CEE3;
	Tue, 24 Jun 2025 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750786422;
	bh=49075kBqXb4dYxt5pzpnktXrUUakSrsdjGpdp8Ie9T0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aYQkEZphpqT34ZSC6OmP22/6CMi3i6QB+BK1cM4lbQJYS5YyC4dYMidgyVZksNRdy
	 +p2MpFE6rSe/RXBUmjvdjm/WxDSINW/3aQt+M1OVCCIIyC+erbDqTBA3gQ7Oc3I/26
	 KEtxuIHE1r4kIa6PSEN34sHUqunhhy3MOPxZlZ8NMdQZbO+VnB10ueEhcbj+aRz+1g
	 QVarcnKaA0u0eiyaLcDFvg6ORGhLRDuk1FT1sgsC3ugjRl0FRFzDCOBb3uixLWBiPW
	 KgkNlmdPe1gQEm9W//T+ywNhCGDTPXh23qa7HkfQjaRY+NpLuerYCDpsD5rxv2bO8X
	 xlpK/VX16MKCA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250620-finer-yoyo-0bcae988a299@spud>
References: <20250620-finer-yoyo-0bcae988a299@spud>
Subject: Re: [PATCH v2 0/3] spi: microchip-core-qspi: Add regular transfers
Message-Id: <175078642162.219793.16163815657944029556.b4-ty@kernel.org>
Date: Tue, 24 Jun 2025 18:33:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49

On Fri, 20 Jun 2025 14:28:23 +0100, Conor Dooley wrote:
> Hey,
> 
> This is a v2 of a patchset I sent about this time last year, adding the
> regular transfer_one_message op to the microchip-core-qspi driver. In that
> v1 Mark expressed his dislike for that op, so v2 is using
> prepare/unprepare/transfer_one instead. The unprepare implementation still
> contains the 750 us delay that the driver had back in v1. I've heard a
> suggestion internally as to why this is needed, but it was unsubstantiated,
> so I still have no justification for it. I held off on sending a v2 because
> of a lack of explanation for the delay, but I don't wanna hold off forever
> for something I might never understand.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: microchip-core-qspi: set min_speed_hz during probe
      commit: 76f03ce1c6f22805ecf689b1f3ecfb56582eddd5
[2/3] spi: microchip-core-qspi: remove unused param from mchp_coreqspi_write_op()
      commit: 75ca45c472dac206df2ebbc1c0f1f9c3bbdace50
[3/3] spi: microchip-core-qspi: Add regular transfers
      commit: 1256eb42db5d1635f4c6da5b1b58db0b53320883

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


