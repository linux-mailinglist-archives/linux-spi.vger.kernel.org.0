Return-Path: <linux-spi+bounces-8230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110DAAC08A4
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F014A0F73
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B126286D67;
	Thu, 22 May 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBBPFL3V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F573286D55;
	Thu, 22 May 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906059; cv=none; b=rXJ0e0x4wmq4z+EdgcLeTnr03qDjsBzfEq7hrp3qZP/zgK/xs4t50ZS4VZEghaaksVUvyUOcZPdVe4eQvGLk+vEwNMolr2DZ8Cuzw6GCXnXaIOnddJ4icaGY6QlcV1aAIR/MSx4Xmu494GE8bS1zCMR77DcFYEGlSnyd/W5CvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906059; c=relaxed/simple;
	bh=CakTWiRTuc1kwxhluKVp8AMxsPKiZuuQKUFMa9udh6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oDFyod8DbMTgd06vXduSxZK9+Q+HtWL0P4mFaPZF5iWCrTyVFdNow2pDKVcmQs7qWzg/DKhqtyBkqRipdWnkxp0j8Pp++P5X8adv2549rbO/axyYbSosyJs2LCJJ0XoRACD2hhX3ZZ0QgCzc6uTWRtl8E3W4ps9hR0hVGSpU5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBBPFL3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED8CC4CEED;
	Thu, 22 May 2025 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747906058;
	bh=CakTWiRTuc1kwxhluKVp8AMxsPKiZuuQKUFMa9udh6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WBBPFL3V+XOLjxC8hQGucC04A2kD6Kd63bj7dTwhvUsvlh+lI9bpYNiOH4qUdQrCZ
	 9Tl1NrptEO+2ekEMfcO9Fc/8L4ZMgCxooC91YbjImqKGb/dChknJXAukPRoLmkB6lv
	 MWvSLnkxN+x25EsrnTcwloEG/N/o6PNsPY4wQbHItrtZP6tCdV/hl3Sr3D7gjeE6fx
	 Ot7gul2PK8eru4TKTsF48l6uYNGe0bFPX+YFoQJm+x8dpjYNjKeFKmy1tnGDsO0WgJ
	 16fvstYqwuFJyMc0thiU/DgHw1CmR+WNTmmucrCYPeU3TIguWiT09SwMvIwNsw8375
	 lG/yYna/ei1Ow==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250520-qpic-snand-superfluous-params-v1-1-86dd4963e90f@gmail.com>
References: <20250520-qpic-snand-superfluous-params-v1-1-86dd4963e90f@gmail.com>
Subject: Re: [PATCH next] spi: spi-qpic-snand: remove superfluous
 parameters of qcom_spi_check_error()
Message-Id: <174790605671.30110.1298547023446316402.b4-ty@kernel.org>
Date: Thu, 22 May 2025 10:27:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 20 May 2025 21:08:56 +0200, Gabor Juhos wrote:
> The qcom_spi_check_error() function determines the errors of a previous
> page read operation solely by using the cached register values in the
> register read buffer. The data pointed by the 'data_buf' and the 'oob_buf'
> parameters are not used for that at all.
> 
> Remove the superfluous parameters of the function along with the related
> local variables to simplify the code. Also, remove the variables from the
> caller functions which became unused due to the change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: remove superfluous parameters of qcom_spi_check_error()
      commit: 0f529570ecaf99244dc86b8af13618f0d07b0e44

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


