Return-Path: <linux-spi+bounces-9954-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA4B4ACC5
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 13:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9D914E2B55
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC41E2EE5FE;
	Tue,  9 Sep 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCpS4aJs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB41F30A9;
	Tue,  9 Sep 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418596; cv=none; b=MfYMCAC8EXPZ/2MfUi3nQX0Le8+hoDDNzkbSjJe6/DnABaon81Lw0e6FKQR8ehIPTo5wDrDnu+wV7WfZVgBHxHIblAS3saKmRpt6ZNGzvjRys955SyKdwOjBgy1rslkBu+pAdTXuvAQApPpd7OmILfwzZe5F+2czUjgWIlTUC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418596; c=relaxed/simple;
	bh=LI39LAQ8Ktx5D3nswcyvz1qCla+Io/CVwyEtyAFHRXo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ulgXefjVr6Xwr8lMZNuV+T9hqSj8OoXx8Bfb+3QXETzJZMFYXu4nxH4ld6CNopaNsweabQonSISrzfv/YxITRgRLa+yRHa7RIeUbU98QTUUmSZAvHlCl3KrvAG04qneMiWQMhmt2zC03ikOGBtPZmNS6bZLHacWR0J/0ARJv4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCpS4aJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E6C4CEF7;
	Tue,  9 Sep 2025 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757418596;
	bh=LI39LAQ8Ktx5D3nswcyvz1qCla+Io/CVwyEtyAFHRXo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JCpS4aJsIXfsqn5K5LoVLB9V9NNur1ySxm3n1yn14KwZTBDaugJ/HVfPk8eUQV84+
	 do/7U/vksqDGR95TpfFU/HlH6bU4ugS7D7yIl7Pss0Q4SLdLUSAFLl4qapqxdzPhjD
	 nz+rY/z1Sd+DARjDCyr9gXZSE95wMfYrs928joZxDsudRDYWkSvUqdQQgu36nU8+Ky
	 swJx1QZkYj2GDTXH3aehVfN6r1bjb7J+mqQZIPpgYX4xK9dXacQn8rjhGO/T9WWTCz
	 SBo2+9DGs3kJvvdHIyF7iLS/Z95X2P6Z1vbnG31UzCv0vWg+pzwYtd9mLtuTIo+1b+
	 YGaamxkN7aM/w==
From: Mark Brown <broonie@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
References: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] spi: s3c64xx: Drop S3C2443
Message-Id: <175741859364.56807.5691660197683706591.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 12:49:53 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-94e36

On Sat, 30 Aug 2025 15:26:06 +0200, Krzysztof Kozlowski wrote:
> Samsung S3C24xx family of SoCs was removed the Linux kernel in the
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
> 2023.  There are no in-kernel users of remaining S3C24xx compatibles or
> platform data ID.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: s3c64xx: Drop S3C2443
      commit: 6248c95eef941bcf987bdd7c62f5e47275b0dbba
[2/2] spi: dt-bindings: samsung: Drop S3C2443
      commit: 2c625f0fe2db4e6a58877ce2318df3aa312eb791

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


