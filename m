Return-Path: <linux-spi+bounces-8315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B1AC5342
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3057A6E6C
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52727FD4C;
	Tue, 27 May 2025 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS/eYLBi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816C27F756;
	Tue, 27 May 2025 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364296; cv=none; b=MYnJsX097Cq6FysLUUFbXR2jaXVZWxes1/bHaOPyp3A3DueMZMzQ48cP+jSaaXzG0V/638jOjlSJejbaMw5xKqZxi1GYw6foRJy/ZoFrUc3yImELwL7bHaopDvY0DiiHPxDSIxhBIo3PZ9HpTbI/8vG8/SCd7Js5jUXMNkTIars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364296; c=relaxed/simple;
	bh=/jj76ajhqfDNRJG/rDNhF9m8qFgvPrdlQW38Y/d1ho4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8Pi95fOc/xCjr5d71UZmwo0i9UublQScuwt7Ejgi2QbjdMjt9nccYiGpuGQujn6WsoEuIjXTDgAT3c6ZaSujFqcIj3q4TrwTFBQOEaJ5tlAPKaktHI2XfMgnMWVpBznuqpcpX9HN/IKixasT9pYPrvvU/NjLkTq/j9OM5Qf2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS/eYLBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C984C4CEE9;
	Tue, 27 May 2025 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748364295;
	bh=/jj76ajhqfDNRJG/rDNhF9m8qFgvPrdlQW38Y/d1ho4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XS/eYLBiG9Kj5HpjFD9Mdod1eCkAnuyluBZpxjtfHIKHRNwSTjUQv56z9qDudfB59
	 1cINU97WXtz+KvLbUjWVj4hHT7dR15FygrzgoCfyk3a8KnBDFOJxPcd152vBM/3MiB
	 P+rwdLZgta1AaUnaY4nZ4gHhUMrYS0qtnMDKjl9HplWuDUIaDVo1+iANSa0mTjU6BG
	 cw++bTqqwpFlE5AgMf7L2Rt2+U3bYy/SHXBvvlEXXlIgezaHbgNh/q1jVJ+0uMsCXX
	 pi7FwG2lpb/5J7ByP/ekB4iysZxdExFvgOre+5S6Hah5G2Qu7Ykgxi+PAInmqoxjwJ
	 0x/X91F06o55A==
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
In-Reply-To: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
References: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] spi: sophgo: Add SPI NOR controller
 for SG2042
Message-Id: <174836429126.109342.7717810791199744277.b4-ty@kernel.org>
Date: Tue, 27 May 2025 17:44:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Sun, 25 May 2025 22:58:40 +0800, Zixian Zeng wrote:
> Add support SPI NOR flash memory controller for SG2042, using upstreamed
> SG2044 SPI NOR driver.
> 
> Tested on SG2042 Pioneer Box, read, write operations.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042
      commit: 8450f1e0d3d0e0b200eb14d14dfb8ef5ddb9bda9

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


