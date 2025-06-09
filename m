Return-Path: <linux-spi+bounces-8390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A85AD1F1E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7A83A253E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A67D25CC46;
	Mon,  9 Jun 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXy51+m8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24AA25A631;
	Mon,  9 Jun 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476444; cv=none; b=nY83lLxWURxtA6ppaYilos64LyR3IjPXoZrhUTPKsdbi/gK+RoptKMryC9RKhHR2NnzMGEF8xDA1Q909Y+5ZRgwvwd42u4v2i6P1wueNU4gYSnGZqU0HkST97tTQzikctqf4l5+v74Pu/hforJEOZ0dQT2+q9Ye5SGrLiuPxtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476444; c=relaxed/simple;
	bh=kDyUA8mgFEs1qSG6t7cqKN865VNbzZWG01Qzykv2IOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QJ8D+aK7RVHO0XZTfDewKTL/u0zjOQO42MoWVYOFkGlr0sw7j4IWx4x0udzHFkwmFZ/YXUM5WFq4ic9veHMRTr4OfJGmOTJ8jEvqBg4xe+gsplYumkmMRGnpe9nuYShK/GrEnHLrhh+7s56TV6C8ajKR1qKgRAb8HXKK3//78aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXy51+m8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E1BC4CEEB;
	Mon,  9 Jun 2025 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476443;
	bh=kDyUA8mgFEs1qSG6t7cqKN865VNbzZWG01Qzykv2IOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FXy51+m8pZt4w89BebUTcP9U19ZzKxvCdhb1w2p14AnbMYOMEOxbUvVGzQUkvq8HM
	 ggyLoTdZpiCNtvJ8qG1UOaXYqd4cYldoWw3KK12EqnySp5mEp9PKZUJlp1tiMOWK5H
	 NTTkZkDpdHBb2WdQKDsc5n2gtJUuHjNpQB4vJZcPi11ayoUXuH5Vy8mce3P9D4W62E
	 2Nz9KOdXGerPIuZAB6BQbE3d5p7NlWqu78RBbjbYX1jzgRqNVe0Snrn5T6/IrTGJF0
	 6s9BGQYlaxV9aZ2eVdVddEKZozebP6kljK87oHo1zaAp3MUUaKEO1vPe61r+IEE4a4
	 6UngyMWeqzICQ==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250525-qpic-snand-nandc_step_size-v1-1-6039e9bfe1c6@gmail.com>
References: <20250525-qpic-snand-nandc_step_size-v1-1-6039e9bfe1c6@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: use NANDC_STEP_SIZE consistently
Message-Id: <174947644168.127013.16924191452084129544.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 14:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Sun, 25 May 2025 16:15:25 +0200, Gabor Juhos wrote:
> Change the qcom_spi_read_page_ecc() function to use NANDC_STEP_SIZE
> instead of a magic number while calculating the data size to keep it
> consistent with other functions like qcom_spi_program_{raw,ecc,oob}
> and qcom_spi_read_cw_{raw,page_oob}.
> 
> No functional changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: use NANDC_STEP_SIZE consistently
      commit: 6c1ca9928ed48499f75101057079b92072077d44

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


