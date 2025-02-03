Return-Path: <linux-spi+bounces-6607-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D1A25BFA
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684633A483E
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A25205E08;
	Mon,  3 Feb 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzTnoVxA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491202010F5;
	Mon,  3 Feb 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591936; cv=none; b=dxcTu9SZeTliY28Sk16ThA75QPov6H4vUArC/E3mv8cG4CwBBNgmXKZZQuMRIhAxFq676ktIjDpDwL3Ksvka/lUPAGoQEvH5KPpBzMwG9HxlA0E9iTMUeKUbd4WRWrO05blKfWGnlnh+WlE4omJi2U/mpJRSviKN6I7EV63yMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591936; c=relaxed/simple;
	bh=mGVANJKWibnpcCXC3IcHRYT9WXJQXf6udtwu3dq0dJQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GV3gFEbOjqIecfjcLg4EME8V43ZNhj3V5YRrWWX5m1BXmj2XTc4iR7mn1Tg9AKtZdQqKHKWhuhMAOuEd8mYEjM0nszMeJWAJRj0cfWmMklLmkJp9NwOUEEUdfyIFf9e35U4ZOrL2s82afjV2wZz3Alh3aCIeq+8bXHp4sNyP75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzTnoVxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B79C4CED2;
	Mon,  3 Feb 2025 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738591934;
	bh=mGVANJKWibnpcCXC3IcHRYT9WXJQXf6udtwu3dq0dJQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mzTnoVxAstvGz7/ClpvqeYiz/Srrh6+fBtfXRScFP6ZmAzat01U1SBvTX9l1Ifj9O
	 DDZzCLQ0f2bvjnXki3Xj7SFGbqhSSSfOCVAOqevy+g/em/wfnFS1ZQuGnX9q0cw8Hn
	 gmaTIIAbfSFCR0ZjxL1F6xhwDltqVUJCr+hSB5FCd97Dtm/pY+eg3OvmuzwKRUS/Hz
	 B6ACDEZFBSAEyTLKoAnAiokzBm9G9+XpFcCKK38cS1wBy6t4PKminEKw7Md14BesF6
	 iqW2IpoA2py9/gyKTazwZi481QKrXDIjq0OqsPXnN8MMtuviJ+5e0eH4xrBTGx6/kt
	 NaFf+7CNBXfjw==
From: Mark Brown <broonie@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250129152925.1804071-1-andriy.shevchenko@linux.intel.com>
References: <20250129152925.1804071-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: realtek-rtl-snand: Drop unneeded
 assignment for cache_type
Message-Id: <173859193360.165692.11079984707923289559.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 14:12:13 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 29 Jan 2025 17:29:25 +0200, Andy Shevchenko wrote:
> REGCACHE_NONE is the default type of the cache when not provided.
> Drop unneeded explicit assignment to it.
> 
> Note, it's defined to 0, and if ever be redefined, it will break
> literally a lot of the drivers, so it very unlikely to happen.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: realtek-rtl-snand: Drop unneeded assignment for cache_type
      commit: c1ac98492d1584d31f335d233a5cd7a4d4116e5a

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


