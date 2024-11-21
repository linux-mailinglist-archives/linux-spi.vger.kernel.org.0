Return-Path: <linux-spi+bounces-5796-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F119D4F54
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2024 16:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B6DB2A88E
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0501D9591;
	Thu, 21 Nov 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ0Pwf4j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E81D47A3;
	Thu, 21 Nov 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201062; cv=none; b=YvJJGLYDS9KEu/Ve6VOUdkbhGtSwKwFkKM8PcGWyerlXR0/oLErYk+fV4ThKx2pdOGUIrTyYfuGMJ+9sO6M39RJ1qOtrcHDzmUi8OJVw1KUhN9T825Q1Isce3emBpEx/LugapbfROk9esfPjBdjZc/ZB+ujAkzwOLyozxb7Ez4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201062; c=relaxed/simple;
	bh=gMlYzKO9uoaDT2cKlgIGWz4G5uCpBb+cq8AaPzgfmJg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LvUvrkNQYVweVr+0Edw1bY2qlkMNN51BgShoHUGt8rq2zepeXQxY3q59KyeDoyjoywXt3lJoNedqh/9gSQOMexzxKDPjgxLkUIO1PkbaCHspKXyM8JJiuFVLt8GH3v17zoaRmPtr5r82Yj44RE+T7wYv5B2tA8/SJdKRgi9b/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ0Pwf4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B1CC4CECC;
	Thu, 21 Nov 2024 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732201062;
	bh=gMlYzKO9uoaDT2cKlgIGWz4G5uCpBb+cq8AaPzgfmJg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uQ0Pwf4jcpJEpbiD4EnU+E7ZrtSK2F/EOvWvsYUj8AXk+qU8/a6rqRJlC1fNkWnQ2
	 He+FAp//l4mjdA83XBfbUN1JbLk4QrC3p9hitWinXgievFVWAQ7+570MoAdCv7DjUs
	 rVVc2dG8Gu5Y037YBwKMAeVsm7HcHxqVrGC9ea7ZNGvc1BikVMC33f95WB11OekoP7
	 BO7+LxtZYBCRw9D8ttJ479O8pXVLVwEq4fLQTaGjEl0pQ+D/mgXHq71vJy58Ho6FWx
	 5ZjC8dXnuUpynxxhRcSVnlqk4FR0WRRNPurCRTmf+0bQ8YC6wHDItJjQx0D5U8CbLX
	 Z3omXZCXbLdxA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Antonio Quartulli <antonio@mandelbit.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115220202.31086-1-antonio@mandelbit.com>
References: <20241115220202.31086-1-antonio@mandelbit.com>
Subject: Re: [PATCH] spi-imx: prevent overflow when estimating transfer
 time
Message-Id: <173220106016.54863.10499187778967280458.b4-ty@kernel.org>
Date: Thu, 21 Nov 2024 14:57:40 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 15 Nov 2024 23:02:02 +0100, Antonio Quartulli wrote:
> The words delay is computed by multiplying two unsigned ints
> and by adding up the result to a u64 variable.
> 
> The multiplication, however, is performed with 32bit math
> thus losing data when the actual result is larger than UINT32_MAX.
> 
> Fix the operation by casting the first operand to u64, thus forcing
> the multiplication to be performed with 64bit math.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi-imx: prevent overflow when estimating transfer time
      commit: 9e141955ede223d82251a59644ff9448a5aba580

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


