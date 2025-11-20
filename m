Return-Path: <linux-spi+bounces-11379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971CC73453
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6C074E8FDB
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B3630AAC7;
	Thu, 20 Nov 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8x5dMDI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E72F6903;
	Thu, 20 Nov 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631636; cv=none; b=n7eegzwoJ7f+pEk2TX1FKS2DMRw4G+OjAgZIazIakXTMKgEo+jyemt5vBlIjPqR6nns8K3bkIZcDdI/sKOZZ7/ABGVF5bXkB7dK+ePwL7vOmoPbDDO6bPcxbGvHprsgc7aT99ftUqzq+rLXo9vyU9VzN4yx7nZKzzcQGK1jCFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631636; c=relaxed/simple;
	bh=d9gi6IAhGMrPheyNCbI0JonIbRfzHt0QW40OJqiT97M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HTFhqxFuqM/e0X4gTLBzTH82pGMrjoNNPt0FFCKp1FKX/iSUrWJawPRBKleTF+1UAFntUiRLmcv5T0/zMoz0jsMnsNaIx073aZx0pxcuxQ4/goEfwSMBLyJQEzYfCfJk+1HaJ9lDtf9rG5nRuNPpAfeMQKE0Aqptu/VzhuUNP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8x5dMDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22B0C4CEF1;
	Thu, 20 Nov 2025 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763631636;
	bh=d9gi6IAhGMrPheyNCbI0JonIbRfzHt0QW40OJqiT97M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=D8x5dMDI9qJnYU21qSlLei8gHq6Zp6XE3Ht93IoCv3k7PJAFzVClSKbtAgejBTKQ9
	 Mlfkw1A7ZzKb+RXGRyRjn44BAeRKBXZkSIw6dDMVgPLcb4V86Y6I7sMSO17zYx81q8
	 Lb5p2niv4ymriPG4Rh4qDWJUCqR3AXLPVdGP+enV5nTKiKhcvUEMsjwNR5IxksI+iI
	 pOuGw0lIbm+/s4GAY7s5IaveZtqiSuhHzrVxN0SfktEXbcH3diGb4+WggKOSWAetV5
	 hJZhfgmu6eLjeVPX9gEw+PGJqSjehjYiliL4+9+a0TF+R5/jlR0BSczu8Z2OYlYOdh
	 sQ3lludhl8vrw==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, andrew@codeconstruct.com.au, clg@kaod.org, clg@redhat.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, BMC-SW@aspeedtech.com, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com>
References: <20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v2 0/4] spi: aspeed: Add AST2700 SoC support and Quad
 SPI handling update
Message-Id: <176363163164.560683.4991477364624751148.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 09:40:31 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Fri, 14 Nov 2025 18:10:38 +0800, Chin-Ting Kuo wrote:
> This series adds AST2700 support to the ASPEED FMC/SPI driver and
> bindings, introduces 64-bit address compatibility, and improves
> Quad SPI page programming behavior. It also implements AST2700-specific
> segment logic, where range adjustment is not required because the
> AST2700 SPI hardware controller already fixes decoding issues on
> the existing platforms and adopts an updated scheme.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] dt-bindings: spi: aspeed,ast2600-fmc: Add AST2700 SoC support
      commit: be6671d3908e97a2128f5327610a1dcb4d420cfa
[2/4] spi: aspeed: Enable Quad SPI mode for page program
      commit: 716d0a0a2ab00c601120c19bb357f4373f4722d1
[3/4] spi: aspeed: Use phys_addr_t for bus addresses to support 64-bit platforms
      commit: 508f3d3b688e1650ed383fe208b323aa6c164420
[4/4] spi: aspeed: Add support for the AST2700 SPI controller
      commit: 9e510e677090bb794b46348b10e1c8038286e00a

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


