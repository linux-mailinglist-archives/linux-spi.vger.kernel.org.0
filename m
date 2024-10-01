Return-Path: <linux-spi+bounces-5080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E5898C4FC
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F33DB233C4
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F471CBE9D;
	Tue,  1 Oct 2024 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9MVeebM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F441CBE91;
	Tue,  1 Oct 2024 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805718; cv=none; b=aPwWcebYjsRU/WJ8fNC7Qi5D3fy5C38TKj5PFFRFNDaV38fDFDsCraPGXipX5JN6TaLfTls1WyLzFYjnNo0LtehIOeG2nzLBW3iZwe5ulLiaCYuXtbudMQSWEzlZX0tBAULhPh0Om2VS+o3VXBWnIFWiagtkEZ9vlF7ZB6lJ6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805718; c=relaxed/simple;
	bh=yghPaw6VAi7oijCrepYhoJSPo2p/GUhXxRZwPu0/uHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=awfdZwSwO0PHB8dtMZTPe5Bw/JFwPIY9/3uZR3a7aYsFFj+iKeKPxFqbOmWmAZQ+fkMGqXpKx5qbqJy1+8M7y5xQxEsDC1HDkQ8fNZBv+xERN6OycO51mqy+qoAyGfhLrSoSvz4QNxL6rDs1taagJQCcI5qliWJUYiwa/Q4Ad2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9MVeebM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8579CC4CEC6;
	Tue,  1 Oct 2024 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805717;
	bh=yghPaw6VAi7oijCrepYhoJSPo2p/GUhXxRZwPu0/uHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F9MVeebMJaJGXlkCINCVulrxTeqBntptfV/2p5Q363ABWIrneMGe/e5BhBNAexqi1
	 OLTOrOdBkK/Ye77C/RVwPyvI1n8J46DWRcHS6wC76jmaz7EYY1D2hRaQyuG8WLVftR
	 sBFGrCGNIVWs3KJdB3Ixzb1qt41FlFj93XR4o7s4nO1RZ4t2UCI7K17x/9a3s2MCzc
	 EkuvHtKDJhpvBKgG7L742UMkOBT45ZwTiGif2uou9x+nAlS9rTH9d5Y8praqOs4cC/
	 GetvWBzErSNW/lmqtCO/VepdpA9RcQ0fel6YqiDBlxXcazeB2pQx1QgM81dzgDgsyE
	 yopb7cVfMIRIA==
From: Mark Brown <broonie@kernel.org>
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240926090356.105789-1-ada@thorsis.com>
References: <20240926090356.105789-1-ada@thorsis.com>
Subject: Re: [PATCH] spi: atmel-quadspi: Fix wrong register value written
 to MR
Message-Id: <172780571519.2303755.8160975391915590344.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 19:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 26 Sep 2024 11:03:56 +0200, Alexander Dahl wrote:
> aq->mr should go to MR, nothing else.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Fix wrong register value written to MR
      commit: 162d9b5d2308c7e48efbc97d36babbf4d73b2c61

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


