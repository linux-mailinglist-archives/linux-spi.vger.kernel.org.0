Return-Path: <linux-spi+bounces-8976-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22DAF066B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 00:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FBB3BAAEC
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18541262D1D;
	Tue,  1 Jul 2025 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxM4hLbd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A811E98EF;
	Tue,  1 Jul 2025 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408144; cv=none; b=LvYzeLtyoIvMW2bVGKa5h3DCxL3unfxWwA0U0GkVVwIqEzxGnk5grv6S03+5Ev32YZIVw82EyYiz9wOuZ2/+AdIeALbwvi+oWbj6bNgG2ID2MkMYAjLnjIPzEULLIXBJH342rNwkrWd7hfRo42kBNhoCCx1nlTK4CLBL/bXYz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408144; c=relaxed/simple;
	bh=om0fQDtjhAjEN0F2R3PcJkGfAKXzLObNEQ/Y+tVNkbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jNFJvtjWsPswdJsC1iG0/TnFt4rZYqMZPD6PQ9VhRmI6sY+FRzzbTLR+4UEE3t5zfypnpVT8XIv7eBcSeLIfW3poXfwsZrS6aFli7BSkKpqLuuUnYUgIHo8LJlYnufMdfGd6K+gBhMxylzHZ0ZAVwN+R1kaA2cRBOJfkf66WKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxM4hLbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70DCC4CEEB;
	Tue,  1 Jul 2025 22:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408143;
	bh=om0fQDtjhAjEN0F2R3PcJkGfAKXzLObNEQ/Y+tVNkbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VxM4hLbdRT2JwAiGwjLVCV96RoYnb5PaCzoxjy3ovonGASbUuhStsrk6lwdlvawq7
	 MviA9f6c6l+5Am/yO7UILWod6+YC6guAhjXGZMonuESE7qvJFEb5CGujTTI22368e1
	 aL4r4Wnfv1Ar/SseKlHkgWiOr1L+bGSWMQIuYl4wWBpkeIWclaJ+LUuAqCjXSA0dTO
	 GyL8dLWYUNi1ATFHTUvTuqSioYVZ8jBxj7wHsBY4VcYeGDwbsxh2KE8uOpsOIbpjL7
	 UOMzKzirjVrRelOSnC/k+3nCXAjwk8kBFJ43Gim53RcH+m/BuJ+HrxwRX/qqLkXxve
	 XY8XNV03Ttwpg==
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20250630-spi-fix-v1-1-2e671c006e15@foss.st.com>
References: <20250630-spi-fix-v1-1-2e671c006e15@foss.st.com>
Subject: Re: [PATCH] spi: stm32: fix sram pool free in probe error path
Message-Id: <175140814155.710092.6699776738839101023.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 23:15:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 30 Jun 2025 10:20:13 +0200, Clément Le Goffic wrote:
> Add a test to check whether the sram_pool is NULL before freeing it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix sram pool free in probe error path
      commit: f4d8438e6a402ad40cf4ccb6e2d2417d9ed47821

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


