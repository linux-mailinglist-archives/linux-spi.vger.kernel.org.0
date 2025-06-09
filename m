Return-Path: <linux-spi+bounces-8404-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ADCAD22A2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E35E18876A9
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879878F4C;
	Mon,  9 Jun 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLi6Yc/C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0CCA5A
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483614; cv=none; b=Xae8XfDJUrnYRkdzERvUSeH9ksyHIQNDUrfql+RY4COOZJ/GPAfjmnd+yIuCDZ8hOY01Z7EaGve5zsfJRyPaegHBKg1IZvgtgV3r9mFVm8+q4DBZxwnKYd0LdSzAQAhpfYgBFsXSEdUaO9giSrOZUlcJcLWlVW2tJIL4xT3giTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483614; c=relaxed/simple;
	bh=1TffTsn/46+6uWHTGOhzaSPmd3beCMG+xK8avzSuPb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g/fg4NpXFkm5M/UYkzF7xUxRyD57CRSnDyM9KjbDytl5Sj1E7c5J3P6u1oYRcEDuXZAZiq/rMeWsx8Qh0xDi7BlLNviwFyuVlrw9p853Ypnq2cnZWBbrA0JE0Xoo2/iR2UMqpgFTNR8y1vYGPAgcw6j39xFHc6XQKElG+gZJ/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLi6Yc/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B967C4CEEF;
	Mon,  9 Jun 2025 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483614;
	bh=1TffTsn/46+6uWHTGOhzaSPmd3beCMG+xK8avzSuPb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tLi6Yc/CXzggpjBwsAOc64IrtI1l33pPEndF9ul7DpTo1iXqvPqEgnJMKqi7lwcSo
	 m6bT1Zjgzg6/zgoZsiVmHKHOtUjzT02Lr7r4X1xsyO3u5rSZj0ehFTDKWAWaGAmdBv
	 DLXlfeauYS6jlwsLOna5M0M98hlV4fLw4bHu01vQr9GZPr+yG825TvuS9/EWEaSr5Z
	 v8Bgxv2sBul6iNcbZDKqcGLjoJQahfyzEg/mQbDF+Ld+MpPUtHf4XlnmlUK6jHDRyC
	 G7vDrVIqPGN6V+oq03aBoSMMnR6scXa8SO7CEhwxjRQEtxEbZABuvPgu6sj0MOnG9I
	 6yX+wOzsDws2Q==
From: Mark Brown <broonie@kernel.org>
To: dlechner@baylibre.com, Andres Urian Florez <andres.emb.sys@gmail.com>
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
In-Reply-To: <20250608230422.325360-1-andres.emb.sys@gmail.com>
References: <20250608230422.325360-1-andres.emb.sys@gmail.com>
Subject: Re: [PATCH] spi: offload: check offload ops existence before
 disabling the trigger
Message-Id: <174948361310.189907.12236490414966189651.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 16:40:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Sun, 08 Jun 2025 18:04:21 -0500, Andres Urian Florez wrote:
> Add a safe guard in spi_offload_trigger to check the existence of
> offload->ops before invoking the trigger_disable callback
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: offload: check offload ops existence before disabling the trigger
      commit: e51a086117ed857ea455c9ea774dbfb82f53e517

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


