Return-Path: <linux-spi+bounces-9996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307FB53FB4
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 03:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594117BCBA8
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F354791;
	Fri, 12 Sep 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsKmCw3c"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2BC168BD;
	Fri, 12 Sep 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639486; cv=none; b=SLLKLSBlQAzDMSJE3diPfy3Bfe2e7OQrLq+T3m7dFdlDfZErfkEHrSA7jrr/XZgyOLx2b7odnvWPqwkZshzFnR6W4bZYpwF/WqQ+mhjU9cv5YxZ5w2C3BlVCq26LzN9zETzLE2KPu6IORP5SIh9OWhuX9pPqQNd0N7YYRvHZiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639486; c=relaxed/simple;
	bh=BCQ6ooMUqjJ44vEm08o6flrbCyjr9CZj34vyNm7zsJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hIOd8YGWCBKlUIDyLyX3Y9AilhdpRy5lDAPUdHRM64MBk5JQfJ6z/w/JZLHTvtdr97fRO+6hwXCizIW/tsrXFKhu4cfFWY+2kwN5+p3QAqqR+KUTb1aQJ6y9qIHD+HccWU5LQQhW/skZRBvUFIuAR1KO6xsc2WY7g+mRUqgzOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsKmCw3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF4AC4CEF0;
	Fri, 12 Sep 2025 01:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757639486;
	bh=BCQ6ooMUqjJ44vEm08o6flrbCyjr9CZj34vyNm7zsJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PsKmCw3c6dLI9HzTstQVy1COehG5HkNSo06sr+cOYMAvIH2/z+vxujB30kkBAdsxh
	 FJ9GzYib6C7RsWJrdqqs4RmB73XKJoi30rzPy2DGLJcY2lBtswMPlHLCJbYRk65Mya
	 0TroozGbiy3o3Jxkfjn++XOhUNqjelz51XMHn8DRjF1NGCeyD0lWDjg8yo44ojKQQs
	 tVD7yZd8n54vU3fOSs7Eo5pgpQyHx1f5GKK3NRRr8rMg1hIIFSFGvEGsWhBR3mVo69
	 qZjDzQJ1TrX9sIsTVcdHI4YmOWBuQMSkr+425c4zVLHRoxBzV3WCpste8SkVvM3tCE
	 dPJw/0vlJcMfA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
References: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
Subject: Re: [PATCH v4 0/3] support for Amlogic SPI Flash Controller IP
Message-Id: <175763948411.238908.9952245869421618986.b4-ty@kernel.org>
Date: Fri, 12 Sep 2025 02:11:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Fri, 29 Aug 2025 13:16:12 +0800, Xianwei Zhao wrote:
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


