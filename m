Return-Path: <linux-spi+bounces-4255-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A3F958742
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDFA1F21F87
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB618FDC5;
	Tue, 20 Aug 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haxd+J3W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CF17B4ED;
	Tue, 20 Aug 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157866; cv=none; b=YPvVAbsH30AR+nDbun3g2p/FBiwut8vi6iM6Bg8gjOw6rSwxzh9nX+2UDu/wzVIU0ywM6VP503TCLyOmh65MpLTWMo3BxXFadBsI517+HvxHQUlVBYAY2bOGmjIVsh5JYRgTr6A8D68+HsvQJMjxwsuCd8S+2muv3kYGCzWd+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157866; c=relaxed/simple;
	bh=RGJzIuM3gXY/s4hccdCdZDeMFU1m/1iB+bMvK0KmNFk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PSO3qYeJYnyi7YRUR5hQyICFp+d4+fH3Y6f/55TEiGG/hvMo5DQyC+73TtpC2Hk9hoA4wMtr8NwdogGIq+IyV0zXk2JpQ1WIN2d4eEiRQ5OuPKtqvZ2JwB1TuXKsdfr5PsdVuiCZKzOfxegP11CQRwbMknSWFqwFdCNKS9hNhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haxd+J3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F8EC4AF0B;
	Tue, 20 Aug 2024 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724157866;
	bh=RGJzIuM3gXY/s4hccdCdZDeMFU1m/1iB+bMvK0KmNFk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=haxd+J3WxFMeMevVp3Zj1DX3w4h8ZMIs0A1UMzayDm47W2wnZHa7riLxOFalAYQmL
	 xGcDQFsjJwReFQzgXzN86XWRJMOdNafet6iGwQshNrGCQAoq0tCYceUVyTHBN/IBjK
	 zEqeov3yaItOXqHXR03dum/nRGuQHhwQiG7mi/T/yMfCz8cxf9DZ57Iepi33YldjAm
	 PdiahP6d2G/FNO5hh4SzooCxK5KKD9MHklZx9KgMAoTSk+2dyzfcquq9DqU4gXM29e
	 sabJpSe5vMvbfWwK2KRrkBdY7IRjgrfYvP3GQjeg5jQWvU1yWwaimzDDZjwMSvnpoj
	 2Up1HLsIWDe5Q==
From: Mark Brown <broonie@kernel.org>
To: jonas.gorski@gmail.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240819123349.4020472-1-ruanjinjie@huawei.com>
References: <20240819123349.4020472-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next v2 RESEND 0/2] spi: bcm63xx: Fix two bugs
Message-Id: <172415786506.39812.11128236652869415017.b4-ty@kernel.org>
Date: Tue, 20 Aug 2024 13:44:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 19 Aug 2024 20:33:47 +0800, Jinjie Ruan wrote:
> Fix module autoloading and missing pm_runtime_disable().
> 
> Chanegs in v2:
> - Add Reviewed-by and Suggested-by.
> - Cc stable.
> - Change the fix way for the 2th patch.
> - Update the commit message.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: bcm63xx: Fix module autoloading
      commit: 909f34f2462a99bf876f64c5c61c653213e32fce
[2/2] spi: bcm63xx: Fix missing pm_runtime_disable()
      commit: 265697288ec2160ca84707565d6641d46f69b0ff

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


