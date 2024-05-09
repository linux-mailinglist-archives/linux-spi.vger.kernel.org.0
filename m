Return-Path: <linux-spi+bounces-2799-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29838C0B92
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 08:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DCC284230
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837D2F4A;
	Thu,  9 May 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNHwNiF7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FB624;
	Thu,  9 May 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236629; cv=none; b=QH66L3WUMlKHR0g1dXUZSZU/R2rYS3qLkw2V+bYqZEzveY/GDRgyY1f/nmqvQ5lERIPVaF0aWOBbcqWtld8EyVGyj33BmN/5KzCtaGFyqDWzW1ip/SEC1abDjlbIJxZyUu4mAAZMwwi2+Dxxf1NQSbSB0Uz/DDuguZOUhNba2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236629; c=relaxed/simple;
	bh=+48SMYbY3QawlNScqDNE5l+1qmQ5Z0dWAx7/rzpP3QE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iQQ4Cu1zIcfvlJzqNEhc6p/kmPsE3QJqal/huOZl/4MDMVD6SDQrNR3WrX/AET+AUsFH4FUgOCew2L5dRG0XmhDH5H5YHxQeBo7BDB7bniH20ByhcJ1kDpl4OUyjpSREwKKfbkWnAa7ilhrJltbpWp6zCY1XlNeOlJAU44JGEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNHwNiF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF62C116B1;
	Thu,  9 May 2024 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715236629;
	bh=+48SMYbY3QawlNScqDNE5l+1qmQ5Z0dWAx7/rzpP3QE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sNHwNiF7qSgI9EaIdcjGwcotIrVToB+h7NUGWQriJFIQXuONFhJQbYrEvBCpIy1/d
	 LRGJxaPWz2pXMVEH+oZS5IP91yrMOSz1djkc1Je8H2DfN21C20ic2tR9ZDfbzKnUq2
	 OBWR63KrlaJt12e4VRLM+bYqqwqqyy2w5Z9NId2Z4/cywGzMoeTA4ab/I/N5FXRs1b
	 dxR1t9V88OUoj3X0yhdnXbAVjvP96Ge/U9tJ9dxEA16agsJNKyPWgTbgXB43Nv5tFn
	 rbcYnsbkZD8tN8H11srgB5jopHjxTIMHbECL5v2FDlKY6dXBYOni6e3LG1TCqNTfnQ
	 RA/eIDbu/8lRQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240508-fox-unpiloted-b97e1535627b@spud>
References: <20240508-fox-unpiloted-b97e1535627b@spud>
Subject: Re: [PATCH v1] spi: microchip-core-qspi: fix setting spi bus clock
 rate
Message-Id: <171523662766.2030325.5589313586989726804.b4-ty@kernel.org>
Date: Thu, 09 May 2024 08:37:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 08 May 2024 16:46:51 +0100, Conor Dooley wrote:
> Before ORing the new clock rate with the control register value read
> from the hardware, the existing clock rate needs to be masked off as
> otherwise the existing value will interfere with the new one.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core-qspi: fix setting spi bus clock rate
      commit: ef13561d2b163ac0ae6befa53bca58a26dc3320b

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


