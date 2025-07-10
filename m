Return-Path: <linux-spi+bounces-9084-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D082B00043
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 13:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50885856AB
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34992D3EDD;
	Thu, 10 Jul 2025 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOgqG+Wx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88C28D849;
	Thu, 10 Jul 2025 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146017; cv=none; b=EYVlIWINJXzM5aPbgFS4MpW76ZURuGWf9HzaYEjsG8wWgumk1xQr0Pt4uWMPjRucdm1z4VJJsfcA42E7DhygI2bkdDp9XPFINlgjZVIrwQKT54igTKqudJwhWwRAKbov6voJUCDXLfyJ4PdGU/GWpSJuOp+V/E6lDlEbdrPghuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146017; c=relaxed/simple;
	bh=OoLYBnhLJYfCo9HG3hV5sR6JogSd/wLdFOxOWe+t6to=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TIEJFd+7uNkZx6Xc2ZMKfUn++0Aazo+RFWc8e/24YuQKqFVemAmaYJjU8s2c972nI4gmKdbPPxBHAjIx0bc7S3HWdY8ar/LsbhW+Je0axAaHWUPsaEioES5U8nbOp3yhAyqKvBa8+csM9j9ugGzX6qVh0uQHr/H/Hvzjvi9QfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOgqG+Wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6441BC4CEF1;
	Thu, 10 Jul 2025 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752146017;
	bh=OoLYBnhLJYfCo9HG3hV5sR6JogSd/wLdFOxOWe+t6to=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jOgqG+Wxe6iqpX5fI9eQTHyoDLsTAgpiAnmPHpxzCvTvth6ffZTdhBVy2o/RUUAVW
	 Giv+aKItOhB9RQtFpqe+52QsP08QdO+kbh6p0pO4O/B+yxtp9emLm9tBxHhe8HTwBT
	 j7EMBmRMrgT6GbIuJczv4hV9CfOdLSEibMvdsr08Ok/WNfp+n/2hAVJarhMUUBi4Sx
	 xoxfJunM61UhRuIZcKd+xKAs0DKhpC2RCNoqY9rkftyf6DYqNYBgG8pnfIVdQLtP1D
	 GDrCuPAZsIMRjaKXvbGDwMJ63ILOD9cGeQWYw9UuSss7kdXddH2g2GzssSSu06rTxz
	 mx0od2lKO0cEA==
From: Mark Brown <broonie@kernel.org>
To: michal.simek@amd.com, linux-spi@vger.kernel.org, 
 Darshan Rathod <darshanrathod475@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710045058.1325-1-darshanrathod475@gmail.com>
References: <20250710045058.1325-1-darshanrathod475@gmail.com>
Subject: Re: [PATCH] spi: xilinx: Fix block comment style and minor
 cleanups
Message-Id: <175214601648.738213.2181786988530151709.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 12:13:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-07fe9

On Thu, 10 Jul 2025 04:50:57 +0000, Darshan Rathod wrote:
> This patch fixes block comment style issues and minor code cleanups as reported by checkpatch.pl.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: Fix block comment style and minor cleanups
      commit: 469d7ea8e99124e4def5d98f928ffb4a659aa1c8

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


