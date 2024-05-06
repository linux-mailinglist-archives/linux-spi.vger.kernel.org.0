Return-Path: <linux-spi+bounces-2748-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44DF8BC503
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 03:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54571C21043
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 01:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445541741;
	Mon,  6 May 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP4GcFDv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985140867;
	Mon,  6 May 2024 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957496; cv=none; b=blaBy7BO4yYtbVEqDynrhhZlcS5sS3wui2BfCiAhWbUCmlhiXYhhFIxNwZVe2/sit19wihYOES/CWXow4uB2aMSrTv+QAdPryWAH2N0svbYZ77Pj7JNgynI5j4nDwWnGUMHgP3o+CNOyBv6PBdP0KV7ktXRN+q5D9H9PXdTPYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957496; c=relaxed/simple;
	bh=RA6fq+g6tB5SNWtr7Udny9YoaDMk0LNiDzQ8jyXNAsE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NQxbEiubExf7tBbg8msAyAmqiVVHJ5Xy/rQgW/UlW+g/rE2SSB0lXx7glgXY3V92SB/kyIPb7A6bWCU4bxPOQmqgZSiDg33og/fZLxTJTzWHCZn9OuYO+WzeIwq1m633zTCNPfNy8K2wG9C1N2guTcUcfPz5AOUkj79p7UGDhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP4GcFDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E214EC4DDEB;
	Mon,  6 May 2024 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714957495;
	bh=RA6fq+g6tB5SNWtr7Udny9YoaDMk0LNiDzQ8jyXNAsE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=oP4GcFDvDbyJJMbl177Y6pcS9GmTnTkfXC2pjhvZg4jPJFcy+QBHPke+eJJGnPZyB
	 R6m0b5t5+DACzA14wLsRhW5PXJDX0+SdsNpzPTlq7fYUBYLm06XtSAwEwC4FFFmiI2
	 9P4w/04RdaCouSfQxbv+n3xP7NyaV395yiUd4DH1ad25Xxeb/BX3xlFUo59bAeb9Cc
	 6iW2iqX6lTuT0o8Gd12KjaSpVdmVGfRO+oQh973Q8qUAo1cXwhgh4byK7SLTCsmp2e
	 RMBcG72R9jrZZMCtXu60eq61fFqhfUM5hA767GGk74jqCPmOuhSMsDUSMb6SmcWKrT
	 ToYA3jRp2Qo2g==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240502154825.2752464-1-andriy.shevchenko@linux.intel.com>
References: <20240502154825.2752464-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: bitbang: Use NSEC_PER_*SEC rather than
 hard coding
Message-Id: <171495749464.1941246.13700108191121303721.b4-ty@kernel.org>
Date: Mon, 06 May 2024 10:04:54 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 02 May 2024 18:48:25 +0300, Andy Shevchenko wrote:
> Use NSEC_PER_*SEC rather than the hard coded value of 1000s.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bitbang: Use NSEC_PER_*SEC rather than hard coding
      commit: 645094b41157cce4ec41dc31298646c82f6998e0

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


