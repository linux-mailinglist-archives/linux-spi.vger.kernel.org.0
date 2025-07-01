Return-Path: <linux-spi+bounces-8980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62501AF0675
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 00:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070E53B3183
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F430204B;
	Tue,  1 Jul 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V19HtCXZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA3306DCA;
	Tue,  1 Jul 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408151; cv=none; b=MVVPotsxrXQS8iFG7wB5E8div9XGHChhu6Ugks6tHZqlVlfbiB+vo+7h5VJMMj2kI/frz5EDpUeDpszS98MpRMS6zPKaPwk74mEd3ZiY+Xk3nktNuKCDkpBc2ebN7rsnEPjRAxJaZrZ/LtFAEK/dAhh69XjUpjfQnOOy8wIsUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408151; c=relaxed/simple;
	bh=04D+JS2003GdPVw8fiokFwAo443bwxVqwjtWTOuioCc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KuNg6OExoW/k5nJp0o5cKbs/PJ4TMnsva5YTNyUJp0jyKL3Z7IWDbzNMM8pEVOSF7y1mowUKE6fY/0ioOC2+nKthwWHsF414gfpCEClzix0G41Q9uGzMI2isOJanZtJ4GNGouCcN+RiYAppCrSShjZN90yalGR/+QwlOAS8bxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V19HtCXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55216C4CEEB;
	Tue,  1 Jul 2025 22:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408151;
	bh=04D+JS2003GdPVw8fiokFwAo443bwxVqwjtWTOuioCc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=V19HtCXZ5JCSI49aJcbh1jO/TAap3pql/IAVxOBZC4YLPVBSfCyyn6ZA0vgPt9vjr
	 YFkj8yhTAA+ZeoKC0X368Hn90t+1QcgKVFZDMm7HquXcYYY8iK9pqbTwiPZGUKfXJq
	 gck/CGDS2WCIh+s50hJ1Qj8pc13GUOSNOjXB1qfI6wtZ+CtoXDUWsvc13l4xrdN0Zi
	 LaV/QKf4BipjIxy2VXWXW0IijKfsb5qdGaL3UwnQ7zJZpNCKHuwEBcM+XWhGHTQfc5
	 8wHHmXDm83NEIIGBUBRmi/2Oi3nV91Ti03ytuxhp1YscQwzQEFjwB1A12Uf0wesiMG
	 /zfn6TjbhaI5w==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, khairul.anuar.romli@altera.com
In-Reply-To: <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
References: <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
Subject: Re: [PATCH 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on
 failure paths
Message-Id: <175140815008.710092.15629077320051792048.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 23:15:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 30 Jun 2025 17:11:56 +0800, khairul.anuar.romli@altera.com wrote:
> Remove incorrect checks on cqspi->rx_chan that cause driver breakage
> during failure cleanup. Ensure proper resource freeing on the success
> path when operating in cqspi->use_direct_mode, preventing leaks and
> improving stability.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths
      commit: 04a8ff1bc3514808481ddebd454342ad902a3f60

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


