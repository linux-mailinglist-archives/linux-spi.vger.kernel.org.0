Return-Path: <linux-spi+bounces-5108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55396991380
	for <lists+linux-spi@lfdr.de>; Sat,  5 Oct 2024 02:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C05B20B9A
	for <lists+linux-spi@lfdr.de>; Sat,  5 Oct 2024 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9E2231CB1;
	Sat,  5 Oct 2024 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjWt2epM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFD139B
	for <linux-spi@vger.kernel.org>; Sat,  5 Oct 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728088123; cv=none; b=M5mbUS42OfZdLZ9GO7ftbsUs5ZDFH1sEKOwN8xIQ1t9izBJEEiT0VrrepjaJxGKpR7AeqZTJt7MBA6wWHrHXwd39CREhaQOjcqk6Q1uLUOnnfAY68uVKiFqFzJdDqDhN/1tZ1NCc2MMcumlLtZc8tfwBhpS8VaLVtVLTZdLW7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728088123; c=relaxed/simple;
	bh=QN3QYNazJSsr4T1l4xNnq3/AQFqpL9xAT81H4/2++sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=koY3QEnLfopPFpg3qtqNW4EoYR5UmO56qe0mP3BsMPgOIKoDDGxL1b4lE1H38ZiUN6EjQngDae/aHQJzV2SEODx4BFmeWQbMubzs3cD3tidjj3SLzNPF7n0cLFFSyT1BTsQfbQMrEeFhYxZ8DxBrbAxfh0ovVVvvkECRISDpAKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjWt2epM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B235CC4CEC6;
	Sat,  5 Oct 2024 00:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728088123;
	bh=QN3QYNazJSsr4T1l4xNnq3/AQFqpL9xAT81H4/2++sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EjWt2epM0h/oT3mtXLcW2jOgEp5vcF9opmOnN7TQN3QVQh3wiMvdDEu/G8zrqtyD5
	 lQz426mJlLkMkL5m8GmcH4/n/ybDY2nFpWwB/prxiN6aea88O/VAtO8rNyj6/1ixM+
	 JaGmR7vp4e5q12Mwnon8+Tc76r4JLk2MF/U+MW80aNZuHMYKDI+AQUKHdYjy7ZP0sZ
	 Y6DiZOoirPs3vlodXSLdCrndeQqF5r1grJF08buBiZuTxzyVTOfanc/+/s+27A80mf
	 eloiu5dm5LE49bNF3NgsW4iTPe1mq9tJYE3OHQ0sJJT2lS91TYDHBj4zhqR3XttzaW
	 FR/UWiai7mwtA==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241004094234.268301-2-u.kleine-koenig@baylibre.com>
References: <20241004094234.268301-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] spi: Provide defer reason if getting irq during probe
 fails
Message-Id: <172808812245.772385.9598122622609309473.b4-ty@kernel.org>
Date: Sat, 05 Oct 2024 01:28:42 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 04 Oct 2024 11:42:32 +0200, Uwe Kleine-König wrote:
> Using dev_err_probe() in spi_probe() improves the kernel output from
> 
> 	spi spi0.0: deferred probe pending: (reason unknown)
> 
> to
> 
> 	spi spi0.0: deferred probe pending: ad7124: Failed to get irq...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Provide defer reason if getting irq during probe fails
      commit: eb6c65049a274c37f9b6fdf632843b609a0b8fa8

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


