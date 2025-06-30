Return-Path: <linux-spi+bounces-8919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D83AEE1C5
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2965B188F8B8
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD7328C00D;
	Mon, 30 Jun 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFqUW1Rz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954561DED4C;
	Mon, 30 Jun 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295585; cv=none; b=uVR/y70IyEEHBIgyines61IRyupOuGwWFNNual8t7+00UgDwbeFPqw83ycN2voxnxT4K/9834Pwq2OUX+TdqEF9tvBuWYv7sHO7O9UDtohv7CggJ2v0sHwKddORi/A5n3aVDuyoks+fNUXrAmkeAtEj7EnPCjOglTxNrz96vI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295585; c=relaxed/simple;
	bh=Wyl3Fr/1Uh5elhfIHOIsoC/yR4Gchg4lC2oiA+dD/0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kccq8jlbzANAj53ZU5/LCJT/APM0rliU6q5GGbyJ4hrhIJq2gx/H6saxkM08RsMbodoTvArY46FDwwDHAReJbLyJSzI2E21JJSzjJVWWoMkckN7OTsx5ZRrZLRR/xTu5DZFaH57vp7xqRhlxyly3H/IoW10QuSlPsW1NpYUlXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFqUW1Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B489DC4CEF0;
	Mon, 30 Jun 2025 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751295585;
	bh=Wyl3Fr/1Uh5elhfIHOIsoC/yR4Gchg4lC2oiA+dD/0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UFqUW1Rz3WJ1Spq44uYLkYdmft264YIK3gOZdCQug6NZ2MCT/zh2Da445XT9Kzscp
	 UOsYqvxK1ejuL6oj6r0bR06AfL94+RmiKTZnCjSIq+RnxbYPliGop5tC4Mw+DXc+vG
	 SfQlqakRlv1jJXshz/XkKkFYNWFpEBvoKzI6s9U5uvdT8uSi4ttRVB0SKDiOTqxd5f
	 kZ6RVq+2+G1cw7R1G43qBEHdozQ2mIulR1Ml2Md+sJuBPPAxWcofrrQHhFeUq+mT9l
	 j02h/71QHrL1bw64ccOmPAiRlfPSChq55IRNvGQc0eWxGcrkE/8Uv4ZZVEIiWZLgKr
	 fYFieowc7FB+g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: unglinuxdriver@microchip.com
In-Reply-To: <20250630073233.7356-1-thangaraj.s@microchip.com>
References: <20250630073233.7356-1-thangaraj.s@microchip.com>
Subject: Re: [PATCH v1 for-next] spi: spi-pci1xxxx: enable concurrent DMA
 read/write across SPI transfers
Message-Id: <175129558329.1416517.3510577981745100807.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 15:59:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 30 Jun 2025 13:02:33 +0530, Thangaraj Samynathan wrote:
> Refactor the pci1xxxx SPI driver to allow overlapping DMA read and
> write operations across SPI transfers. This improves throughput and
> reduces idle time between SPI transactions.
> 
> Transfer sequence:
> - Start with a DMA read to load TX data from host to device buffer.
> - After DMA read completes, trigger the SPI transfer.
> - On SPI completion:
>   - Start DMA write to copy received data from RX buffer to host.
>   - Start the next DMA read to prepare TX data for the following transfer.
> - Begin the next SPI transfer after both DMA write and read complete.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-pci1xxxx: enable concurrent DMA read/write across SPI transfers
      commit: 7e1c28fbf235791cb5046fafdac5bc16fe8e788d

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


