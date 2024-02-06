Return-Path: <linux-spi+bounces-1090-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38A84B4B5
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 13:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00851F29195
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4ED135407;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIMVt54X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396F1353ED
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221359; cv=none; b=UeCk6WB8hBi8VfiE0lfjuIzc5c1+Y7Evg6Q+ExHH1VGbsA4phuUfMgTW7eCAGOv9Vxk55BmyLK4DdUOT5oieQo838/PchmQeiZ8csKwZWPctGDnZLnU5osLcPm8wcOFbP1k5Vlvs9Z+afOszeI5jpm/eGR0wzUdcNXLkI3HJ/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221359; c=relaxed/simple;
	bh=pPf6zjaw0YWgrtDcTtvZK7on5ZzqnlKWLo8vYaA+ARw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZJoTe8mzkNixWC+6RNgnLS2U4Lmy0Bcu/N/jTvjnFi+QUztw6ywIbFMbUUHzy2yygxRZ/FyJ2+gn4TJpTWwL0QSYHQnaUHFWVRjMTtemQYwkZroxPDX2zKDK3xILd6+LcY0VNu/kS0yu8PWFrLV0SNthifjroPgIu2+mZFI8KcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIMVt54X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0196C433C7;
	Tue,  6 Feb 2024 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221359;
	bh=pPf6zjaw0YWgrtDcTtvZK7on5ZzqnlKWLo8vYaA+ARw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZIMVt54XGHwiMU68KbTAlOJMOmh/RYRANZ0l8J50GXFWUrJA34B/t/A3e/Q+w+eeu
	 YmDioFUEZSWZ7cGAehoLlZZt7jZ7h+gRFKmaHBAqhMQrsxRRpwcf9Bv+6b1J4CGdiY
	 wUuOnHHacs5bPJhsypJIxGq58KlCSYa0hxDX41FesmXJEFid9UVpxZQuR1n7gM8+rx
	 MwwcOhCZbjnvi39U7mg9V5jdUvZwQ3WFcpUW4aiPkmERCZ56bDtYkmssLp1EzwDDJW
	 BZ6ZCXcZmQwSvxJvjQFslfN8UGOJrKqHyKFI0wdPCOstdq98t7KCHYyLIuf5897GEC
	 TPTWg8l52s/nA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Luis de Arquer <ldearquer@gmail.com>
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 Robin Murphy <robin.murphy@arm.com>, luis.dearquer@inertim.com
In-Reply-To: <d0a0c4b94f933f7f43973c34765214303ee82b77.camel@gmail.com>
References: <d0a0c4b94f933f7f43973c34765214303ee82b77.camel@gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-rockchip: Fix out of bounds array access
Message-Id: <170722135749.992289.15697794972690614056.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:17 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 26 Jan 2024 20:46:22 +0100, Luis de Arquer wrote:
> Since spi-rockchip enables use_gpio_descriptors and the
> SPI_CONTROLLER_GPIO_SS flag, the spi subsytem may call set_cs()
> for spi devices with indexes above ROCKCHIP_SPI_MAX_CS_NUM
> 
> Remove array cs_asserted[] which held a shadow copy of the state
> of the chip select lines with the only purpose of optimizing out
> rewriting a chip select line to the current state (no-op)
> This case is already handled by spi.c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-rockchip: Fix out of bounds array access
      commit: 5c018e378f916b56503bba65cbdec66ad16f20b7

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


