Return-Path: <linux-spi+bounces-7091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA7A5CBDC
	for <lists+linux-spi@lfdr.de>; Tue, 11 Mar 2025 18:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3719D3A5D67
	for <lists+linux-spi@lfdr.de>; Tue, 11 Mar 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B0260A52;
	Tue, 11 Mar 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRe4HbNG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94374184F;
	Tue, 11 Mar 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713446; cv=none; b=QNSpvB55NnPMXbRV3jlnFVadMvmd2mu5iXkgb3Z5cTtj+wXX5nnKYrxwD2AdteOc6SYxq3DOX1cyG7MTwfZcWKZA/5cYt8YzLvKBXiFoMiF+tz8LZP5AZEEYActOLI4fEgF9lYuIJFQMmPv4Lg9j20KGBnasR+49C2SZeHHLfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713446; c=relaxed/simple;
	bh=RdfYl4n2/9SgcMMHHzjpqeg67v0PMk9cjFox8uwI04E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RWu2wky/8/Recp5yRFE/dBHwmHRRmnDEjqx217RVTH+T9xvqc81w6y2Qr6mfBY77iGXa2fjo7X8US4COx1rqCHzLT9u3CyWWAhmmUxidH2HVXXqPWSvRnuTP+sP2Ja0rX1sezTm5o5fGmX1P7SUlwy7aI2G/47Mr0Myt5q5IaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRe4HbNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CCFC4CEE9;
	Tue, 11 Mar 2025 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741713446;
	bh=RdfYl4n2/9SgcMMHHzjpqeg67v0PMk9cjFox8uwI04E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CRe4HbNGIPbAqili4lACHIPgh+PthkDcZheWnoZep6Z74Ex7lU4FknU3yPZ0xP0UZ
	 3ynHWYbuUBdeSmYYDXhyYWrr3oQ/48Jk49j97heh0/bOfGk8nJOT9KTsyEyGFVVFwn
	 XUEg8azh8iFUF11K4utyyzsJvjQFQInn6kAaUYM5hEMGE28UAKXWP8BuC/fLSpQTiv
	 yA1OSNzne3y6NNtYwv/LA3An3aNytW6sxxog8b/vD+LGUNk6OpBXSyvGuCOki1i/ZF
	 1VQ/GHWLxWwVEQWw9uNFubcDcqmudDJwHOaTZ+IyuqjLJCg1qyIE8UwSL6Q1xjtojN
	 WqggFxvs3ZWdw==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <2f4b0a0b-2c03-41c0-8a4a-3d789a83832d@stanley.mountain>
References: <2f4b0a0b-2c03-41c0-8a4a-3d789a83832d@stanley.mountain>
Subject: Re: [PATCH next] spi: spi-qpic-snand: Fix ECC_CFG_ECC_DISABLE
 shift in qcom_spi_read_last_cw()
Message-Id: <174171344440.214660.8181081504120181390.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 17:17:24 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Mar 2025 12:40:01 +0300, Dan Carpenter wrote:
> The ECC_CFG_ECC_DISABLE define is BIT(0).  It's supposed to be used
> directly instead of used as a shifter.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: Fix ECC_CFG_ECC_DISABLE shift in qcom_spi_read_last_cw()
      commit: cf1ba3cb245020459f2ca446b7a7b199839f5d83

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


