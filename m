Return-Path: <linux-spi+bounces-9383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DEB24C48
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408D13AADEC
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478341A2C06;
	Wed, 13 Aug 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvvYmTkc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B385157493;
	Wed, 13 Aug 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096086; cv=none; b=SN53KyzduXsnkJdujQ3DJ7Fobfa/WPMIBTRKnPl2alR3b5JsHRCM9iOlek49aznWGnN5kgAi3Mn+IawdSZSGLx9NmoNYC2SmsbpsYktzESw8yWhHiJjbVJakyXv8hCYXYpaYDLfcDqNsA6R8GF1cmhrnXs352NJsDUAQ+Ul8olM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096086; c=relaxed/simple;
	bh=HKyIijaXh1w5Jroesi5b2BdQwMPe++PeS/K2cJkbz34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bry4cFsmoFY0+uPSyPPpEA58ZM+dMgmha9Rf3vV+ztPoJEm9dJaxIr6R29iRGZvd4npLY3kORoeHaMwqq7bv9Eo3+MTCvkEAOMczC/7Ry504ntLNrJl2S8VfQi+mT7YVQYezyNlnEPyET8hT6ekyIK/hBmb8l7JTJaZbCuzaVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvvYmTkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23010C4CEEB;
	Wed, 13 Aug 2025 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096085;
	bh=HKyIijaXh1w5Jroesi5b2BdQwMPe++PeS/K2cJkbz34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fvvYmTkceWapnldHCjNmp31jGhrmafhA5kz4KJpasZ/draEa3npUieeDNyij73UZh
	 TuNSEsYfw7xDcU1WinAH9oPyN1VTxChGbb9vVPY0jg4FBPVluRSP+5+/QHtRUi0e5d
	 ftQ3J8j5wHu06bAoS9ZCbd41TeUd9rmE/uhWgruMH8TNOESoGppDdSrJNiFx8kKUgH
	 RVQM/17LR5mHrvc3B8ha0wyhzF5jED+l5mcK4s/dT0xOn6rrHH0Dl+VZrapQ3YDVN5
	 GNFLmU2PNMW4KaeLWQoF7IDvkwJX2VUuVGFyqD+9eMFYoTVANyWxIaMNaKM5fLfy62
	 C3r9VU+xzwugQ==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com>
References: <20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: handle 'use_ecc' parameter of
 qcom_spi_config_cw_read()
Message-Id: <175509608387.67167.5532108779894723750.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 15:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 08 Aug 2025 19:15:01 +0200, Gabor Juhos wrote:
> During raw read, neither the status of the ECC correction nor the erased
> state of the codeword gets checked by the qcom_spi_read_cw_raw() function,
> so in case of raw access reading the corresponding registers via DMA is
> superfluous.
> 
> Extend the qcom_spi_config_cw_read() function to evaluate the existing
> (but actually unused) 'use_ecc' parameter, and configure reading only
> the flash status register when ECC is not used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: handle 'use_ecc' parameter of qcom_spi_config_cw_read()
      commit: 9c45f95222beecd6a284fd1284d54dd7a772cf59

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


