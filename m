Return-Path: <linux-spi+bounces-4066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44BF93FD0F
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 20:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C492836F6
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13CB18784F;
	Mon, 29 Jul 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozEejqu4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484C187845;
	Mon, 29 Jul 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276154; cv=none; b=NALRRGbjBnp5BhOtYhpNxB15qutcVUvYpJFZeRAAHx3xraefcnAbnMsE2sqt30MO4JkbUuAsuo6zJz8xb2tt1lQEg3vXMHwmKVx+vzwYs3RDdbr1Fn1Vs00TJvNLIc7PwJ9Nk/EQ01i4Nukbp1dUoGQyxoCIr+hkeLO5tuseL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276154; c=relaxed/simple;
	bh=2+rw9qje7bTRPpMSs+N14Ism4ItUcGbkGMMvhE1nLIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XRPJkhCljVnJh+zIwLWgLAO9WLMXfOxjPFFT9NCYWrTIK696a+0/Q1zfSWZ8FYsgSJr06CYlfwt5uwJmqPEL0KV8UMzavxn83Mo/wgby4VB1/p4/Jv+lxEI3YJ+rTUxAnlNvVbGevRvazSAtIaImRj++IEp1odahSRAGCXwd6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozEejqu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD9DC4AF0B;
	Mon, 29 Jul 2024 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722276154;
	bh=2+rw9qje7bTRPpMSs+N14Ism4ItUcGbkGMMvhE1nLIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ozEejqu46O2aOYfdpu1M34BBrXSnmdKrMnQhxoBBX4p8xlHHpOcdN0GBCJGQhtBGo
	 3/FxvL/krGQg8PF2nBblBAP2yHiGIj5OnDC2yyIY41/CEeb8efvm50EXEhd9eSwrRm
	 ZeNVabooJHuhuQe8r9EhxCyV0jCLWgMLbZVoUxLLH70PouvszIROlf8aZHgt41GhFB
	 XiQcg1KZQx3XH6lEf9U74899eYjd3CksY6KKvJ+VHXybnA/IWZaCb+QZLCf+W+PAHS
	 Bw3RXB0KL7DN06nJ6XDaRikjCP+ayoIsW9Imr8GJwaj+BFbhqrnJj2CYyHix3CKDjZ
	 VGo5SKqPdFc+A==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, Witold Sadowski <wsadowski@marvell.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 pthombar@cadence.com
In-Reply-To: <20240724154739.582367-1-wsadowski@marvell.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
Subject: Re: [PATCH v11 0/9] Marvell HW overlay support for Cadence xSPI
Message-Id: <172227615264.120386.12531696177070933974.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 19:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 24 Jul 2024 08:47:30 -0700, Witold Sadowski wrote:
> This patch series adds support for the second version of the Marvell
> hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
> change made around the original xSPI block. It extends xSPI features with
> clock configuration, interrupt masking, and full-duplex, variable-length SPI
> operations.
> 
> These functionalities allow the xSPI block to operate not only with memory
> devices but also with simple SPI devices and TPM devices.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
      commit: 49f63e6a89e94a757ef86340ec531668d26ecc30
[2/9] spi: cadence: Add static PHY configuration in Marvell overlay
      commit: b0d06169a7153f78b5356ca9e15cd836e43408dd
[3/9] spi: cadence: Add clock configuration for Marvell xSPI overlay
      commit: 26d34fdc49712ddbd42b11102f5d9d78a0f42097
[4/9] spi: cadence: Add Marvell SDMA operations
      commit: 75128e2a14a9f443e8debdd30445f5934b5a7c83
[5/9] spi: cadence: Add Marvell xSPI interrupt changes
      commit: fa7279acef673f17550202d662f592672be26247
[6/9] spi: cadence: Add Marvell xfer operation support
      commit: 931e389ded0f1411cbf07ad50074dc2bcd49e1a8
[7/9] spi: cadence: Change resource mapping
      commit: 4b8cb7dcd8acd7a05354f0b458aca02e4497f2a6
[8/9] spi: cadence: Change cs property reading.
      commit: 8232f1e2584ac1eadd3282b035c306ebde87d8b4
[9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI
      commit: 9cabf4a487cd4035844b4928881a314334f348fe

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


