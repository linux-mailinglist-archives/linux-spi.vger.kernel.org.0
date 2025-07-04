Return-Path: <linux-spi+bounces-9045-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6FAF939C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 15:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD6C165CD3
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232D2D63E8;
	Fri,  4 Jul 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF0CUR60"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BE1E4BE;
	Fri,  4 Jul 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634320; cv=none; b=FT9D0i8W5PL4cne5ZadOZZ1jf4gzBf3SFGT3y9RLqW6ffvJEslLgZO3YsQZq6+kQKn1b8jsGpSTlPF62M2SP7LwXu+IoN5+KS8/xc3tiAyS2h7BMzB2qSetvU5Q4BpoTkT6cSGbWo1Ol1ISGiJ9LgOyRV/kuNo7dFwLS93+xwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634320; c=relaxed/simple;
	bh=n18TLJdy8oRm425IB+2oUJysVscGffgpBK8bL7uhx0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UcMvgyvhXXgrfWT4EpF08lx5w1Lg6LYsqaWPpxfS9U2dZ+seK6nwxsG7BzDHWy8ZshS2i+TRfu1s8j6lpDtFzaMTz+VGCZTzOuNGgZuRNq9EgsTeeyEo/0oVyruJgLm7aImPDFiqYS/YoI3YcfC3l/5Ty2jqGAPnKyDSA9/OzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF0CUR60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864D0C4CEE3;
	Fri,  4 Jul 2025 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634318;
	bh=n18TLJdy8oRm425IB+2oUJysVscGffgpBK8bL7uhx0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qF0CUR60+B0U4xZ7bFWniSc6zlFtqqKo5a5Q2VEQHK8vcVwJcKjJbrjzoiumcYDBp
	 CbBESEuriBSY0pRe+AG6ef8NrKht8Aj4ZuukiFJMn3ukEzhC5VtFl712HFXPVq+w/R
	 C5x4uFADOwdB68eRKlZzUEiFzDCSf/WL0PfJbpYmIGsVCVzIzG+UU6fb0aSsOnNtVQ
	 D+hE8o+4+6qKjvKqceZ74Gp0d6vsDjWrdTuUg6LyrTo/leczMkVVrxIAOOLmGELW09
	 E0kb4jXtkaWcELMsZnVxenK22dTuTt/A69Fg8ugT2tRl8D14Eo/Y+kuQzjQQTZkF78
	 ytW1M7xl906tw==
From: Mark Brown <broonie@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
References: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
Subject: Re: [PATCH v2 0/2] spi: spi-qpic-snand: enable 8 bits ECC strength
 support
Message-Id: <175163431628.70446.712797583195740189.b4-ty@kernel.org>
Date: Fri, 04 Jul 2025 14:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 02 Jul 2025 14:35:22 +0200, Gabor Juhos wrote:
> This small patch set adds support for 8 bits ECC strength, which widens
> the range of the usable SPI NAND chips with the driver.
> 
> The first one is a preparatory patch which adds some defines which
> allows to avoid using magic values, and the second patch implements
> the actual support.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] mtd: nand: qpic-common: add defines for ECC_MODE values
      commit: 0dc7e656ddd54c3267b7cc18c1ac8ec1297ed02f
[2/2] spi: spi-qpic-snand: add support for 8 bits ECC strength
      commit: 913bf8d50cbd144c87e9660b591781179182ff59

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


