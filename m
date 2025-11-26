Return-Path: <linux-spi+bounces-11610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D216C8B908
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C4614E1E6A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28787313537;
	Wed, 26 Nov 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDaoxqKI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF22264BB;
	Wed, 26 Nov 2025 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185111; cv=none; b=kYFwXTW7Hjd8oEk7OEyekKjb6vsQSOqQLI/5PHDfG70r78WwF3w91e8LvOmRmgEJcDifFJ3yF9baL5Za0Iju2QhumX3EmvutRzi/kU5OOAazsfE/Y+Lb0h0d76ajDUj99DuJTMZLBwJnmQ1vroo3DmQQv2BEYqZnyNGLxXX2D4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185111; c=relaxed/simple;
	bh=266LmUKXgAPdFDuUqdc5oet/Hk5JYy/stINU9sWH8G0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZutpiDblSkDq2Xh5EFLVBH8TrJ5P6Wz79fJdfDgan1rvBAqGUcFHNO4NCiLttKXGmDqlEqtKa23J3Lze8ECrCfA2lMszApgda1g8Og7M2C+N7XUSmV8DBevMUv2bqZsOgCMV12yBFc8MNJU/wRHMdJJ0SZlDBk9+DhdSMUqgQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDaoxqKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE443C4CEF7;
	Wed, 26 Nov 2025 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764185110;
	bh=266LmUKXgAPdFDuUqdc5oet/Hk5JYy/stINU9sWH8G0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JDaoxqKI2U0FfH3AUI602gp6IoIWBan37ImYqdip5acGzySPQGeRJinOWC9MGqUP2
	 gZT11cEChiZpJlgpFPzAUk27NAOldkFKMW0e/GDORCEGhbrJ/U3VUqNyXIRtZq+XRr
	 maT9zgA4UcoS7RTqKfud30NidNwXjs641WDCeBzcS+FzjDuCbQ0JNRiqz3FH+Vvr5h
	 Q2+1WiPmPAbPEcFBgSx8iUCpmN7GQBHtQyDaBwtnhbSxdlnKTRyCQ0ykCqsxt7SGUF
	 TS3OClZXnsPVbv3tb9oQXKZDjnHT3z0EntIM4tF9IeryinW1pA0y0x7QvRvhNH4tRk
	 9Wf7OuttxSZIg==
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251126131619.136605-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251126131619.136605-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] spi: dt-bindings: renesas,rzv2h-rspi: Document
 RZ/V2N SoC support
Message-Id: <176418510770.120938.4934227807693323677.b4-ty@kernel.org>
Date: Wed, 26 Nov 2025 19:25:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 26 Nov 2025 13:16:19 +0000, Prabhakar wrote:
> Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> compatible with the RSPI implementation found on the RZ/V2H(P) family.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
      commit: 043cc033451530f81d7fe791dcc29874f6a147fd

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


