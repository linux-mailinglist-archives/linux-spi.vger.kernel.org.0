Return-Path: <linux-spi+bounces-4427-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D396479F
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 16:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E88E2816C3
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58E1ABEAF;
	Thu, 29 Aug 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcBVkvKJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351518E750;
	Thu, 29 Aug 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940588; cv=none; b=AWNO9wdcgX/zX3wLvCChtU4TNlz9P0rHUbaeXJsFkwRnIqV6t8hpLZaCADw9OtTyMK+COLgRU2Fz1cHCbytYllxhA3VP01p4855addXk6vqXyjcGxRV5CLkp4x/0H+hUaE0NukTp5jZ/UmOoU21/V3YtY67Qc0MjqB1DwtV1ozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940588; c=relaxed/simple;
	bh=XAKh4AmEybIzoOn0A32CUqjKtnFXlFb4NcEgPPU4VmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BfN7Y5utO2JwssQdh/omonFEH7xOhq3H9PW6TKaOWu/3NKVWR42Neh584O516z3reWyAmxCG9dpim4tMZ4MU6Y8dmx3dzOUL/0KZcSX33vBqmdwgW0ico838CZysQ+O8US63lJQBrbC2wJOSVKRJ7zmUqDbyaT2pFPMDxEQg1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcBVkvKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7697C4CEC1;
	Thu, 29 Aug 2024 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724940587;
	bh=XAKh4AmEybIzoOn0A32CUqjKtnFXlFb4NcEgPPU4VmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AcBVkvKJS7EbhsYdc/NHRJZY8CVDH4iSvH8yqEZDgvGqXVWcwv9rk5yVPsBx8E7RC
	 EcgBq61KFkm1+V0+Ks8M/9iAI8sQwfaOXkDorkQ+hPrZRqKxsSi6XaQuXpfXJfcH3V
	 AN/2GvdNMcO1q79LVokUj7byXeMf/VyCfLU5qgTgBFwiVyh3VSDB9oS1iprWflsKth
	 WB0e0wn0Uh1ElXAlqh3XAFBMXJqR/Lp7EZyFBPfRatDh2xtQe1twHcj81LnC3ZyMTB
	 Dh/fhEq24SuaJ0k7rpi74Hq2oD5Miu1gA9C7nSM38kl3Djw3+2XyLflJbWShfpRPXe
	 KXEm+zaiYH/Kw==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br, 
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240828180057.3167190-2-festevam@gmail.com>
References: <20240828180057.3167190-1-festevam@gmail.com>
 <20240828180057.3167190-2-festevam@gmail.com>
Subject: Re: (subset) [PATCH RESEND v3 2/3] spi: spidev: Add an entry for
 elgin,jg10309-01
Message-Id: <172494058550.260290.10671883260630634920.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 15:09:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 28 Aug 2024 15:00:56 -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
> 
> Add the "elgin,jg10309-01" compatible string.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] spi: spidev: Add an entry for elgin,jg10309-01
      commit: 5f3eee1eef5d0edd23d8ac0974f56283649a1512

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


