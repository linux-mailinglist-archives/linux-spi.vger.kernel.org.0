Return-Path: <linux-spi+bounces-4199-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3298952F7B
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C944B248F4
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26371A0710;
	Thu, 15 Aug 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhY8wB3D"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA801A01D2;
	Thu, 15 Aug 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728771; cv=none; b=o6nWgWk1vxkKFVbh9SaNh1se3qQrCTpXZzt/AFdG5fNppBTIDgD6lb906nTuThfcOApk8UTNVk1pwQgV9OSiBRXnLZMwT9MDxxc7LKPG1yCH47xvoiqmn4FTUkFi2/uwW0CzRj6FOWR3BxYsGgEi1XRnOY7WA1pXSc4LKsvc9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728771; c=relaxed/simple;
	bh=wMSu1PtYMqQn69x/ONlv3i1Tsbnb4pb27VWgqX44RGc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kogH4T8sTuYUIGzGx5XWn+d8TZ2iOGs6ZSlxTea3llAZjRJM9o/d/hsoH0Mn6l2jAqprTgYTefyJqrpKHOOqMiTBj4oVAZ9sIn2NeGnmtj9rpFT+R54oG9BTCvU+Rq93+DX0XVvi2sxCIfdjGW87Q/5Fm+Q2ry5XBcgE5ylFHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhY8wB3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859C3C4AF0A;
	Thu, 15 Aug 2024 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723728771;
	bh=wMSu1PtYMqQn69x/ONlv3i1Tsbnb4pb27VWgqX44RGc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=qhY8wB3DSPLSgTttK9kq7NSEWwbaWMUj9b6IqwGZl7qe4QX1HS5Y4SPjmS+u7mWLt
	 PKHkOv0fzfSX27+KTkohHcQv1LBqdha8nVg2KkOv8H0gBkzXVGNyzfrW4MxFfoBU8e
	 JNWDmmftOpALbF01VYWr5IaTpo0ydwEaqDO1fS1iPbWb1X0KlyMqOVlkVUlHgb7I16
	 aFirUApFntZBl2GHX7DUybFGrVAR9BWQidxqPr7YV045jHexyANczHCEwxFK+uJRrm
	 9+vs+X1FNwFlEZ6dlVCrSOqqECFRjBS7oFTPhdT9zLVf8cQ2B2Ih7cyypfqhxSFZ63
	 5O/zCWjoKOX4g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240814144525.2648450-1-andriy.shevchenko@linux.intel.com>
References: <20240814144525.2648450-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: ppc4xx: Avoid returning 0 when failed to
 parse and map IRQ
Message-Id: <172372877027.37632.8385090726658445918.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 14:32:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 14 Aug 2024 17:45:12 +0300, Andy Shevchenko wrote:
> 0 is incorrect error code when failed to parse and map IRQ.
> Replace OF specific old API for IRQ retrieval with a generic
> one to fix this issue.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      commit: 7781f1d120fec8624fc654eda900fc8748262082

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


