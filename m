Return-Path: <linux-spi+bounces-9175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC8B112FC
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B6B1CC4FB1
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0B2EBDF5;
	Thu, 24 Jul 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWBIpQB+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7315B661;
	Thu, 24 Jul 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392095; cv=none; b=BOrUFSwQgUhMXVHHPcLJH71oJucx3KIPSI3SqcSj0QGXzqOU3ykZaG3fRAa/ePB4Q+VXy2Bi97w819uGGefIUFDx4h9AmpDKOWDY9bS233MghOAv9fOUg1llngXa5kIEW79jVrwTSi50DVwSYFuMODy2Y6CKY58fSok2D+nDWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392095; c=relaxed/simple;
	bh=zP2DdL1xyvFlCv0kqOkPf2j+8jsIWjQBQpmTzHlCJOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=maEnuUDEhiA0nvaEei28WSL2HYbeKs+YM4B0WqfuQkHjeTNijuIYXTbk0FN2M43C+qB4uSU/wum3Dx7N+1vz13Fl0AAuN68Sk95h0tX4bHz6BOBpJJZ6vqvjR724EwrOb6i2/ROHOVm1w3WODib1UD5zo3UnQd8N8GE5YleLIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWBIpQB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFEC4CEED;
	Thu, 24 Jul 2025 21:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753392095;
	bh=zP2DdL1xyvFlCv0kqOkPf2j+8jsIWjQBQpmTzHlCJOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lWBIpQB+HvMkPLdKaaZhUjh/jHk9/ugOCKjA70G3i1pTlkvpOicBB0zMpD1sJSV9I
	 q4/gQJ7hFE3JvMdecit2W2oljAPHTJ7JNs7RAWxoNdCv/n5KjexhVzPd9uUNQ0kFKw
	 d/li68Cb44Ohg+7YharoiO1YeXA6Chw7xlNLCHuJbj5oZrCUk5be3H6v0SU+ue31s1
	 aTVkYURhgOYpH9VRFeki3CHlQ86CJKP6FH5vmylhCRAUBe+ecHQbSbXgjANkXW1TP2
	 L6QxGU6DiU/s2rsgoiul9alp7wfYaF0IJd/gf0ovcPaApFfhty0ZosOCEkQjHInmQt
	 9CuQlsrepLCxg==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com>
References: <20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com>
Subject: Re: [PATCH v5 0/3] support for amlogic the new SPI IP
Message-Id: <175339209371.157729.12033130863447409564.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 22:21:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 18 Jul 2025 09:52:15 +0800, Xianwei Zhao wrote:
> Introduced support for the new SPI IP (SPISG). The SPISG is
> a communication-oriented SPI controller from Amlogic,supporting
> three operation modes: PIO, block DMA, and scatter-gather DMA.
> 
> Add the drivers and device tree bindings corresponding to the SPISG.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: Add binding document of Amlogic SPISG controller
      commit: 78d35a20783941c8ba5cf912349728c6e1bee84b
[2/3] spi: Add Amlogic SPISG driver
      commit: cef9991e04aed3305c61c392e880f6e01a0c2ea4
[3/3] MAINTAINERS: Add an entry for Amlogic spi driver
      commit: 0ef2a9779e9decee52a85bc393309b3e068a74a6

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


