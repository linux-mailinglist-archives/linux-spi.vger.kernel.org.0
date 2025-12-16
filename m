Return-Path: <linux-spi+bounces-11949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB7CCC46C9
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19CFE3007EE1
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9568A3195FD;
	Tue, 16 Dec 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMz7uwpD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D823195E6;
	Tue, 16 Dec 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903597; cv=none; b=h7+27+0V352MmGT4QQIJqIINvLT9nfGAuhiDJ4PchtNdivxIPa2GBjVK4Zy+GxF0DU4UHaqxWnLuxkxRZtEoqOmn4SB8eLLcX4PS4aA4+fYxWhy5PKlaV958Cot/4QbjtEEj6abjaBgojt/CHgqSBoHvyLt0YeOEXe3CMSS9oJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903597; c=relaxed/simple;
	bh=UNSRNeBiaj3Rry5J7rpo+9jk7tXOJzVaBHlmdHHL6GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=isADHmsNO6/jKyy8aYWSc+4PiYOk545TK4np6VArjmnzaeIYztZFV18jI2EHRLglHxtFp6YvglnfXMKjJwrKonMt4hpDM/FiaGprbSKmX1BgIQneXNxKliG03rUy+pUzjFItGKXGItFd5Edmlb19aMc6ceuIupLh5lQ6NtL8zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMz7uwpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A850C4CEF1;
	Tue, 16 Dec 2025 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903597;
	bh=UNSRNeBiaj3Rry5J7rpo+9jk7tXOJzVaBHlmdHHL6GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aMz7uwpDOS8jcT7ByQo/F0gSxOsvd3ADD8dn4twiU3VojJjZqFs6Cliu1+bbKhuFN
	 DWT/B4oPIjpJqLuuyVLw+IPFazTOgHJqF627ME1nKW3tk6LU0mcBh2qNgDCmBGWxn6
	 2HzNigE1thZRsDbMRwI7IIXOtcHa+ZwMZkhTXESFX5x7BpIP3xeqzObs7kDdSvurWh
	 dU69Kkj0RwfHiV9KVz61JOQjtW58Bg1gLQOTdmHqgX5eJfNUcln8+IDemVDOcn9/h1
	 4MV0UExndT1dZ9UoLsNGm9VEjELK9LXeaXVt3PgoUzzFYctdxxq6fQRwU4mtIUf4p7
	 8TAVib8cccv6Q==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Erwan Leray <erwan.leray@foss.st.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com>
References: <20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com>
Subject: Re: (subset) [PATCH 0/3] spi: st: add power-domains on stm32mp2x
Message-Id: <176590359301.183097.12758319202580831902.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 16:46:33 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 15 Dec 2025 13:26:19 +0100, Alain Volmat wrote:
> This series add the possibility to indicate a power-domains for an spi
> instance and set the related property for all spi instances on
> stm32mp2x.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: st,stm32-spi: add 'power-domains' property
      commit: f4acea9eef704607d1a950909ce3a52a770d6be2

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


