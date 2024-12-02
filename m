Return-Path: <linux-spi+bounces-5874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6F9E037A
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 14:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0977166048
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03624200B9B;
	Mon,  2 Dec 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F06a8CGE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B51FECD2;
	Mon,  2 Dec 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146241; cv=none; b=LBfnRpor84pvPLkdNuwkvarTOMTQV4Fl92h4WT+1D8w7z/QTDBrrKDBdeSxi9xvlqZXDZhZoqc7VbmVd/5z7C3jn1oIIyx5nwif5hrWEPns1ZKwpklZ5lwBzhfuzEii61FcEO8JPuh5gKD1/cCpgWErALlxr/6mtaDrn0mJblTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146241; c=relaxed/simple;
	bh=0L7xq5I8jnvsqyo1vi4o9DWhUq92QRZxs0rdJPkIi1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qXxbwUsoOpyE6uP7o/ZM7CvNSp0i7wpLWKpATppVkQm42zNbOfXiPNz4w6jtplkTN9cSSa2QdBVdlFBD2cjsNePcoler11kTRnxk7vfobpJsXAoqySxJuwKDyn1oyVFhGxAUkasImtmN6RubgEZal7jWNITmeADtyaEhaoAv1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F06a8CGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C260C4CED1;
	Mon,  2 Dec 2024 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733146241;
	bh=0L7xq5I8jnvsqyo1vi4o9DWhUq92QRZxs0rdJPkIi1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F06a8CGEPJXGp7CvHDbG56l65xOMToVFzR2rMDHnlq05tBoMAcIGLtlJpZI1LFvaw
	 21ez31VRp0RXzpXdcHDaibB/Yd3WBCvuxO3Whziwe6VpAF3EABuwgEeehrpFYgdCMR
	 bEdV+FPoRUet8aW9tXrY0IMlFK4ibkFN4oyhMpJKatIAy7UVECxn1p7NexTXVqok6w
	 wmohYG5Qd7EL8DeWb0syIPxhf9v2jn6BLNI03Gh7P6ZbpFFoWyH9bS38xmeh2vh+j/
	 Sq4Ld1q1ca5GLC45O63Cni1NiUsNTnw6DqfBR87dcT4j0BvjXS9npVALuS2YBuS6ab
	 c0QmARCUP8j7g==
From: Mark Brown <broonie@kernel.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: linux-spi@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241127-gpio-descs-v1-1-c586b518a7d5@gmail.com>
References: <20241127-gpio-descs-v1-1-c586b518a7d5@gmail.com>
Subject: Re: [PATCH] spi: apple: Set use_gpio_descriptors to true
Message-Id: <173314623984.54221.9478516701597362964.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:30:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 27 Nov 2024 23:18:29 +0100, Sasha Finkelstein wrote:
> There is at least one peripheral that is attached to this
> controller and can not use native CS. Make it possible to use
> a GPIO instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: apple: Set use_gpio_descriptors to true
      commit: 1b299bd0c22887543b276bcc5b4ed26f5bd83ae4

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


