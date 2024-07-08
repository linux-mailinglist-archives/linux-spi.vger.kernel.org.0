Return-Path: <linux-spi+bounces-3785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E96F92A48F
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F63DB228F5
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B313DDD2;
	Mon,  8 Jul 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8QJeaPF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982781D54A;
	Mon,  8 Jul 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448709; cv=none; b=hq412v173ZYJN6NJnHWnfAQwAbjw29YpMPT4Yvn5+ELF6DJ2NEhqJZlPJqhvtjjFZD81nDlCDiNV52KKhbhGRGSOhZdIB6YLw9FX86g52X/31WIxDwIhOjD+sRU1ClNnZ5IH/ItKNWrsG4cUBoYNtgrNJGkve2vmaJXuKWbEQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448709; c=relaxed/simple;
	bh=BqzIe6x1w65aK8oSp5pIAijyJ34V5xwuty8/FfrrAyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gpdVdfs+YQbo00ciugoASc7NUMMM3TJClX8WZmnz98B4bxwv7GFGdOiG8LMfVOYtYYTUaqFtdSQlrH9/ZTTq7ynP7Vt5W01OHDU/qkOtk6DBZRxLbYERBmhKptsmSXsMnQdBf2J3QyEn4JbJ8CrR7Qms57n/5dR8ZiZs54ZssKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8QJeaPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAC8C116B1;
	Mon,  8 Jul 2024 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720448709;
	bh=BqzIe6x1w65aK8oSp5pIAijyJ34V5xwuty8/FfrrAyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o8QJeaPFiV+0wuK+6XDsI3bvowA13RhKd5pn8hgeoQ/qbSCd98YNUMtX4MZ2jOGK2
	 8NH3exPgLdtrnnpLBOerkOwwISsISJx0HKCWm3L9x6Cp49I1QbXDmQVPfK4u+GiSHt
	 kKhahUHEJQ/HmlEJjWuz+uwZsl/585QDLFlvBgJmB7qY3oAY8DI1S8M1Zrhqqe49BQ
	 +cZo6IYzUKiiOu/yR5e08LQwe026/sNMPEM36ZZJlBxmasMe7GY9KW7h38N/II00Bu
	 kIRvag5UwlkTPIjRsAemCW7ycFiQr8XdCwTeCc0+2bqc65CkinLpSK/GY5CzhVDLoX
	 QbaET9NZXGVIg==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240703165931.2325807-1-Frank.Li@nxp.com>
References: <20240703165931.2325807-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: fsl-dspi: add dmas and
 dma-names properties
Message-Id: <172044870740.62411.13873431192116289183.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 15:25:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 03 Jul 2024 12:59:30 -0400, Frank Li wrote:
> Add dmas and dma-names properties because dspi support dma transfer.
> Fix below warnings:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: spi@2120000: Unevaluated properties are not allowed ('dma-names', 'dmas', 'little-endian' were unexpected)
>         from schema $id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties
      commit: 2de9ae2044c4f6490dbbfb8d93fe6b8cc60c91d1
[2/2] spi: dt-bindings: fsl-dspi: add compatible string 'fsl,lx2160a-dspi'
      commit: 0f17a12787573dda66d2528fff27cd7362b34bfd

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


