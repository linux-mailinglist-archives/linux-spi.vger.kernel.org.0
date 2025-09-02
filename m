Return-Path: <linux-spi+bounces-9852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7048EB3FB42
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 11:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979941B23BAF
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35482EE27A;
	Tue,  2 Sep 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azn1tAwg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFD2EE26F;
	Tue,  2 Sep 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806626; cv=none; b=Kd50eoH9OK6LlmgRGCgYvvBEyGLe2cbbcriyZJVBD1DLL3PEdfjK7fyD/iXCmq+IJ6MXqvsVX2mR0aTVfs8oRAUUQWCsY/qvi9JCuQJ7uTgfsyHxNe9Emh2J2pdu2iDp3gaGPq9rmOYD6NxJYXuonTpazk+kBlSW4iiio9VgBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806626; c=relaxed/simple;
	bh=Rh4xSvpGX1ZdAlUm22AG1xj9isd8q4OwwRbkT/mwt5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N96zxqCScbz+gLrsgSwEk9EzXaIVrhC3t/x3QGxpRZfLV72KC17PadsCNsF5AyLXhfeIMAc1qeutg2QKVKfe0n4DLL2ZTJfv3sMrWluWT4dvnO92n2gh+HnEyf4tIDYV53x1jIkpwBUlgRpnaJ2wNVmGg1BLPPrFlPNX6Vy0uZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azn1tAwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF464C4CEED;
	Tue,  2 Sep 2025 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806626;
	bh=Rh4xSvpGX1ZdAlUm22AG1xj9isd8q4OwwRbkT/mwt5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Azn1tAwg/A30VMl/ZFVxB+KVp5niwqpQu18bc8hHV20JH7w9uSIJ6qDH1J3M9i3CZ
	 x0fWyR8uLu8OcgUo8nAVcXSeIk/xJYOktNIl/cXmg41bE6z/n9oUF2Sla5BYyUPs3Z
	 iyo+focwU5hcOVhpM5y9otgJhiLL0RtKaqdLs+LQM8D1sz8berRkmdCjtcf3WhBqzt
	 mk/aI1glfZE6G5Z2qsthgMHiv0GQwIy/CRJL+/N0kKIk4uFZMFK9Xsz3OJYeqBmmpi
	 p8QlIaCd92rPGW9Y0rMkroC+I1ABGaHTBWnaopUtA8QjNVNU0MXCkzD5Vcwx7tnMf5
	 eoPtdpMdMaOLA==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com, 
 James Clark <james.clark@linaro.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
Subject: Re: [PATCH v2 0/9] spi: spi-fsl-lpspi: Generic fixes and support
 for S32G devices
Message-Id: <175680662264.13759.15008785215722769791.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 10:50:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 28 Aug 2025 11:14:39 +0100, James Clark wrote:
> Various fixes for LPSI along with some refactorings. None of the fixes
> are strictly related to S32G, however these changes all originate from
> the work to support S32G devices. The only commits that are strictly
> related are for the new s32g2 and s32g3 compatible strings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: spi-fsl-lpspi: Fix transmissions when using CONT
      commit: 782a7c73078e1301c0c427f21c06377d77dfa541
[2/9] spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      commit: cbe33705864ba2697a2939de715b81538cf32430
[3/9] spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
      commit: e811b088a3641861fc9d2b2b840efc61a0f1907d
[4/9] spi: spi-fsl-lpspi: Clear status register after disabling the module
      commit: dedf9c93dece441e9a0a4836458bc93677008ddd
[5/9] dt-bindings: lpspi: Document support for S32G
      commit: b663fd4532699cc24f5d1094f3859198ee1ed4b6
[6/9] spi: spi-fsl-lpspi: Constify devtype datas
      commit: fb4273faa4d0eeca8cb7265531d48eb084bcceea
[7/9] spi: spi-fsl-lpspi: Treat prescale_max == 0 as no erratum
      commit: 9bbfb1ec959ce95f91cfab544f705e5257be3be1
[8/9] spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware
      commit: 41c91c2eed83cb93781078108077b7e34f867fc2
[9/9] spi: spi-fsl-lpspi: Add compatible for S32G
      commit: 431f6c88cb5d2d62d579d4d78f5c1a2583465ffb

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


