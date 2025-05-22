Return-Path: <linux-spi+bounces-8231-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F885AC08A7
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595291BA83EC
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCD2882C3;
	Thu, 22 May 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJlxGnYD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171292882B5;
	Thu, 22 May 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906061; cv=none; b=uSFQsfuUtOEvgMFWQl7laJ0WLmVeNPZWGhod6icdAnJsj8EwgnK7CXLe8LUeZT3FFy6g/cXQ+u1/Msg2K2aPKVwlWkbE1LWEhTSJIIgkpGRxeyEyFcfyK+gNF01hnaIni2VUIrEUriad1Yx6IaUTc9Ec80FWtXShdGQkAI/9NyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906061; c=relaxed/simple;
	bh=8zYFm2/+iwmpkOGr5JNANwTIY7S1T/GRs1rvV4bxXfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FHD4i8FWJyDwYodQ9gRXvbtLLG9ujBiws8oDb68FcgQ1OJ0YqHF31Q6IsTTnTMa5YgfE0FJYZO+lQAb5DOOLQ0KKLooz1u+D4q0oTU4NPa3HnG8+yLV0cTK5UgUbuUgpQiP0zv8DzNh6QB6TK8jXp7VpN1KbkTlGqxCB31FbsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJlxGnYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E29C4CEEF;
	Thu, 22 May 2025 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747906060;
	bh=8zYFm2/+iwmpkOGr5JNANwTIY7S1T/GRs1rvV4bxXfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KJlxGnYDHsrrJJ7Q69yDauuRz6o9ebRYVFgSnPSy+ebfpVhSFcMMLuBM8O9H755qs
	 YA1B7c8dewFsFnuLE8hkZ06+1iTRMEUl0yVqMyIH87X8mcw+vKbHuqFYJLoJF9UNhX
	 pJ+KBxXS63nSf44Jjr8c08yznZsMYzbYfzFpqES4JjrD050JyR8MGf0ZSXOxdkw8HS
	 WiZTo7zgIJtf3gU9kB17C8j64hdG0VrPa+X1mJezVp4EyemGXO8iNHLr3j5M2s9/LB
	 KOc8LJElLUCh5yVraqU+F4GmpWnqzi0Yla9yFyHzEWUiJkx/vc60yNwZPNloIrMIXP
	 WRZsmR+GDYIxg==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250514-qpic-snand-error-check-v1-1-c0ebd3aae72a@gmail.com>
References: <20250514-qpic-snand-error-check-v1-1-c0ebd3aae72a@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: reuse
 qcom_spi_check_raw_flash_errors()
Message-Id: <174790605877.30110.13985629144771079611.b4-ty@kernel.org>
Date: Thu, 22 May 2025 10:27:38 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 14 May 2025 12:16:38 +0200, Gabor Juhos wrote:
> The qcom_spi_check_raw_flash_errors() function can be used to
> verify the flash status after raw operations.
> 
> Move the function slightly up in the code and change the
> qcom_spi_read_last_cw() function to call it instead of using
> an open coded implementation of the same check.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: reuse qcom_spi_check_raw_flash_errors()
      commit: 4026c6b51cb9ffd1eea2206191552f8aa3cb55ea

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


