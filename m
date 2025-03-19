Return-Path: <linux-spi+bounces-7230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305FEA6964E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C863AD2C0
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D591E9912;
	Wed, 19 Mar 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db+3YzpQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747041E5B84;
	Wed, 19 Mar 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405028; cv=none; b=nnowLLp9TmPLlP35sipITAWGV00l28WLmdhMaxjmjj+ezpoXDbtBuFZMxjlQ4UeVfCyTWAhBLo1WSpcNfKHk863TzcGlb42j5z5Xa2/JafWw4XHuAucXSmaoDcOkDGLK6vyphdPmsYFxVxDepB6CXMm6StauYMM3Ci9dEE76nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405028; c=relaxed/simple;
	bh=yf7h3h7aB8DN+3Z80ZDPaPWpsVKy4drrnoFasvpQu7s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HTO7ak7YG+WNrLFE/f55ubkxunXfttuEVRTOVanO9yDi/c8NhAFQfha+wbTH5Gu7yMW8ra0z+FZwPEa6CkdFv2e7hNyINYXOF8NgERkYxfN4sBqoAWXBrFMQyiLuSkO1hqMdlOKlHfnseTm3ela3+/s/ItMGtv4HbX6Dmp6s/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db+3YzpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13ADC4CEE4;
	Wed, 19 Mar 2025 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405028;
	bh=yf7h3h7aB8DN+3Z80ZDPaPWpsVKy4drrnoFasvpQu7s=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=db+3YzpQkovmQB2y3dKy4YHqpuK42RrdCeHj4/bShbTYlj2CiRe4ykWSbTB8NpWBH
	 Iv3dPNPEE5ZOZpb1pEQvjT2s+/OMdWI6pgAvl/Ewpa38UIkv8PEXOVlsldoeij3G35
	 DhdJ9CzmsDomgnDJz4EJXVszsyfOS2FoQxcvY64VXhSWl9+CP1Oj1dZc2mzKs+vfNM
	 UlvDekIANo6IWlUhA2yjTjd3bj076LbjxABaN6Eilyx4KXGRVmbfGhmfcWjgkebgA9
	 JoIHwv+LPQQeeBCfdmIYbe8yyYBevvyCo1+OebIGCC72kdBwVP4Q1o+Wt9JZKggard
	 elvwOk1H8lPCg==
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20250319032305.70340-1-linmq006@gmail.com>
References: <20250319032305.70340-1-linmq006@gmail.com>
Subject: Re: [PATCH] spi: Fix reference count leak in slave_show()
Message-Id: <174240502665.226445.6515258089892546670.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 17:23:46 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 19 Mar 2025 11:23:04 +0800, Miaoqian Lin wrote:
> Fix a reference count leak in slave_show() by properly putting the device
> reference obtained from device_find_any_child().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix reference count leak in slave_show()
      commit: 176fda56d72a267731f82aa4a3aeca430394f10e

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


