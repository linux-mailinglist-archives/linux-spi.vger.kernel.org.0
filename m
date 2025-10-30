Return-Path: <linux-spi+bounces-10917-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DEC208F0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 15:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153F9406AB9
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D061F258EC3;
	Thu, 30 Oct 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds5835zk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0401258CE5
	for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834031; cv=none; b=ARqCtdz1EaH1Vl5HnPtDsAFFTzPHTiks7xWR+XDoj64OyjuLWJ6ryr7ol+6KAmplgamAFc2n248saao3YD0MlwZXO9uKJEO3ia8z3w4zDcoXrm9/a6GMVCuZL0rbNsZAymRMfUiLm6x+FNkeNuhfMqV83uSkw8AffuLfE6srXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834031; c=relaxed/simple;
	bh=GC0x8GSppfTJqkaxY6HGOCHa7uS4cRGB2YZfVluI1YU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k/pAK2H2WzWNBvrWvlVabaUJKvaiKRNUrdfpd+o9OaVgREGHtCfzdixxthpBI6YjBhPi+gZ2k2rTQsR6OvlGES1mQo+9Ld0KwSnofQ+1x4Bd99aJoa1H8nG+twMqkr1wQnX5agyB/vMSYea40lCkY2RpK/BksIw8iBYh9mVrFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds5835zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844B3C4CEF8;
	Thu, 30 Oct 2025 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834031;
	bh=GC0x8GSppfTJqkaxY6HGOCHa7uS4cRGB2YZfVluI1YU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ds5835zkrgeOqT00HUcOFwPbX8cXaLQEqdTlTOMb7fF8UZdm4cSiyk2PMuq25pw6V
	 p2pzYcXWJMbK88+y3cmQvYVM381mDLY85ZDHaa81yAmUiddTa86aJAT9nqD3VtFVRS
	 lEC+6LSr7csB9QR30KKfhItwrGa/A/6LdUVR0eriL7fA3R5gmy3Wgue2YSefrLBVYi
	 OsRJh8OH3fqREG79hz7KUVHE5Kq5WdQ+3P4rL/V3eU+3KhtfW0SGeDmIqWvSzi5hM9
	 BO3AyihuRGv4uYhOxxoiSCYAes3wF/AgUaWiOuaOlR52Z+sw+0x+eS66AcV6SxGcN7
	 FPtkq9t6yc+ew==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-spi@vger.kernel.org
In-Reply-To: <20251029065020.2920213-1-mika.westerberg@linux.intel.com>
References: <20251029065020.2920213-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Add support for Oak Stream SPI serial
 flash
Message-Id: <176183403028.59991.6181304945248886828.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 14:20:30 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 29 Oct 2025 07:50:20 +0100, Mika Westerberg wrote:
> Add Oak Stream PCI ID to the driver list of supported devices.
> 
> This patch was originally written by Zeng Guang.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add support for Oak Stream SPI serial flash
      commit: e7dbfe6f15b4df34bb169d180bd10f1a3c043814

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


