Return-Path: <linux-spi+bounces-5290-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126C9A936A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8CFB22BED
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877C1FF02B;
	Mon, 21 Oct 2024 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv2LvaUl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BF137750;
	Mon, 21 Oct 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550079; cv=none; b=VoowsCIkzZPJiPvTW1+8jHLMOTT5nyMFG+y7OR1gidWhm8pZDqkuCkAH5tquqKoUgh5o21f6mTQ+zKwWS+zclAekPTvo3iOcqmlbBdZuwYpglwBsO7g9hYueo8vB7pm0yygA9XRNNiZ0lrKfssVvqDz8DhFEG5eOnXwOTk4jr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550079; c=relaxed/simple;
	bh=Cfzf9o7FO5QZjK5R7ziXh5AOoQbKPb2DoBGTH5P6IAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IYx4Ukt5O04MTWDOXiRI/lqgTI0O6nCs3TrfEeQbux1TpPrilv/Us+Sj0qwKWcKUT8VN+pEkWFDOeVmIZHE1zOH7V8tYhCyI3VQlvgZBPbNGKUiK7eJ4dH1BS/oqStrxq/HVc03mC8KcgeCdX2YJOkLSzQE+Em6rYCWGNAqr2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv2LvaUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D2DC4CEC3;
	Mon, 21 Oct 2024 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729550078;
	bh=Cfzf9o7FO5QZjK5R7ziXh5AOoQbKPb2DoBGTH5P6IAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Uv2LvaUlSKgbZgAlv4z2VgG7vQf2st0qQnf1ADaEBlYRiGLDJKgvlfhUmhTRAkJRN
	 PQdnq1vqg+zm7EL4NOaEYTai9Qa/jaPV31qJj+d3oAalu3vo7PbEXp1wZ8Jzkg99Nc
	 hn2udqkyFHfg+CpTsKx5+zcd4+SfdyowXR81khqLRp1pclSCT2rVTNOPQrXiBaE2mh
	 jbRsEdP1xt6xVNve+7HB0zORrbd3cVlFGelaq7aEEExs5aiwCO54a6uRBrHWjUKWqr
	 C2Qq2t0mDlmB+6KLVjSqI0/80PRH+sCCJ0qGEXeO8ryrQchRRHx5EC4uZ1eijYntWt
	 NzbFIvUJVnK+A==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 tsbogend@alpha.franken.de, markus.stockhausen@gmx.de, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
In-Reply-To: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
Subject: Re: (subset) [PATCH v5 0/3] Realtek SPI-NAND controller
Message-Id: <172955007659.195060.15034869301013958050.b4-ty@kernel.org>
Date: Mon, 21 Oct 2024 23:34:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 16 Oct 2024 11:54:31 +1300, Chris Packham wrote:
> This series adds support for the SPI-NAND flash controller on the RTL9300
> family of SoCs.
> 
> There are 2 physical chip selects which are called SPI_MST_CS0 and SPI_MST_CS1
> in the datasheet. Via some pin-strapping these can be assigned to either the
> SPI-NOR controller or the SPI-NAND controller. Which means you can end up with
> the following permutations
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: Add realtek,rtl9301-snand
      commit: eef26f1c6179eee5b622362b324a0a72dafb5c16
[3/3] spi: spi-mem: Add Realtek SPI-NAND controller
      commit: 42d20a6a61b8fccbb57d80df1ccde7dd82d5bbd6

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


