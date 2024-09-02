Return-Path: <linux-spi+bounces-4515-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41861968D38
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 20:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BDD1C22071
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3725919CC0B;
	Mon,  2 Sep 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHe5YJwP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68419CC06;
	Mon,  2 Sep 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301062; cv=none; b=VFs/+jC8Uhw56WH7jOAy6QjKcFZ5bPiiA1fOZPHuzruVqTb0uQMoYSHPcJisfYM8iRw9mQK10kh2C+LcTUlWi61U2woIFrBXOF3sEGHxp3F0KJMO8LstUUv556M6I3Zpt16WGUBY6QwWJSEpeRAevjx3usS7igg7/qn/W32FJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301062; c=relaxed/simple;
	bh=lrw0IYsbB+4zJJKJgBaZMoHTR0bRqD90s2UGstycbi8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dHKAAQhJSXPzpGPBxhwbG4BOtr+nut+Av6QlWXsegNZoC/iZl+TTpGlsVrENHTagwRj2gFNnybZbhwq8hNRniOJPiE2+fBU3PoukYPf2oEEloszxgfgpkd7KjcJYW5COzhhSBJeml2g8wy0AMnIhx83aHFuNS9TKnHQ2a4BEnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHe5YJwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418F9C4CEC7;
	Mon,  2 Sep 2024 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301061;
	bh=lrw0IYsbB+4zJJKJgBaZMoHTR0bRqD90s2UGstycbi8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ZHe5YJwPkxE+gi3HdsHkYD4HW60hncQx8HLjgRu+F50LeEeGM9M1xYzUPo1ryfUNj
	 Y7SOri2ZRX0r6RRh55C4SLyi7jiCvBRia8nitDqnhrGVfbd91cVv3uXAdTIcK/3/ds
	 eo5v79pp7k8ptc1jAxNDcD6khnJj/XtC3gNWu1VEJnpQKa0GvRFcYyNfHsXAAp4JZ5
	 gG1afdD98Q+NcCpXL/tlAIsfVufFn7gdUBDzW75q0jBf8001+wNLlQr0ULXZST7EDd
	 an6X8wR0a3rLKvdcAvXVMidQtJ535E7BPl9KjL34XboUBgqJC3YFivsTf8RrK2Depc
	 /Q3KpenqE1lgA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240902103203.2476576-1-andriy.shevchenko@linux.intel.com>
References: <20240902103203.2476576-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: ppc4xx: Sort headers
Message-Id: <172530106100.141806.10211922480486326066.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 19:17:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 02 Sep 2024 13:30:41 +0300, Andy Shevchenko wrote:
> Sort the headers in alphabetic order in order to ease
> the maintenance for this part.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ppc4xx: Sort headers
      commit: e86836883a8a624680f247c7ac200538c6a5ebaa

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


