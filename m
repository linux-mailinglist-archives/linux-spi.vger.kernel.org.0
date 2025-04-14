Return-Path: <linux-spi+bounces-7570-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B4DA87CC1
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 12:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A989166ACF
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A525D8FF;
	Mon, 14 Apr 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1AT/X3/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D67482EB;
	Mon, 14 Apr 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625023; cv=none; b=g0sBqzLewc6T7XuESFH9Ml6g1GnBdlflSvKfFj6Z13TisyvySNnT4WlQ71+RVeQdrEhv3LfWa/NWVHpjLypM6gnh39QAXDPu3xQFXGim5CfZBcoAlkc/eaKXXwwttkuD0oJ52/1fBxz7VApKTHyKktUDdvoZ88Hyt6wZV/fRyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625023; c=relaxed/simple;
	bh=xqW9QjI1wIZWYuNCR1WZbXL3UGVYI7WLqjrhdOvgZik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WX+wOxiSlDvz9M42SyZJaAyDGZPZrPTmC0BQvylpXe9YTE8FMUIZb+K+HUmjP8yD8X4+izDj3M0APW4TBCJLgjGiXuEI7GoKTa7qHhI4zGapLL9YsElcZ5M/JNLprV1j/AZLSjwMXSLx/UkP255w56Mp3Ig2Ak6K55rIxcrjwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1AT/X3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49FCC4CEE5;
	Mon, 14 Apr 2025 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625022;
	bh=xqW9QjI1wIZWYuNCR1WZbXL3UGVYI7WLqjrhdOvgZik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E1AT/X3/yj+A9wWT2zFEQwHo+Mi+akyBniDkIg4ff4w+lxPGye+To8//wiWzwj+U2
	 jcyPa8IQl8vlWlyYorVoeA4GMwbJIUh3dJTp2tR9ZURuDdvZTGVKJ9BnqVuYBCcnOP
	 8p8yET0Rx9xW7yybu1D05d5E6BgEuFQRR/hRSwtK6yhuOBv4KN7/QcfGsN782I6kDC
	 XHtI69shb504AKXEkL6tny7JoIX3ZvA2OywTkhlqaGwv6H8tgvohyrkq7hbFGl7XZy
	 CVGrMSltyEEmdJxHBedOKyjVPf2m33cT4zgXd9Tq4JFEMrt93q1g1d9HbGFolt/apZ
	 KfGeudrVG6TUQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
Cc: Han Xu <han.xu@nxp.com>, imx@lists.linux.dev
In-Reply-To: <20250411-spi-v1-1-8d6dfb1a9262@gmail.com>
References: <20250411-spi-v1-1-8d6dfb1a9262@gmail.com>
Subject: Re: [PATCH v2] spi: fsl-qspi: Optimize fsl_qspi struct
Message-Id: <174462502149.12165.11097943181673773187.b4-ty@kernel.org>
Date: Mon, 14 Apr 2025 11:03:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 11 Apr 2025 15:06:41 +0800, Kevin Hao wrote:
> Reorgize the members of the fsl_qspi struct to:
>   - Reduce a hole in the struct.
>   - Group members required by each op (e.g., iobase, ahb_addr,
>     devtype_data and lock) into the same cacheline.
> 
> Before:
> struct fsl_qspi {
> 	[...]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-qspi: Optimize fsl_qspi struct
      commit: 279b418f477fd6c1c21b1cf212837622c774f15f

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


