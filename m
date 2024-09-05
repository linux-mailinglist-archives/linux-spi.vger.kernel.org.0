Return-Path: <linux-spi+bounces-4695-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BD96E57A
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 00:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20ABB237BA
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 22:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957DA198838;
	Thu,  5 Sep 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXIoT1dy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB78F54;
	Thu,  5 Sep 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573695; cv=none; b=D5m+JLB9OCIohM8w7OeEFl46GigW5ZDm9YvooTiWOs4MrGrqeWkAll7JpLew/1sorcs+Z6RuEpsQ6gBnT4MYaTgFAAwjIZ+Bvq5ubaMRti1feEB1skZymdKdtqtBjGR8NDCCUiDCdPwJjKgtgOlo01eYJ2fFP9GsX9r3TYo/+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573695; c=relaxed/simple;
	bh=QxP9xLVnfuFVTjV9XRab4YxdfdPc6qkRtPiT/xMI+FY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=urOXbV/sm1lticeFeYTNm6p4NDIqDcikkZX2s8JYFc90Vi7dJ6G/2PAF4Q6MNMtjN2LeZxhjvDaMAMCkEPGNE3Twrr8u7WJ1/miDlGUWiBWSE/ZtBfWNmgHsk4XZXvHfnj3B9wyWVzF6qFcUmt2YOzeFKsVW+sk5IddCidQVb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXIoT1dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7040DC4CEC7;
	Thu,  5 Sep 2024 22:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725573695;
	bh=QxP9xLVnfuFVTjV9XRab4YxdfdPc6qkRtPiT/xMI+FY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aXIoT1dyI9HJi1d0DX5egqlzi4fS7LTmqGrjzKaHcJhjTTLrTr3k523VW/HXW1tvI
	 ydHZzVN0LFmfOzI2zI5WUUVkk93XN9rM0ILBc8qvkv/fpyBNs1zU2lu4HbOBqUrYSH
	 OtDvYJyrKViBrFqO1l/8x1WhQFTdHCiSObJM0PjWocsmSgd5/K7yTwdca8mlPEDnC6
	 gsLLv4DUHHag1XEZgCcLet47dBgHAfbAlus544AsH+tZaoT5DMUWnhAwGI/ud3Gm1U
	 thski4437nIcvXuh638vsnd1b5nIZjrXSg0udbyrLBiav1pYZ+DwCr/e9vCoFKv/Kh
	 Y3kqTwyNiuKnA==
From: Mark Brown <broonie@kernel.org>
To: han.xu@nxp.com, yogeshgaur.83@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, haibo.chen@nxp.com
Cc: kernel@pengutronix.de, festevam@gmail.com, singh.kuldeep87k@gmail.com, 
 hs@denx.de, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com, stable@kernel.org
In-Reply-To: <20240905094338.1986871-1-haibo.chen@nxp.com>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
Subject: Re: (subset) [PATCH v3 0/4] fix the flexspi error on imx8ulp
Message-Id: <172557369118.138179.1237587939116968087.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 23:01:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 17:43:34 +0800, haibo.chen@nxp.com wrote:
> The flexspi on imx8ulp only has 16 LUTs, different with others
> which has 32 LUTs. So currently flexspi driver will write the
> wrong register when fill LUT.
> 
> This patch set add a new compatible string for imx8ulp to
> distinguish the LUT number.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] dt-bindings: spi: nxp-fspi: add imx8ulp support
      commit: 12736adc43b7cd5cb83f274f8f37b0f89d107c97
[2/4] spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
      commit: 190b7e2efb1ed8435fc7431d9c7a2447d05d5066
[3/4] spi: fspi: add support for imx8ulp
      commit: 9228956a620553d7fd17f703a37a26c91e4d92ab

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


