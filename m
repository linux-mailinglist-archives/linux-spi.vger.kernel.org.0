Return-Path: <linux-spi+bounces-8775-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C9DAE8E3F
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 21:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECE47B3F25
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F512E11BD;
	Wed, 25 Jun 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQXCQmT8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7A2E11AC;
	Wed, 25 Jun 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878748; cv=none; b=VdkQ0lRpfuJreI2qixr2tzpQ9XUFycNrknRd+BbbZ2vRbheVLK4HZm+jSHCK97SF+P/6LIs0pY+9lyKQ3YN/2DNvaSVrrF0ZjMrNqTcQ8miukGFaUzcbeSro41SwLAys6m8nUuoWVkddZno82v+Df5i70+Af6wkrAqVjU1Sewe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878748; c=relaxed/simple;
	bh=+qriwj9qU4FY/kuIp4wDLlM/t8OqijQo1R2YW3zdLuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FWS7WRMiATkTIkA2jJ+IUqd346fM+XYRrhjf8wUgwn65HF7y7QnsrWsa1ZC3XAmvhOo2pVspCtsSdz5iw+yKylZVP/za1rLSH0SjfjTq0sZL0+M55xyW5EGQR2G/7hgCO6NH2BUARVwplmaTgnAZWLIyaWC0nVm3frUIkYwfTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQXCQmT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC099C4CEEE;
	Wed, 25 Jun 2025 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750878747;
	bh=+qriwj9qU4FY/kuIp4wDLlM/t8OqijQo1R2YW3zdLuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jQXCQmT8D2h0EMiy0LeKaMVgq4MMLwiB5Ojl9jxZUv3lfWTMXOdg/Ik0UrDQyUSjL
	 4MyfWPrrhsFgzVudtvHgpM62ZTCCpPxy35fmIvUUFQNGqTyaa+MlvHiuIsfLG1LPq7
	 DqO/X6euoQBAnIVWUFCtnMvL/ngetC26Gn7NfJVTg6zqih6MrgmXqtLPNUAMhF8Dyl
	 MqUCjuQmArTDzS7IxOthC7s73wiH1W/851Whej89BlsJAhXIvMsYOcLLDNVEoVpD4k
	 IO0k5pr5rxMRmHCfbJBy4JwocPtv2E4fPF/CDD2INuRNUBPSpXrHi/aKwXrLqj48Gf
	 MZhLmOg8QqPSA==
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Erwan Leray <erwan.leray@foss.st.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20250616-spi-upstream-v1-0-7e8593f3f75d@foss.st.com>
References: <20250616-spi-upstream-v1-0-7e8593f3f75d@foss.st.com>
Subject: Re: [PATCH 0/6] Add few updates to the STM32 SPI driver
Message-Id: <175087874236.261602.8727707950137724434.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 20:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-08c49

On Mon, 16 Jun 2025 11:21:01 +0200, Clément Le Goffic wrote:
> This series aims to improve the STM32 SPI driver in different areas.
> It adds SPI_READY mode, fixes an issue raised by a kernel bot,
> add the ability to use DMA-MDMA chaining for RX and deprecate an ST bindings
> vendor property.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: stm32: Add SPI_READY mode to spi controller
      commit: e4feefa5c71912ebfcb97a3dbe2b021fd1cea9d1
[2/6] spi: stm32: Check for cfg availability in stm32_spi_probe
      commit: 21f1c800f6620e43f31dfd76709dbac8ebaa5a16
[3/6] dt-bindings: spi: stm32: update bindings with SPI Rx DMA-MDMA chaining
      commit: bd60f94a3eb4f80cb66c9687d640554fd0c579d0
[4/6] spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use
      commit: d17dd2f1d8a1d919e39c6302b024f135a2f90773
[5/6] spi: stm32: deprecate `st,spi-midi-ns` property
      commit: 4956bf44524394211ca80aa04d0c9e1e9bb0219d
[6/6] dt-bindings: spi: stm32: deprecate `st,spi-midi-ns` property
      commit: 9a944494c299fabf3cc781798eb7c02a0bece364

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


