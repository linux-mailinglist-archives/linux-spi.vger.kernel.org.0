Return-Path: <linux-spi+bounces-9369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94988B2256E
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA233B3553
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27E2F0C52;
	Tue, 12 Aug 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d624ujV5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95F2ED169;
	Tue, 12 Aug 2025 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996752; cv=none; b=eBkK0F9XwBq8C76zqAzhAmHy2bvqKt+G+3zhLGqb7GP2DrDz76Bkh+NXqQtJZ1QGr+iM0sesAu+HaxYNKEumeEvX3ztG1A6ulqyQ2n4Vly3X0JiKEWQyeqMDxP19hcxJhpxKvIVE2ZXg0GzRSfFUWUYo5fuc7KUyJRuFYYbohAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996752; c=relaxed/simple;
	bh=DGBwd7HI6Oga0JpYuggyAkH1JckI/My2MyU/bIDITDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AkjIEqPKk6yh4FVtrzWRGN1+wj+Pjmx1XBvq8oQ4bmiupqHs5lbOENEsPrDqyFSvwIEDOO59j6riJgOauXDQzaCMBIM1G96VvMTnWd76C/HRrf+NXTDUwRto30an9bqHJ4YddtMwMtSmRNSm/mNDD9LFVKmLpD40d+ig1t3BMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d624ujV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DD0C4CEF0;
	Tue, 12 Aug 2025 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996752;
	bh=DGBwd7HI6Oga0JpYuggyAkH1JckI/My2MyU/bIDITDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d624ujV5YrzBhnXJI6stdFAKcMcxObw/+VltX6y+h/21EmYh9/NfFSyceW6rj7rFE
	 J4JUcX6S+v1qRqrcSJF38i72KNlnRiPlpQiIS2a/nid5zFXFkeg1qUKpnFj2+v0Li0
	 LSr9tdm68dduD9mHRO3xpidpPexRpuy7iDdtcuuLtyHNGh0olbkIzD19uoWF4dcDWb
	 sh8hNsH0K2ys7bRB+axOMBy0QjPKtym3PlA9Cl5jXYafDzuPoaps8uxkLKXiDbhHBU
	 gCgpBci58C8vmYJTp4KSQ9b6vHHEZJt7LsZi7EukSpX0DTmhACHLJGLZM9TLt77dIc
	 wEbjbdJ9jEZfw==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250804-qpic-snand-double-assign-fix-v1-1-9f4970107859@gmail.com>
References: <20250804-qpic-snand-double-assign-fix-v1-1-9f4970107859@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: avoid double assignment in
 qcom_spi_probe()
Message-Id: <175499675187.16293.10593496136406895897.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 04 Aug 2025 09:52:12 +0200, Gabor Juhos wrote:
> The snandc->dev poninter is being assigned twice in the qcom_spi_probe()
> function. Remove the second assignment as that uses the same pointer
> value than the first one.
> 
> No functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: avoid double assignment in qcom_spi_probe()
      commit: a1d0b0ae65ae3f32597edfbb547f16c75601cd87

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


