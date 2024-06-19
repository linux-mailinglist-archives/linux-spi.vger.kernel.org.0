Return-Path: <linux-spi+bounces-3462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0090EB73
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D201C210FE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3E143865;
	Wed, 19 Jun 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCjG6aYr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B1FC1F;
	Wed, 19 Jun 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801448; cv=none; b=eP/Zh2Q9cbwU68py45inGRrw4lzXM2TXivEE2NgVrhHfsQTvMdIf0QbShxUvwIIrvdksYrzBTweMcfDKQlkPZmKq7EsWoKqktCpQ1d9yfMjKu39h3ih/bGoV9IgO+vHWt3fPjHMG0w9xPg8W4KRQiPpx1wZePscq7eXG5hGv0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801448; c=relaxed/simple;
	bh=MKPk/xGcsJ3mkq4leddfFyEcbWWZuDqiYmtRl4qAla0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bHNNG4g7KqpA2ioqd5cRftbOROUva2QEui5j5hjFeuYcCf2RwH5Qb9NcW4mPLLvG3tqML3J6/uSgJrlaH2i08k2YuGp22u4XA18wHwO3HcTWvedjSV6uhLfQjckFZFdkQgxkC0ZJbWxAxfLGJIOgzpCBSZfV8pW0Dvc4pfis9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCjG6aYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAEBC32786;
	Wed, 19 Jun 2024 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718801448;
	bh=MKPk/xGcsJ3mkq4leddfFyEcbWWZuDqiYmtRl4qAla0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FCjG6aYrVO1Gzy26UZkn4XkbRaHhGbrSdq0QKhnT7G0X1k/tJOH7nSLWFZcYcjjds
	 PCBM/ZgxUmclO83HXWNZ32CdKscjV/0JrhuJpxNs5nx8qNGV0s7GhUjLSasmm6UZjJ
	 7J7O57r2dsXWxy1BQPQX4W4Kum3TwPSapqNDl5qDmkOv0zFmw0JOGTCWBEE32VX4EU
	 kIixfIL2N+oHUKwqLl7V7OFYXLxgjqZdNbScnMq22vwc9x9Z+Vyih/Fadvx+wZBy9r
	 RzPbBzKEqOv1oZiRny3D80vDhxs1B48KSNAox59JK8eQS/jOYUGAbdoUGk4FloVHez
	 mMzv2N2ULqxvA==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
References: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 1/3] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-Id: <171880144676.113265.5971230343895935810.b4-ty@kernel.org>
Date: Wed, 19 Jun 2024 13:50:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 11 Jun 2024 14:25:54 +0100, Charles Keepax wrote:
> Refactor accessing the SDCA extension properties to make it easier to
> access multiple properties to assist with future features. Return the
> node itself and allow the caller to read the actual properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: cs42l43: Refactor accessing the SDCA extension properties
      commit: 6914ee9cd1b0c91bd2fb4dbe204947c3c31259e1
[2/3] spi: cs42l43: Add speaker id support to the bridge configuration
      (no commit info)

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


