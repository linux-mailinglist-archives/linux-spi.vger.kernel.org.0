Return-Path: <linux-spi+bounces-3898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED79350A7
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66271F225C2
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59F144D22;
	Thu, 18 Jul 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOSlvqrz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1A2F877;
	Thu, 18 Jul 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319940; cv=none; b=B3uXs6jbzXhS1SDZV/0a291VyBufHEBo4SfARAjx1JN1EP/3d7EVZsmvul4csgsh7xoqPQ/CFOgJ04SbyOIW+fs/SM8gtbY3A44LMDYC37jBChOokhBixXh9DFSOaJHzzaEYqzpnia0CoW5rOg8bb78hLB5lgRkVLZvHs1zAyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319940; c=relaxed/simple;
	bh=eAYqluCiv6LpOeEE/Gjs6FAht/2LLqsRLhVkGs8Q4rY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TgiZ7FrQo/KIIM9hWcLz5P3NcFy7mh1Ofr8cn5Z27krI/1UNHf4TxkLWS5m/QQpZBs529VB/akP9tIdT+Y1sQvfQJ6tycRltXajSSQ0RunqUh59OtX7/165OXNPPos5ah1jZJDfxbgxsajPOFOG5zfg3Ah75sfjuY0CXWtq/jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOSlvqrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA19C4AF10;
	Thu, 18 Jul 2024 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721319940;
	bh=eAYqluCiv6LpOeEE/Gjs6FAht/2LLqsRLhVkGs8Q4rY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pOSlvqrzQfLn/3M4AcllF/jMT74KnCxbxNX0McsxiQkH+D0bn71LMZa991bKhAIqL
	 J4JeMJNvtyOORdryJNbeekoMVk+42FhYu6x/Ert8GJhDQdXircn1h9VKOucAfz+j6R
	 EuA6135fS31k9/qJxcRybtlIlr5bc0QUAEnmNvHr+yU0zSln8zS2tHnw8oFvFoqVyz
	 /eqtDStijsgIlKLmYlzC2Rbh1JyQqasP3O456sMskPfPE/rdKNwdoNknNkWRKYHNH5
	 hJu4xLSberQs8/AxJt/1txFloTcLwvKePFfQ35oc5O36ISTdZ4L2U/DVfh7rUvNpjE
	 WlKdKozfyK1GQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20240717-impotence-zippy-254b86593069@spud>
References: <20240717-impotence-zippy-254b86593069@spud>
Subject: Re: (subset) [PATCH v1 0/3] Fix incorrect bh2228fv compatible
Message-Id: <172131993701.119619.18261000113153693411.b4-ty@kernel.org>
Date: Thu, 18 Jul 2024 17:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 17 Jul 2024 10:59:47 +0100, Conor Dooley wrote:
> Maxime made a typo when adding this device to the kernel all the way
> back in 2012, fix the spelling mistake.
> 
> Really this device should not be in trivial-devices.yaml, but I'm
> leaving the creation of a dedicated binding for when I get my hands on a
> device :smiling_imp:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: trivial-devices: fix Rohm BH2228FV compatible string
      commit: 5170dae5591036dba7daa519ea3126169300e275
[2/3] spi: spidev: add correct compatible for Rohm BH2228FV
      commit: fc28d1c1fe3b3e2fbc50834c8f73dda72f6af9fc

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


