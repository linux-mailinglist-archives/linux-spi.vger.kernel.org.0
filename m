Return-Path: <linux-spi+bounces-10710-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B99BE84F9
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 13:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B101AA43A2
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C64343D64;
	Fri, 17 Oct 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riBoFF8m"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF3343D62;
	Fri, 17 Oct 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700304; cv=none; b=uwufEdONJznjr8bFmrURM4IW+E+S/np7qXH923L/nhtp1o8zyc4GCKM33G0Qrly0BJeT3VWcgUFZz9bshydO/xrKZkY5Xg3g6HM/T3Vr5YuvGdMb9J6wu2ApRgR1CdGvaxETLwSmR9t9Vn1eiEkKMyBnIqf5ZZYkRk90i8zTytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700304; c=relaxed/simple;
	bh=Oha5M5RT2nW2MzZklI9wS7QllDX3Iir9ry2TjWilqqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UeRMayI+p0G93PiZDWzstnwFHuSI6i0a4prQb5tdA3uQvMT0peB1+NqDanF13lOJgRh7EU8ZX805jOykLUd0Ub4+kPArETtGC8MFpo/aZMojgN3tYaFWOZm4ElB+tRFRHQ46Ebk0vnYDhiIMjGCY+JHk2rRxe4ujl1NpsP93QOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riBoFF8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A735C4CEE7;
	Fri, 17 Oct 2025 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700304;
	bh=Oha5M5RT2nW2MzZklI9wS7QllDX3Iir9ry2TjWilqqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=riBoFF8m0IcwZ+37LWZ9Kck4w0akHJzJVv7yYIxm0Fk8dSrg4j4K38bYDy99GWGYC
	 J/xmAsajaw9OaKqCLeOv6Walg3iGIPnpzmNNxlvfiEtN0Ei08Vk5NyJR+EpnYuI3fJ
	 Isr2v7iiBXOY0NnkQ5vnwAZqrZCw3sBNRtdoI3mEK74++fQfoMOEDlDdigjHjympjJ
	 GU8vjsdfjhPmKyS3wwEWENJOqTpBy/alzbSTyXtZUn++6fZWnDqbLI2OttmDNXtoZF
	 ugApFpcYV1uHfyMll8Vq9165mHODLDwJXT4eaw2hrzsrNI3JM46p6tU5uQxhsXai0O
	 RvslakHm7ZigA==
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Colin Ian King <coking@nvidia.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251016153000.9142-1-coking@nvidia.com>
References: <20251016153000.9142-1-coking@nvidia.com>
Subject: Re: [PATCH][next] spi: aspeed: fix spelling mistake "triming" ->
 "trimming"
Message-Id: <176070030059.36285.11703430965734905306.b4-ty@kernel.org>
Date: Fri, 17 Oct 2025 12:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Thu, 16 Oct 2025 16:30:00 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_warn message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: fix spelling mistake "triming" -> "trimming"
      commit: d77daa49085b067137d0adbe3263f75a7ee13a1b

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


