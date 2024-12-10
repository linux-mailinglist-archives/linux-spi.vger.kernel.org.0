Return-Path: <linux-spi+bounces-5997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B79EB903
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 19:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8732163C5D
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC92046A2;
	Tue, 10 Dec 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8M1OJEq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2862046B0;
	Tue, 10 Dec 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853932; cv=none; b=frUJOTaGSnoRyfUI5iVmbq+Mrw3ylUTi3FhYbpU3tTx6b7mX/isRJDekxhXqA7vTGYRp5+LLVASExsdZvPjt7cAxEPbqk6mo5F3FME0SL1WjxBbTNkC/1WQQYoGFadwoXxY+e8/8RlmWftHDV3Vc6AvKtwMQMj5tmD/Y65r+INI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853932; c=relaxed/simple;
	bh=JI5/X1+hJw4Wz2orEtTjiTiYwFyIx+C8iqydv3U5nWY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hip7MdHU2TswgnWlsbxvcJGnXtJG18YKlufaaccXqyBMdoxG2ClI/g1X7gKXcF61LMWy0Jvxs638TJ4O36qfM9/jYPIeOBxJx4uCxGIUu9sixU8gidLeOr1RPu3OMnieg7Fh1WleaYVKS1MkOsregKY30+5Cma5to6ZjomiOfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8M1OJEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DDFC4CED6;
	Tue, 10 Dec 2024 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733853931;
	bh=JI5/X1+hJw4Wz2orEtTjiTiYwFyIx+C8iqydv3U5nWY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=W8M1OJEqMhQWsLfjct6lLAmUTkJg88Edi+OQyjVoeH+vFri08jo/PycXSMIpgsGK3
	 Ejz0705nTtbLEpkbfJ8DMpg2fy/0ojZbbPd2rR/ZDpGsoncc3Ipx8wcOlk0tEjVu3q
	 TCzP8OYmE8qz7ONj9JB5KRPS6GTo72UsO9nQI8IX81TBw9RaNcHHz2/eLx8hIXpOUD
	 mTR2MFnEilsu2yZVQuM2kCKpFPYsnK6hzvc3kIzd97narrfyKKRIFFgSQEdn0FJEq9
	 4/W2RQ7fldjR/WZNduNas0kNgF8jox+pXFzMncIuIOfLGIk0o08xCO8yTDa2SCEnoD
	 GxDkb2Gl2Ja5g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
References: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] spi: Unify and simplify fwnode related checks
Message-Id: <173385393085.127025.726656879315481364.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 18:05:30 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sun, 08 Dec 2024 18:03:15 +0200, Andy Shevchenko wrote:
> A couple of cleanups on top of recently added change.
> 
> Andy Shevchenko (2):
>   spi: Unify firmware node type checks
>   spi: Deduplicate deferred probe checks in spi_probe()
> 
> drivers/spi/spi.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Unify firmware node type checks
      commit: b6ffe0e6147915fe3d31705e14dfbbecb724fb81
[2/2] spi: Deduplicate deferred probe checks in spi_probe()
      commit: 0020c9d2d572b49c55b2e1fabe6f6687e11a3ced

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


