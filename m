Return-Path: <linux-spi+bounces-12421-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA17ED28001
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14DF3304AE61
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774F3C00AC;
	Thu, 15 Jan 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me6PI90r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED333C009A
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502526; cv=none; b=QvN9uA9ypoIbjsfnlNipiF7rCr0rC4od9Yh1KotZOK0AAy54uiMZDHaVLAcJfTg/eBVy2DEVFdHRsoPf7KBAXPJhnmryj0O03WCX5fMLf95m6YVpFIDdHkBbxdXux790El5vdrNYho1kXN1UbIN8Kr1lJEJ0E+m0wA2sBHFypXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502526; c=relaxed/simple;
	bh=lbfCkxvmlJSqK9PG+rBWWozHAs3UxvN+v4TeaOKgM2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=POuhcSEGXBGK46U1l3liwGWOTlTtrjOx2j2pOFuX0iiRz7TfXX/LUz4EFd/E9pgNseNTcHftw+ovjNITZoeT2gAkhZu5cOQKbIlo4HwlsvxavvDuJdLFOQ2Dgw0l+wq9s+/FaXpf1E0yG87THo9m6JIlJuPHcTIKGa/iOb1iktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me6PI90r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2977C16AAE;
	Thu, 15 Jan 2026 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768502526;
	bh=lbfCkxvmlJSqK9PG+rBWWozHAs3UxvN+v4TeaOKgM2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Me6PI90rjuynU11lpSIBC3pv8tqRHAF5Q0pjuFxXSPrwqh2hgLwlMftIF5A76Qc4j
	 71J772cCNmeto+x2J7MZBaZGZ28eqVqzbZTxjqvb1TbfNaTmHjSFaSvGc5bCTzKBKy
	 Nu34KDHzVHntF0tUff9Uskaxr3k1NTWxYgDue7gczdaID9JMhpvBnefKWp3uczglP5
	 FmcrB7WFNEk4aBRNxwu8O/VyktsfN0rP3BLWfQyh3wAzxkfaM4ffgBfAZ58jGUpWJ7
	 p/oVJYmOkEzWPe00daJwFDbagbfYiVXNapmk+Q2xiCM1rEwW4hy1FHAJlIU6NjnTSL
	 1nMcaqISCpdow==
From: Mark Brown <broonie@kernel.org>
To: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Cc: linux-spi@vger.kernel.org, mika.westerberg@linux.intel.com
In-Reply-To: <20260115120305.10080-1-alan.borzeszkowski@linux.intel.com>
References: <20260115120305.10080-1-alan.borzeszkowski@linux.intel.com>
Subject: Re: [PATCH] spi: intel-pci: Add support for Nova Lake SPI serial
 flash
Message-Id: <176850252554.1337956.17675499224547306784.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 18:42:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 15 Jan 2026 13:03:05 +0100, Alan Borzeszkowski wrote:
> Add Intel Nova Lake PCH-S SPI serial flash PCI ID to the list of
> supported devices. This is the same controller found in previous
> generations.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel-pci: Add support for Nova Lake SPI serial flash
      commit: caa329649259d0f90c0056c9860ca659d4ba3211

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


