Return-Path: <linux-spi+bounces-4464-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE449662E1
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709121F2295A
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33C1B011C;
	Fri, 30 Aug 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1NKhgkZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AF1AF4F7
	for <linux-spi@vger.kernel.org>; Fri, 30 Aug 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024375; cv=none; b=ZfX7XKMMS9yQUpp7EXTUyQkIllp9ggmb+LIC3YAdw0mqTzTIknU/SakreBhYavu9TLx3Quz/WA8UycvFpIbRac7l3BVaGs+/lrJIG3K+PHgYyR/h8IAkl/8Q+RVo5osgsxYWcA1j+YW+3fE1rQew9dmbs0IwGyLnNaCIGnPLg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024375; c=relaxed/simple;
	bh=xpBBc0SjO3ifCi/fUPts3ZWt+1aK8KVMDMPSdLADMtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fs9IRQvJ/ufQMZg/nAs3N15ZMwPgSxm2CRs3vJcte0JIpEdhyFaESx9srcarIC890kyMvVjqVEsHUhJQXxhOEHjkeN/eqOq7OzMluBJzycCLOZU6HicXloOK1paMq9eIO0j3f8/vShR1qqG+/dWTKAu3Xmnb043HukubJeQqTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1NKhgkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125ACC4CEC9;
	Fri, 30 Aug 2024 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024375;
	bh=xpBBc0SjO3ifCi/fUPts3ZWt+1aK8KVMDMPSdLADMtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R1NKhgkZ999NQELaYbQtmxx0omzlWLXiuql60JLwJzDn8jjkyCaKKrIPi//4RTS0h
	 pOx3CUrKFIygSVlKDyp7RKF1lABjkLmkxhK22OlI4IcTnEOakf6LO1dKtLcNL4cBjO
	 jm7qj3N3+E58+bgFxB5FVKuNAxO71jkZ09H8+CPgk6uH2ERvMNdLP22kW1PDRR031/
	 CHLGBltW9jzOs7mgrH9AX9237R9MCa3guuGJ2i94sWsKF16s5trAxiJ3tz5r7psFrp
	 PM7gKxLexjIL543Ez6VzX0mvugxeuopFWsYRghb+LKHMY3lIUIovEtFAqDXiMb3i6F
	 ahJ/FQmfZnIUg==
From: Mark Brown <broonie@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20240830075800.3541646-1-lihongbo22@huawei.com>
References: <20240830075800.3541646-1-lihongbo22@huawei.com>
Subject: Re: [PATCH -next] spi: spi-ppc4xx: Remove duplicate included
 header file linux/platform_device.h
Message-Id: <172502437480.145364.13937781300346399426.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 14:26:14 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 30 Aug 2024 15:58:00 +0800, Hongbo Li wrote:
> The header file linux/platform_device.h is included
> twice. Remove the last one.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ppc4xx: Remove duplicate included header file linux/platform_device.h
      commit: e3de1d8deb9f6429356eb81118aa1601c8a5a1b6

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


