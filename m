Return-Path: <linux-spi+bounces-4197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F03952F78
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 15:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB25B2464D
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF701A00DF;
	Thu, 15 Aug 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1RKGOrG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6018D627;
	Thu, 15 Aug 2024 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728769; cv=none; b=BP9KXX8cUixW/J9Js0z3CbGfH5GHoN73zqtWgKznvIjYDHecVd+p5vdcV+hI/BSTF9AnDAxp/0PL/se3r8nYq6iRx/43qaNJ7hS29Cxk3hsvffXXUWTcHVLF4A9cdebkWbiJVVM50kI+WyykbE50J63VkT1T1Y5LE03Yqobq9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728769; c=relaxed/simple;
	bh=XhNCev36fKU4Ut6u0d8sIw96shRZ4O+aoeJp+HMD7jA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T2J23HSGPdc3zhQAweT8CQzyZiRDlG+qwbtHaWPZHy5hwy8WiAESLwHGt8wSWyLwh8NXfs/2xxLLYT1EeZecNTvW9doDU5mhpzVwjFpyh5IXQ20m1ohClgkWG1p36AmmVHlzf6NXF9PYNuzAyZVyWjPaQrzgoSTxjui/xraeQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1RKGOrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A66C32786;
	Thu, 15 Aug 2024 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723728768;
	bh=XhNCev36fKU4Ut6u0d8sIw96shRZ4O+aoeJp+HMD7jA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=E1RKGOrG68AMVWN/06u6tQ0yywctHMuOXCfH0CvEPRTxH58Eg1TTT6Ub8bgAlAUPE
	 ZXIYFtGKmDaGLTrnJhZhuZa/qArPAle10exHGWBKD/JWgG6EOWRyOtmB4bi5d2RtLF
	 Wj/3XKlb7XUuD2nFc/mTtdMziC6LGhDIK+FS+QoDf1VIiar+SMgRZHVzqb6gp+OtqF
	 f5iiLyrMmdMkaIHW1pB0zU312oVbLj+X1NyEbAwxivRoCW0BqqPtVBA1oZTO6JuPS/
	 gIU13RuYddySzWDKQwVKSxlo9LkB6ap3/ATLgNANCw+Jpe6Au0K7V4KbApt4z4q8/9
	 WLwx3UNyPuknA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240814143805.98874-1-krzysztof.kozlowski@linaro.org>
References: <20240814143805.98874-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: cadence-quadspi: Simplify with scoped for each OF
 child loop
Message-Id: <172372876745.37632.12287787390464765004.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 14:32:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 14 Aug 2024 16:38:05 +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Simplify with scoped for each OF child loop
      commit: 6a2ab229abdd9fb2177d0af72289eabcc971d985

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


