Return-Path: <linux-spi+bounces-5698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B689C7A36
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 18:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD131284296
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475E2022EA;
	Wed, 13 Nov 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcvMZvdY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7E2022E8;
	Wed, 13 Nov 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520027; cv=none; b=E1VvnidmBGcMqS0+bbSNCcHPZliaIxu3T7qyGuuppy+aA0vH/wz4vIK+FvPQfZEdvqjbN6q1Q556r9lYPU4UF5ot9sHg+XV923Ed/U2t7/ifCcg5ozr68MvcmpuTG1WedlzuceJLNyBUjw9e9hndfggiKY12ytfClM2P4mF6IhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520027; c=relaxed/simple;
	bh=8NjEmZoG6cs/6tWDpxDdwGePjepq2tBR7948gl6tPak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IVCjViM3jBOJzX1nSpSG3uEKPfRkuPFDQS2ECaMjHhIGC2UXKf7qhOozaLsi8rPrHqSpBAzXQL/Fx6PHUf8rH3OM5bnTF0cldJcbbIQ6pn/ovu9eVGzPQTlbTeXsbg9b9SNbuXJTFUINzJhjMNJaNOqI9eSaOFBf/OLzXFurljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcvMZvdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5009C4CECD;
	Wed, 13 Nov 2024 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731520026;
	bh=8NjEmZoG6cs/6tWDpxDdwGePjepq2tBR7948gl6tPak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RcvMZvdYhNoxb31xfDE2bX8Uqe7DwUIqJA+bzlmMsBbuUbrCdvsg0h5b+eGLKmzwt
	 diFRLqyhSUUDdQTze7wTvTmP0C/kXp6VgGihsrPgymetEwBnEtf7zPmPLXSk3yLloy
	 0jH86TOfA2VdEzR8kK8SSA8hZSqgyFC0NeZTGeVEbZf1dFohoaDnA1YGlFqHSqxeAD
	 8dnH+bxt6e3a76z3XFQ79Q8J9wFCh4q4syfryn5XezFxd4n62XWtG2rrcWZqpTJ3Ul
	 WtffrPHKCy9klROUpSTSFoFC22tnhHsgL4C5Ti6ziMT6/SWRaIYfhEXlCkevnBA4wI
	 okPhUfI44fAsA==
From: Mark Brown <broonie@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241112081637.40962-1-zhangjiao2@cmss.chinamobile.com>
References: <20241112081637.40962-1-zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH] spi: Delete useless checks
Message-Id: <173152002535.472003.992214417304041252.b4-ty@kernel.org>
Date: Wed, 13 Nov 2024 17:47:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Tue, 12 Nov 2024 16:16:37 +0800, zhangjiao2 wrote:
> Since "res" will never be null, just delete this check.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Delete useless checks
      commit: b1e7828cf9343e1da6c575f3ebaa0f511d8b8cbd

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


