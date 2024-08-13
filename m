Return-Path: <linux-spi+bounces-4180-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D12950D11
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 21:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8183428607F
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABF1A3BD6;
	Tue, 13 Aug 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjT1yhEW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C681A254F;
	Tue, 13 Aug 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576931; cv=none; b=V6B4Z8NxfnloqLGuZnNMPmkRM3xdPhtEc6IRi0LIwQqWlGLQkxfa+ZRrB70uK3RxomYL4Ob4+SVRtEIyLj7FM7x70S6aLmL9Bk1sdHVH33vHzhWpFCb2NqAilwj0jDheWZ4khytyKDcC/ynk61OtiKdfubfPnzA/XYPgQJy4fT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576931; c=relaxed/simple;
	bh=lY0lhb7BmsOpLYdU0VWU9WKDBRrqBJFGFjFhgXBLCKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WFgCYpeJhyngSugGY5FnE95lcmVFncxVZRs2P1CRpcO6SBp2maoTnw5xmDQjVgaagkAHwzMJVmjfS2d7frOp0kKB930bsy1uXox6r4on2qkNLvkRgaGkTJhIEFZzI9TnuyVwdoSXSIAND04U2qiiRF1XCmnC8zaj7xI2ZCYaA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjT1yhEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13576C32782;
	Tue, 13 Aug 2024 19:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723576930;
	bh=lY0lhb7BmsOpLYdU0VWU9WKDBRrqBJFGFjFhgXBLCKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LjT1yhEWOHKC3GgbzCgJn8mQU4nqby5KyyHdpWeBpk9IjPPKsw9Q3yhsuqYSjcbXV
	 g9kMh7aK2FQ5DgC+6adeOLvQhE6DK6ZT7mA0qxYEg+EM5/HCAIi/cQD9Yi/eoB6Tbj
	 DcwcOIgTUypMsKq5HbU7rzXVrdeJlFAsH79d64xO/PNO41eQBirTyQDrN0N0TvGQGY
	 xRxSC9ILb53lCQmfY8zdQjZ3zNqXea4uFk+FtwVTMuXIhx5Nynl2jxSlMmbyF2IFq/
	 awD8N40SLh2BSAJuni2j2L9B0hdDDfa/Y7sAFQcaZ6VrHyK1KggEWftHE+Tl3pu+FE
	 LgYX7zr1pSMbw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240813154444.3886690-1-Frank.Li@nxp.com>
References: <20240813154444.3886690-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] spi: dt-bindings: convert spi-sc18is602.txt to
 yaml format
Message-Id: <172357692761.130711.16237572865002261472.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 20:22:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 13 Aug 2024 11:44:43 -0400, Frank Li wrote:
> Convert binding doc spi-sc18is602.txt (I2C to SPI bridge) to yaml.
> 
> Additional change:
> - ref spi-controller.yaml
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
> /soc/i2c@2000000/i2c-mux@77/i2c@7/i2c-mux@75/i2c@0/spi@28: failed to match any schema with compatible: ['nxp,sc18is602b']
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: convert spi-sc18is602.txt to yaml format
      commit: 1c4d834e4e81637995b079fdb64fad4c32af15c8

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


