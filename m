Return-Path: <linux-spi+bounces-9997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EADBB53FB3
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 03:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8540F1B26E8A
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 01:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17A12F5A5;
	Fri, 12 Sep 2025 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBmc2bmO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A40168BD;
	Fri, 12 Sep 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639490; cv=none; b=jNSZODbg39EgMyDXWTjIH7P7luE4mT5ySUocb2rPtWC7ogQEZIEaxHrL2f+RIqc7zb3cKgUqunoGNmEgGgKchGB5XRgcPbCm2jf5M0Q5jlPFGeVBSbDM4jwosFEAnXnmGhWK5MM50yMw0ZtXa87yIiQtR7li8xP8GD8o1CmaQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639490; c=relaxed/simple;
	bh=ztRk4wm82f1OoWN0gxCnU/O9HPW2W6wBaaArWkzZyEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iICkWA356pcT6MrTwNpJhqN5k4dJyUCxC2CNu6pbqvN1OiayuTVZxeX9mtx+8F7UYi9jaNLetgX0BHDIH4+PeV3haoMr1jIk6/njJYBwqYiVTzAWSOHs+Yq10d5zVkCjmcQfbZRPweXePdRiMjVaBjcVDLCn8iPfJqFDBG33f/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBmc2bmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F6C4CEF1;
	Fri, 12 Sep 2025 01:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757639488;
	bh=ztRk4wm82f1OoWN0gxCnU/O9HPW2W6wBaaArWkzZyEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sBmc2bmOcN/lbu02VIXdF212EPX7LQ/9ELqoFHlcq4JIiD9ZvNGNNFQ/VAv3VLQtP
	 0LjGgd8bGNS6kGn5i49YcNa5kcH/biFGUfOCKPZTtcUErRNkB7obgBWnHmATIKYGS8
	 YXeoWsFCd1zg+ZYZke4QgTCAhfdsoH6MmtA2tG+suUkoIm0KOZlVnSS9oM4CE0y1Ir
	 Zb96dZBZ5H9HR5TFtx9ehgt2/zbHkvjYo1M05GI6KlEg0BewOqozLVpLzc1yHJDyos
	 BdrEIH+vDi7bo51OUWdJPUooT+E2GcjlisdnZC95uZaVwQgOsaLsVYxz7PxN7Ibjom
	 d7t62W7sc21vw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20250909-spifc-v5-0-962bc147d17f@amlogic.com>
References: <20250909-spifc-v5-0-962bc147d17f@amlogic.com>
Subject: Re: [PATCH v5 0/3] support for Amlogic SPI Flash Controller IP
Message-Id: <175763948630.238908.13896906927374897926.b4-ty@kernel.org>
Date: Fri, 12 Sep 2025 02:11:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 09 Sep 2025 13:13:24 +0800, Xianwei Zhao wrote:
> This Flash Controller is derived by adding an SPI path to the original
> raw NAND controller. This controller supports two modes: raw mode and
> SPI mode. The raw mode has already been implemented in the community
> (drivers/mtd/nand/raw/meson_nand.c).
> This submission supports the SPI mode.
> 
> Add the drivers and bindings corresponding to the SPI Flash Controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: add Amlogic A113L2 SFC
      commit: 0467d6c99d1c64210ee8c9621cd63b12301cab2e
[2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
      commit: 4670db6f32e9379f5ab6c9bb2a6787cd9b9230a9
[3/3] MAINTAINERS: Add an entry for Amlogic spifc driver
      commit: 6a129b2ca5c533aec89fbeb58470811cc4102642

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


