Return-Path: <linux-spi+bounces-9103-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5B3B0686C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 23:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF0E3BB07C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6751E5018;
	Tue, 15 Jul 2025 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYsvxLhd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D78F5B;
	Tue, 15 Jul 2025 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614285; cv=none; b=SccfJotp06hCNpIEWjbJhClSKKwl4zmQDWLrQMNj3gn2re2GYRMHN1IwaGASXFfWPCvS1DJFO6l2tBia+IbMPOBwnI3b26GAvTlwh4/AAyRMhZeNt29kN6d1dqPBiKXjc+q1i7AMAPrOYr6XoK5RVt0syvcZJT6BCEU33o7SzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614285; c=relaxed/simple;
	bh=Ihu88xlPjxVA13jRAIY5QXBJzvWgabY+AY3Avoaw2Bs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sMyEoZPytjBQYuT+5HN2xpM8agAUbSfZCwJOuepZlVIoG+vyc+dF/Oec8VUXEGzPTINkYZaje3VNT3x40ZwqaTK3Y3wTMMGms2WWROo9hJ+Z7PuWcslqPXuy37pBA0T3ubzFAk1ya12FmxjoUWpCgQvapt3RdajcpmH9sIR9g3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYsvxLhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BBBC4CEE3;
	Tue, 15 Jul 2025 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752614284;
	bh=Ihu88xlPjxVA13jRAIY5QXBJzvWgabY+AY3Avoaw2Bs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZYsvxLhdTwAc/K8ewGSECNdUJSBCk+jD2xHL8sivkGP2v0/zBcaNJGudg7xuZbVIj
	 ULPtQ8HRJcIplJhkYqL2NqWXSkPKNH5YbE7daLlCtix3etI3oaXO2lVMVTk04sscTA
	 vhPD76QE3D8roW40XbXJFZITrda9a4JsSpSDMlaFf7NloEmkW0PodHYIiWUa5kl+Zl
	 z5KFz/U8K5vuF89ZHnxwS9XkYq7FJE2dE8GKcRUbAWXDJnqYZwQH/rkgWn7YEmulvz
	 3dJt6c7D+ah5pJyLymjnNwJuO6CAilcVRj9DiI8t0KHk+buD9QJK0SpMrpT4diUYXy
	 cm3vnAZ77pdDQ==
From: Mark Brown <broonie@kernel.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
References: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
Subject: Re: [PATCH] spi: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-Id: <175261428373.334789.807419408201900794.b4-ty@kernel.org>
Date: Tue, 15 Jul 2025 22:18:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 09 Jun 2025 23:21:09 +0200, Raphael Gallais-Pou wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      commit: 6f8584a4826f01a55d3d0c4bbad5961f1de52fc9

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


