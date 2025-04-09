Return-Path: <linux-spi+bounces-7493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFEA831D4
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 22:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919323B33D7
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72E20298E;
	Wed,  9 Apr 2025 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWuwqGJx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459A1E8342;
	Wed,  9 Apr 2025 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229936; cv=none; b=iu2PIkbBwv4wVTyOGFuvMWWnJrYtZJx0+9XdXARaTucqZiQAeYJBBf8j77hNVBHY3HPpMhCgxpCQUm0hd0mYlWhBDGH1QvcQYsE6LaL9ga1sA1yCZIp5snKf1xk2leCuju3kWrpj8DdkzNsE4atao25ZqCUr80EH7ycB5kHS6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229936; c=relaxed/simple;
	bh=rl+WyhgpOT1Ni977tk+WO21akyHiEkpbaQpdVyOmdWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=idkaniX1EQiu2G1XQKzZd2BOBcJsl1nW7ALCqjn+Hj2Y6y6TqIgQC8giq6vtQoPTkMwrH90Qdv0THOhZqMblPT3AT7riyYNi4nrqgT/31ZSYb72MUeOrPGhC7lckJp3b+uUQ8/Xr+pojIIgu7XwkWDCqidiS8Jc2YZ1wel6HxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWuwqGJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B417EC4CEE2;
	Wed,  9 Apr 2025 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744229936;
	bh=rl+WyhgpOT1Ni977tk+WO21akyHiEkpbaQpdVyOmdWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iWuwqGJxBqWvx/vy8FDQAxQEkucPKYP2vbQ4Jn+wlhh+7w6dBLMMbO8Pi/LC6PEQa
	 B2TLoznttPhKvdvt/T5xI95t6sg893fjI4QVPOnZP6Hb9mUOS4U+ipiCQdxnUUj8fi
	 jPjAQtFV92I9jVw7KXxm7Rg9Hx26VqsjuUbuybDNwvYUBurxte0emCmJIUM272RgZ/
	 2JnjgtR6J0DL84sSow+Rnrhfb6KeXuQPHPtc5fYMdBfVIVA8bQ9I3VYMTcv2F091wm
	 BJS3JTOdWiKAH72+zBdWQWxjZ6r2wWYjD2wGIZtOtsX0k7xnEMKfqZBoPsnYXuv+TR
	 G7CwbO19o+X8A==
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Akshata MukundShetty <akshata.mukundshetty@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <0e0f5ede-8993-4fac-967c-51e46b095416@stanley.mountain>
References: <0e0f5ede-8993-4fac-967c-51e46b095416@stanley.mountain>
Subject: Re: [PATCH next] spi: spi_amd: Fix an IS_ERR() vs NULL check in
 probe
Message-Id: <174422993445.1502711.4345013913869460825.b4-ty@kernel.org>
Date: Wed, 09 Apr 2025 21:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 09 Apr 2025 14:00:35 +0300, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it doesn't
> return error pointers.  Update the error checking to match.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi_amd: Fix an IS_ERR() vs NULL check in probe
      commit: e686365c0411275474527c2055ac133f2eb47526

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


