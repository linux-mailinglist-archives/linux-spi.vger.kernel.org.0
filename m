Return-Path: <linux-spi+bounces-6269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94AA077F6
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 14:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D2116549D
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA2219E99;
	Thu,  9 Jan 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/qMnFYj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302921A436;
	Thu,  9 Jan 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430043; cv=none; b=on+mtxVFVqQV++X8imOyc6HbgHOqdti0s4C+G8wtpZXZ4M7B/cq+qJZ60oeSB3TcMYo21dJJcetd01jqf3f6TJE/dARLRilXSGY3c859K2892MPzv9KHJgnsV8PryuB8iD3UqKVtsfpdKJbwqQ9JhsZ9ZOxSi0fZImHDgMNCcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430043; c=relaxed/simple;
	bh=XDV4VXdhkew3tGRqYcWfVlginLmoZkPgCgaDE/rnU5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XiW/I+EadpPgqLXrP/2oPdBcxkDIEFSnEifQ8xptBZT7/eEA7N++mq7jz/MX+qIf4C4kO/FwifnZjmOi4TLJjT7DTVA9BRE3YUfmG5xWpJMZH+y3VeEqijyAUp0IJaAjiT74TlgVIG/516Z5+oHRhqQlIONK8QrwwS2NMZBkqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/qMnFYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D28C4CED3;
	Thu,  9 Jan 2025 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736430041;
	bh=XDV4VXdhkew3tGRqYcWfVlginLmoZkPgCgaDE/rnU5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u/qMnFYjyj970GmqfqYIQfOHNDPD0jm0bzoDwu5n/pSrfokluFy0HPnR2opaq28rW
	 rh5piGP1hR/m08QeCeTHMh3QGsw7GFbFVAOpK3r2gPkJn0gB/B7azDFMFORQ0f7LIe
	 OKdZElpTc2ZpRjQCyjx0kKJMV8OQmHXup0X1UpTKjBwvnDorKhGzflMQ8C3bHtAv7p
	 b6Bq3P0+YsubwfpU+Y/FMVFGS2mCUN2IAUE0sfhdFFXhm/BsHO5F5H30qLD8kDq/ug
	 s9KYyWjMTX55w47KMhw26SUH7CnMHswkd6z/qG+ZIhvCZjm7OIxXxbMzzOrEVhz1Xn
	 t5TqLl12fk5Xw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Alexander Dahl <ada@thorsis.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250109094843.36014-1-ada@thorsis.com>
References: <20250109094843.36014-1-ada@thorsis.com>
Subject: Re: [PATCH] spi: atmel-quadspi: Update to current device naming
 terminology
Message-Id: <173643003976.53058.4013563877112652106.b4-ty@kernel.org>
Date: Thu, 09 Jan 2025 13:40:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 09 Jan 2025 10:48:43 +0100, Alexander Dahl wrote:
> For v6.9 the spi subsystem changed the terminology to host and target
> devices, see commit 99769a52464d ("spi: Update the "master/slave"
> terminology in documentation") for reference.  Support for SAMA7G5 was
> forward ported recently from an old vendor branch before that
> terminology change, so naming for the new struct member is adapted to
> follow the current scheme.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Update to current device naming terminology
      commit: 5e56618e1593a9eb9d72dc9433ac7a02a6c48c8f

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


