Return-Path: <linux-spi+bounces-2765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653098BF4A6
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 04:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9761D1C20C35
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD91118E;
	Wed,  8 May 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSYKPE15"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D914280;
	Wed,  8 May 2024 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135943; cv=none; b=CdVqfO4Z5IVwVKc8Bj3EUF3Zf+Bq2A0VvSHcjOuhEMiS8VwRU3eipWbqgaxmVComGzAfpcnYCOp4SAQKp6sEQDPaP6LwclKnEeNEf78/EfKdFQL7D7JWS/jzf3vdl8BrQxGlpMzun1ucFwluyfVSC06h7rvhJugyH/yLnINIl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135943; c=relaxed/simple;
	bh=yO+3ZfP6F5IGJ8ySuqvhoUyxGU1oUsE5TR1iFXasBjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XdJ8Y1VOsfJvMnuw71K4aUuGZmqx6M5fxR4QeOWBTruKsYdlmj2VwdCZxWhBlBmmDYSPT/ub5SnXsKAIB+fX5QyufBhJy8Pv5K5ieQ+0jtruGdlRfEnFgT3FQ8K7e+jbYIGk+B+E0YXf1OAj6sG2DlxS+8mMbb81rb/tTPV1yjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSYKPE15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DC5C4AF17;
	Wed,  8 May 2024 02:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715135943;
	bh=yO+3ZfP6F5IGJ8ySuqvhoUyxGU1oUsE5TR1iFXasBjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fSYKPE15o6QQxFoTUQnt+Y/7yR+poSL1+l1ngPwo5Xspd1mJGKzF8kiMSW5nc+YTH
	 sHVmrneCCkJgLIATKGlyOzn5UmgcMnFGr/mal4VZKSmxEE9uUQ1HrGPbNU5uk/L1DV
	 Uy7ZF0oke5It7UDGd5okU3wL+rYP9igjWRHFJR8dngLhKVkj+23g2xMebJygxAPzLG
	 433rEFv2b8Y12TMzodtqdIQ7HpANZJP70MxUaA6vNDT2CFot/XdmmlKVUqS6Xhoop4
	 sjH7HbZBeqO+neh/sBuiHVRdPRbAF2k+ax+2dz+Yqy+SpSNZRpojqwJGY2u3YKlVZA
	 AdTeIwR3jQKmQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20240507132002.71938-1-andriy.shevchenko@linux.intel.com>
References: <20240507132002.71938-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Drop the stale entry in
 documentation TOC
Message-Id: <171513594193.1998064.8483481511572900949.b4-ty@kernel.org>
Date: Wed, 08 May 2024 11:39:01 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 07 May 2024 16:20:02 +0300, Andy Shevchenko wrote:
> The documentation had been removed, so should TOC entry.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Drop the stale entry in documentation TOC
      commit: b62b9c90450a0789a55287a56d6930276dbae0e1

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


