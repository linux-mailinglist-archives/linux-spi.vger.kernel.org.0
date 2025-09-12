Return-Path: <linux-spi+bounces-9998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212FB53FB6
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 03:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD33A0627E
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 01:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D11624C0;
	Fri, 12 Sep 2025 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nddgyKYI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE6126C03;
	Fri, 12 Sep 2025 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639491; cv=none; b=FRD9jVR7zVeg3cgP1SgE0wIGZpebkjGmfCSGwtcR+7NSSfhR59x/je9/gW0P//IeTc7cOrTeKAKPmdkcphivpCkAbe+Q9rz4vQPENYKLTWB7n0M0hZ5RQomXGR+2+SripruII0rywvT2rBenbdPV4K8tknB9KysZS0VdA6O94uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639491; c=relaxed/simple;
	bh=FhvGWK1FyLoco9IJWznEyqzst1SC2dNncuWCauBb6Xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f8MbikButZvweOvAsR+HAOF70TPS5uSjPfOA5HOzZ8dFzTt48/nnvpG5pZzOJIYqJhYVqOx0odmNGzvumlUd8FEo0SFEtQ12jufNSgz5OomwB/CuT80ivZ90nFHnUk10052K3/Gpv33zhPPSFFHIu2PaEbRT0W0ZnMuQrLZZ9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nddgyKYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AC7C4CEF5;
	Fri, 12 Sep 2025 01:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757639491;
	bh=FhvGWK1FyLoco9IJWznEyqzst1SC2dNncuWCauBb6Xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nddgyKYIyK08ZZp3OVP5SuAXX4qG9NMjEwvT03dMpSgN6ryeqCl7NOc2sUuJojIxL
	 Sf3rlqjqgmr7wNq3htx13Gvhu/YdYOk2Sl3e7ynQNQUVmmnPgeG+jp/JVyAqPWe52y
	 4T08KPlG7GmL/GE5Fphc0AxDeG7Zidc+M9rXfBeYhGAhlVrKMXU6ebul3xICGnh7Px
	 wsrQ7iBgLKV5DFWKpaMTYQX8KeLp8kkXgesmZ9iqN7ZmEn4FtrK/rdK5e20vbBLQKW
	 +RTVxqh/LOJ6z/OOT7qwcpV6rP/rGi45R9ET6K55xnWItEKVHiU5Or7Vok/3r0ufW8
	 b7nrw7OxqCKKw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20250910-spifc-v6-0-1574aa9baebd@amlogic.com>
References: <20250910-spifc-v6-0-1574aa9baebd@amlogic.com>
Subject: Re: [PATCH v6 0/3] support for Amlogic SPI Flash Controller IP
Message-Id: <175763948875.238908.2008440685033086798.b4-ty@kernel.org>
Date: Fri, 12 Sep 2025 02:11:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 10 Sep 2025 18:18:24 +0800, Xianwei Zhao wrote:
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


