Return-Path: <linux-spi+bounces-3220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41598FBD6E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 22:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBF61C2178A
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A44A14B095;
	Tue,  4 Jun 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/ZezrqG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193617C96;
	Tue,  4 Jun 2024 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533516; cv=none; b=paHFcUzSQYWxE6kqqvva+/oqb8hh3jSJCf55D/xFX1HUahlVCw1ABDndQHRm3oajVayjWqeuvDYi1BNxXwL7HptKy0Ka2iIL4asbls4jWKRt3ZYCcF1eECrTgMu3GkcU58L72gM7TbupaN4wAu4PL8Mxv2Yf4Q1GTe7tBHD6/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533516; c=relaxed/simple;
	bh=uGuGYS0fOLnk8vymIBSizVt1io8f4bdbLV9mwuy5R1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T7oKRsvnMFnK6nLw/f8zLaMdezN+Omi3XWdHGmULjXv9rs/Yu4hnlF2n0edDzMq+ak1rOr0XxMzlB8s4/RoqYOCVzCgHq91nYOHxokRl8ph8PkByfy3uf9usQHUDqUWoumtzBv7U8CpFwZ233lACH6i6HpohSWnfqLbmPA16ZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/ZezrqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DE3C2BBFC;
	Tue,  4 Jun 2024 20:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717533515;
	bh=uGuGYS0fOLnk8vymIBSizVt1io8f4bdbLV9mwuy5R1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W/ZezrqG6kCfFIuPQIpnZDncBfp2JUmZHT+5Y/BySoTR0bn3WDuRiosAuLWfWxZC3
	 HLZy5NvGp1uvI1AXRq1lNLymjMmlio8p7iyhLUG0wJu0rtORgnC5G8v1AuIPVoOqKs
	 EC6DP+PAOBkSOYcrhrv16Lbvm7C6G1FY7UwKieIR0nv9y1e/6Vf+LxVj+pvO95klEw
	 DjurA10u1c2LrqlVyUYDxsh8BxB5Gzn9rxnjHXG4ABym5oNyjy/s81btVuEpiO3mQX
	 2DW3ZwWxom70Kg43p+vkrY/UnzoEsCf1x6CPMmx0u4DO9m7ywaA190lvGoyxL5yR9g
	 YlN8MZaZ8ep6w==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240604131704.3227500-1-ckeepax@opensource.cirrus.com>
References: <20240604131704.3227500-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Correct SPI root clock speed
Message-Id: <171753351425.286765.14890944738649844973.b4-ty@kernel.org>
Date: Tue, 04 Jun 2024 21:38:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 04 Jun 2024 14:17:04 +0100, Charles Keepax wrote:
> The root clock is actually 49.152MHz not 40MHz, as it is derived from
> the primary audio clock, update the driver to match. This error can
> cause the actual clock rate to be higher than the requested clock rate
> on the SPI bus.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Correct SPI root clock speed
      commit: 4eecb644b8b82f5279a348f6ebe77e3d6e5b1b05

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


