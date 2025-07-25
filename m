Return-Path: <linux-spi+bounces-9190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04526B126B2
	for <lists+linux-spi@lfdr.de>; Sat, 26 Jul 2025 00:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344703BCD37
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 22:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEE25D20D;
	Fri, 25 Jul 2025 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWLQJ0dy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80661254873;
	Fri, 25 Jul 2025 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481685; cv=none; b=JFhelLy8CYFeDiQ9nNs08MqmYlJAh7F3q2+PVOZe0OTjFVOCXy5dHyw8rfyb10fATmUfgT6reAoWt3C0yGT+ZyhDmDJNn3t4pFYE7uuBBzu/7bACK+/MzjhAhy9TrfUqfOWHp/ujiZl6dgUSUcZa+hr8e1JX7EFFNr8MrfVdiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481685; c=relaxed/simple;
	bh=b8rCfE53wlLuFLBYoVNkRFSwCOM0EuDoIabJG6094zo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bjwt5Pli4vKnvLuzhnUq4XI+UjS8P3aSdFmuJkjZkajpTu+OP4nZ5en/Jm2U8zX0ZmzFRAB3jIzXBsNBuIxUBUU+FyAhPX2p8HUHSdXUPWIRwanjjc0l8Mbnq2uRj1MXMgAqq7kOWwxSovJYtkB2Tu2WhtTL9u9gzaIcfpGCgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWLQJ0dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A263C4CEE7;
	Fri, 25 Jul 2025 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481685;
	bh=b8rCfE53wlLuFLBYoVNkRFSwCOM0EuDoIabJG6094zo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QWLQJ0dyHnW7hOQ4uPERUoDPK/7gpsZUKYA0Zirz+7TTj4L6addhl4RuwgwpF9LyS
	 /DwOdUmNd89MyOdK5CrCumKrOjjh6UEWnP4nC+Hh7blGBFFBsMH6PHnAQwl6UWhZOZ
	 QNPJmHB9OZGNlBI35O0luYIG9Zwt17aQGLV0D6Wnt7CBNt4F0ep1xKIqZCSFZfSXDB
	 kjjl92pX5hItQOhFdg7/t9OnH8p9bBd9S46SzKamlN+wVwTunudiGtYF4oGiu2ZfDv
	 elu2IlRZUv1K7z2emdPNansWBEzOZEEZimX7hUoIBnCUDi9Dsgq14i0s/c0zXfas8o
	 13hsS8DkLMBsQ==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, linux-amlogic@lists.infradead.org, 
 linux-spi@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250725171701.839927-1-colin.i.king@gmail.com>
References: <20250725171701.839927-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] spi: SPISG: Fix less than zero comparison on a
 u32 variable
Message-Id: <175348168282.1556893.3635657379454630854.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 23:14:42 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Fri, 25 Jul 2025 18:17:01 +0100, Colin Ian King wrote:
> The check for ns < 0 is always false because variable ns is a u32 which
> is not a signed type. Fix this by making ns a s32 type.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: SPISG: Fix less than zero comparison on a u32 variable
      commit: 2d442a0c781403702de27ccfbc4bb233721585f5

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


