Return-Path: <linux-spi+bounces-8275-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604FAC2B2F
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 22:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A7B1C03BCF
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34C1FDE02;
	Fri, 23 May 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH/AkxiJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79B146D53;
	Fri, 23 May 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033888; cv=none; b=KzvEMNtzuPu83UMyzZG1DVogGCB1X/Wp3nnUbgz5C94129zR74kgNRPWancWC3liBkgHqcjFfm8XxxguPRl4rMpnlR88Gui4nIrTxpbJfRf/DSOGFeZPtdcgjbTLUZytzZ65Acke8h1Km6BVD+ya8BvkA20uSpB5iRWCyNHuhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033888; c=relaxed/simple;
	bh=EmbjA22m9ajw1HCI2ySGSC0gt0WZSqV+K2WSqww2qvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=INWjI9ZOrEE0qRrpJdnWzz31XSwZtXZhqPcmMgEv4xQg5TJXzggQqpvYIfCucyO1Oyda4370llEB5N0tDy7LHgX3c4siFrpAIKTxPcCoyYDkNi7uIWU+4cJt8++bgBjjc09cdE+gksAnrH9DzoQ9EhA9bKmTo8tFlCfI7fmkZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH/AkxiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15402C4CEE9;
	Fri, 23 May 2025 20:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748033887;
	bh=EmbjA22m9ajw1HCI2ySGSC0gt0WZSqV+K2WSqww2qvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MH/AkxiJ0ZhiXeKtn9XHoN/mnj7DteExbjIGhTzwLEACbzg1ihDTjT4u1QIT/eqzQ
	 PFZKMvGRSTpIHc0XXyWa4aVFhiscPdWq490x7xjCPTg6+HlonrXKv9b3JzgVYHcat7
	 WeIUSiVxGofUqSTRax+x2BDCgKqqzRoOucR+26QUdiPeS10jQHaVAwWDtrv3jL60q4
	 kCYX1FictIk9OtkRITiKCYzbbJvQQSYJBVRC3kcxtgsEtym3QklkHL3+zwb6Z0w74J
	 tJbZCcoil8HRsA///KZKWvSdoYD5h1QahFNAVP4vOKr3E12tKiuzd5q7/V0IN5LoyG
	 OwZeJV1uzLmcA==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515-qpic-snand-early-error-v1-1-681c87611213@gmail.com>
References: <20250515-qpic-snand-early-error-v1-1-681c87611213@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: return early on error from
 qcom_spi_io_op()
Message-Id: <174803388522.585305.16829284807234779965.b4-ty@kernel.org>
Date: Fri, 23 May 2025 21:58:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 15 May 2025 22:13:29 +0200, Gabor Juhos wrote:
> When submitting of the descriptors fails, it is quite likely that
> the register read buffer contains no valid data. Even if the data
> is valid the function returns with an error code anyway.
> 
> Change the code to return early if qcom_submit_descs() fails to
> avoid superfluously copying possibly invalid data.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: return early on error from qcom_spi_io_op()
      commit: 72b17676d3683040a0add8988ec051a2a5adafd7

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


