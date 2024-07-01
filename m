Return-Path: <linux-spi+bounces-3711-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617C91E2D2
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B723A1C21B5E
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765916C698;
	Mon,  1 Jul 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnx8kpEK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAE14B95A;
	Mon,  1 Jul 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845533; cv=none; b=RnxPdCEkn5mximaWYXNn2/EIevEB1MbksUjFRnN/Ynj18udOfx2lGPDZRKYmR/sbVV63W2CORfzoqWELfVnu3C0UMp685iUC+k6L1ItNu9Jxq3BUiAI8SCsrt4fi9A1UNDQ6bnIyz0m4iGpGJVRny7VNCoY3TwDMhHiYvDGGmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845533; c=relaxed/simple;
	bh=5vB6rfS074k8h9NxKGPuRUpIHxHySANWovl75hV6ARg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WIO55miZQzICITcYraJe9/gFNxYTVftS4wuS2UUiX7OPP0qR/6UsWEd06fLIt4ZcDo2Ps6b6JiCqfgm250WPbLfmLW/DxsQQp2JQfj/UGAVFvLvg9nuHh8m9s0cYdEPLzNwCpgV6dWjOsCcgQSwis9SIYWJ8yuQvd8cOtaTERWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnx8kpEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0750C116B1;
	Mon,  1 Jul 2024 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845533;
	bh=5vB6rfS074k8h9NxKGPuRUpIHxHySANWovl75hV6ARg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rnx8kpEK9JIDaxDHJudBcA0pbTOMeDB0ZuXyJYOJouuOP3Nl3kCNW9X5mJBieA+4k
	 QSP6e3hN3/yZ/dM7XMRHRVKW/ugmtouL9wriUBK6BR5naVN+dmLnrrR66dlv2OTeRn
	 tqFks+N0Mned2AzZCWhexR8hwPHqyd6ya6IYCFe2pycWlE0Pw/9v/GLrWnLeYhxc+I
	 SodrOrPvwY3u15H19yBwJcIcapgQl+VHxeXBLvjuJXiIPsanR7xXcvXTL4EkvCMYCV
	 SXB3o3VtmpLIJWFVIaLUkZhaxf0OoRyDWuz1Syg/pc2/QuNbIxaFcxU1CH6sUd2ihi
	 Hd9Hs4ivYcZow==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Kuldeep Singh <kuldeep.singh@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
In-Reply-To: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
Subject: Re: (subset) [PATCH v4 0/3] spi: fsl-dspi: Convert to yaml format
 and use common SPI property
Message-Id: <171984553050.67981.12522537296340689285.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 15:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 24 Jun 2024 14:55:26 -0400, Frank Li wrote:
> Convert fsl-dspi binding to to yaml format.
> Using common SPI property spi-cs-setup-delay-ns and spi-cs-hold-delay-ns.
> Update driver and ls1043 dts file.
> 
> To: Vladimir Oltean <olteanv@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: olteanv@gmail.com
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
      commit: 52e78777b6bfd4bc47448791a99d5f97c82ff81c
[2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
      commit: 94f19d076218a193d170da6d5ab2a87c080cc69c

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


