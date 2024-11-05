Return-Path: <linux-spi+bounces-5627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D939BCD3F
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 14:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B331C220B2
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2951D54F7;
	Tue,  5 Nov 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5x4nBJv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C251AA785;
	Tue,  5 Nov 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811696; cv=none; b=HAySRoYGQgks8Hw5BkUMjdyCz6jgJ9wrger0sa63PAu/itvq9IgDIYkjPw7xYWyVY4xeMSaoIQrC4zIDNNZbiiW2v6IonkPjHXqUEvBVrtQ8aCAsyyQTjNo+sOBJ2sxNxpAGI4HGYkIf1SjtViv25h+rKa/0r8CBOG0qUvB9/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811696; c=relaxed/simple;
	bh=fJOSYsDtK+XglPzzlc6b+Xmzm7eSaqChjegMKNDSpQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nnTyJKKIIg02RNN1LKqghTNO1J4HITPy10WjCFzjW94OgCJmWcLnxwd/7Qboc/HWasxCaFSooIwXElR9si0jmROE2oSsZMyHu2dZkwkBtXJxj9Jr+BJI8aUMMf7H09OoMBpWPcokGydHUpYNHSf/A0zNpiebpOk4DFfIhAQkL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5x4nBJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781D0C4CED0;
	Tue,  5 Nov 2024 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730811696;
	bh=fJOSYsDtK+XglPzzlc6b+Xmzm7eSaqChjegMKNDSpQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c5x4nBJvD8A2mSltiCdva68UvikJDBMsUiqiaaA9BanjLedIdNlcReP6qZBpFzxVY
	 ZtTe17DQ0t2VEpg5RXv/+DMP5I9qMYsYWvoT2Yb+WUbJ5k3k2nYQOHH9GG8zz32VOm
	 Vr98ve3eupQiCPSQv2AHiJVWimOM7jMH1N07LaMNrI3TiYSl2DDCteJ/ZCvkonX7Aa
	 r+WqCaJk1DysgAuxh1aNuqC7RQIiH1Ex5JZagvafYGnJMTYJe0CN3mbNnZiSUjvnsG
	 BK1ygP1L3Rir8wIqzAyPRsCiZ+xqb/ym0yeR8aR+Av8ECeLFR4JJZNT4M7mMohJoM2
	 TncVJHdCHIy4A==
From: Mark Brown <broonie@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104190759.277184-2-robh@kernel.org>
References: <20241104190759.277184-2-robh@kernel.org>
Subject: Re: [PATCH] spi: Use of_property_present() for non-boolean
 properties
Message-Id: <173081169520.26412.3733026868948680541.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 13:01:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 04 Nov 2024 13:07:59 -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Use of_property_present() for non-boolean properties
      commit: 270ddc23914ed79aa117373f4b3413c34cdabf12

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


