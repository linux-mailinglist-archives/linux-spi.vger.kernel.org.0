Return-Path: <linux-spi+bounces-5878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C29E0908
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC606282300
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236741D934C;
	Mon,  2 Dec 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrYJk03x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3951D9320;
	Mon,  2 Dec 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158265; cv=none; b=fJAN6NHT5D6sJJeJg8qcbjYNmoG7XndLOuImpzg+WJM0l7PPozy8kJd3hk2Aa/60q/j9we1axKvcUV/gqes7Leo7+gUMH4FnjX4K12KgFWCKVlqEQ91JLCZ7mtOdTpMq6u7hftVEieUthSaZFwLcZekJeyRVnYYlHKi8uTmQnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158265; c=relaxed/simple;
	bh=QKJkgD+6MJkJNvfAvqe3m9p1Tobg8vhFPDwp90WmMSI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q3wxia61C7SqAqNikHD3vbA/cm5NTvwRaTYiUfDtEgufEKzIrnYbhP6EAlc6CZITY+sOYuz101TDwjMgGOde5nmLlErOKbVkSodj2iLbwQmyC2UkLKJyvYWj80sSpGwJZbVTWig0HRCop2nuDVpoXr9f7+h5qfb1J0cYdBOGL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrYJk03x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A414DC4CED1;
	Mon,  2 Dec 2024 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158264;
	bh=QKJkgD+6MJkJNvfAvqe3m9p1Tobg8vhFPDwp90WmMSI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=QrYJk03xrx9E8lndYRR0dlMYZ5oE9cjloxzF9jOjuinQDagu6Ih6Blv1Rcg649XtX
	 BEL7caMGzo7MMpMGo/tWWvwJ5NHuKoeTUIo2LUxA95gYWA3URdci/WvjhUO6YtARPs
	 1AIper14TUkSD/v/kaU4ejMbZKag0SWiUbKeL+bh5amPhhF5QFE4/YjR07rmVt/D7K
	 O7p24KzAF0AP7qo5H4I5t4HM54h0A9/FiF2vSik3lgMZG6/xTErzjkhG3o2Nsi7rpT
	 DZ0Ddnzz7t0toikSM5M8fmH6Lw7hEtkFV24XpDlQmNhm14O24owoNymHShEE9sIOms
	 ZkC9gDMlTEG5g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241114205051.3747458-1-andriy.shevchenko@linux.intel.com>
References: <20241114205051.3747458-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: sc18is602: Switch to generic firmware
 properties and drop of_match_ptr()
Message-Id: <173315826335.126887.7469821187723092456.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 16:51:03 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 14 Nov 2024 22:50:51 +0200, Andy Shevchenko wrote:
> This enables using the driver with other firmware types such as ACPI
> via PRP0001.
> 
> Also part of a general attempt to move drivers over to generic properties
> to avoid opportunities for cut and paste.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sc18is602: Switch to generic firmware properties and drop of_match_ptr()
      commit: 2c55f67c3a71cf57665294a02f258625c1da9385

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


