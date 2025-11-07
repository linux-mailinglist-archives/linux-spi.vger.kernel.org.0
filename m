Return-Path: <linux-spi+bounces-11107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A711C3F2F0
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C666C188E9D4
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F133019DC;
	Fri,  7 Nov 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koCdZds9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8653019DA;
	Fri,  7 Nov 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508071; cv=none; b=kS74S07Vv/Zmgw1oa4DWBU1OI4GIEb9fd3T7G16bembAsvq2fvjQSyhzgOWHW4Tx6SJIldDV++97eo0ttev0u6Wg0I8dveEQqEAVxeJMGibcIkiQxM6NxJE0qkNe/nDjm9Pr2lnPb8IYWPuFgOCqlGxRJQG+2Iz+7bCbbNdath8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508071; c=relaxed/simple;
	bh=NtX+5fn+kE5HkWQvbOADti+9aZQIyL4Npwg2RYFPXmc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JGW3cSnicfcjLXPYLu88bU3una7LBcYQEXqMRq0u10ejqjxXKMkdk8/zTjtfXKLQuPj0e7pY+Fk4POV+xhCBiXkrQ4K2dsQ74oyKCoY4KoBhFQvUdCN3l2v0Oi3yt7xgw1mevjAJTZsKLFxiiJtnl6iMySZ4WypNz04MLa5Jl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koCdZds9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C38C116C6;
	Fri,  7 Nov 2025 09:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762508070;
	bh=NtX+5fn+kE5HkWQvbOADti+9aZQIyL4Npwg2RYFPXmc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=koCdZds9yXGyuaAF7TL5P29yTmWzu4zDko5m6Zm6K7xhvAD2Wr2tUXMXbSBe56IjA
	 R8+/rLbgfrEbihBBMjJKEOkEzCn7veYpBXFfhAgGyFdKPTjPVRKp1mzrPNQBFGI3GP
	 1b9GFs5PT5ZcBcwG9gdUjKTnb8XFpzNt4o5Z7cikBwuy+wAq4vDud4GZE7AJxJRRGj
	 lCxn0YcK1izSOclHMxnZjN4vaw/orLZsnD0UUETXf7O0dglJruRySPALQlACmbblRV
	 sevhOG2VrslPfEZCY9KkScWZx7oKfIijzALVemZS+Sg0O+QUlzv3FSspi1SKGWplaF
	 uXt1Jc+0L6Lkw==
From: Mark Brown <broonie@kernel.org>
To: mkl@pengutronix.de, frank.li@nxp.com, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
 carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251027110256.543314-1-carlos.song@nxp.com>
References: <20251027110256.543314-1-carlos.song@nxp.com>
Subject: Re: [PATCH v2] spi: imx: add i.MX51 ECSPI target mode support
Message-Id: <176250806608.2489052.17181780089794986836.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 09:34:26 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 27 Oct 2025 19:02:56 +0800, carlos.song@nxp.com wrote:
> ECSPI in i.MX51 and i.MX53 support target mode. Current code only support
> i.MX53. Remove is_imx53_ecspi() check for target mode to support i.MX51.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: add i.MX51 ECSPI target mode support
      commit: 4e92abd0a11b91af3742197a9ca962c3c00d0948

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


