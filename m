Return-Path: <linux-spi+bounces-11283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0140C6BF5C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 00:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7CD5B2C36F
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 23:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19CC3126D2;
	Tue, 18 Nov 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0uMIyyk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC33126A4;
	Tue, 18 Nov 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507709; cv=none; b=uMdu2c1+6K5K9jboj/zbMJVVtQZNrvQ+MFIZvsh99jTgE26ZrP54TUcb9X41XcoaQKAsCWwSi1MKGW0Lm/f4MLpD7uiqRR091yoknUnfWi9SSecylxFwOtPC6DkQZ/EFgxQdeJXOipD/0R+Y2SoM2ssaz1PUICzm5+37/+4hFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507709; c=relaxed/simple;
	bh=gtZ9x9hNGJ2crNqrmM9FblaMEjzm9BUY+A4w2ICStuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n41iMkTaEHvVVnbwzSjRCkkt/3nLbRL7QqD6o8izOsosisiZa4BMXzqxVqlqSmFPFPlsrCM195FyskRvgN0hszOLij9sNFdFWBaIdY5LEGGIro3BgzN+/iwuHwZVtOfwtoUTSYJPiRC6onGnw8Cq0fAJA/8rtVdKwtrrNnxSLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0uMIyyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BF5C2BCB3;
	Tue, 18 Nov 2025 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763507709;
	bh=gtZ9x9hNGJ2crNqrmM9FblaMEjzm9BUY+A4w2ICStuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N0uMIyykd1R+agxLk1XZPKIWnxJVYvcpclRwXiF+1xW0Lgni9jZk+ch5V23p0QuMp
	 kCHhrLUTlXIq6b1O/nTtr6l1FlUteFJAMvsb4QaAL268eyI+dzPrtN6o54b/cvsuS/
	 AxpaHVkmKwMOdfC1TLT/Dx9LxVtnFMDRfHrGRYwWfGBWygST4dJoFd+VXW53/90Eco
	 ZHToM59mJzj+kPSDut3PWtnO0RGUSHiCK7fvl089OTlESjFvZfVA4dw7ntg+XdgVF6
	 MEQA75wQjT6SgpwGhFF0oEYsf7PxWK7tjQ2WeYf2S6FDK8lhBKvqKjqivE1vmh/Fyc
	 nKndlYxd+yoXg==
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20251117104044.291517-1-lukas.bulwahn@redhat.com>
References: <20251117104044.291517-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in RISC-V MICROCHIP
 SUPPORT
Message-Id: <176350770659.1411024.1566191077939342244.b4-ty@kernel.org>
Date: Tue, 18 Nov 2025 23:15:06 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 17 Nov 2025 11:40:44 +0100, Lukas Bulwahn wrote:
> Commit 71c814e98696 ("spi: microchip: rename driver file and internal
> identifiers") renames spi-microchip-core.c to spi-mpfs.c, but misses to
> adjust the file entry in RISC-V MICROCHIP SUPPORT.
> 
> Adjust the file entry after this renaming.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: adjust file entry in RISC-V MICROCHIP SUPPORT
      commit: bd79452b39c21599e2cff42e9fbeb182656b6f6a

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


