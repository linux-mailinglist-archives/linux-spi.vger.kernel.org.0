Return-Path: <linux-spi+bounces-4064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D3993FD06
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 20:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42071C22216
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015C186E24;
	Mon, 29 Jul 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzQV88g1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613931862B8;
	Mon, 29 Jul 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276149; cv=none; b=u6gbPuBa72rfimn+yGnTCp+O4m5yUV8uSw+C/zQgBmEFRIUa/a7g0TQZpjhpIvuxbwEP6iB77Y63NuDeMQlk4qu1EkolmXd1A2vRUfQYrUi+FnPGwVkThIQ9c/NRv1gaU9UzM+ymoHffYpTgoAFzmttcRRVFJ/6kny2xbJvVBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276149; c=relaxed/simple;
	bh=4mXL2hN2UJJKvUHKU1ewzY5tV2glHjtHpLcFO+h7RCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nVOrCzpkU9EppNPkKDry0I6NlxgUn5+J9zBIEVfq21ODJQuTmiFvbe1gtfmE9NbNyUweoQyngUyXK1YzIIkGrORmyd6aOYGRj5I9IcpSSe5EKtFRLreiQCIxBf/yeA4jPGjU1TNb1X/2JxSnDN1oGTblL2kIyZJdh4iyNdrDNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzQV88g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E5AC4AF0A;
	Mon, 29 Jul 2024 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722276149;
	bh=4mXL2hN2UJJKvUHKU1ewzY5tV2glHjtHpLcFO+h7RCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tzQV88g1eXOgM5pbA3H5ZS0RKheeLJ41XidUsRzLoHJma9IUEq6462w+OWWL7Opad
	 CSY/MIbJT5slR/BDUxUAXBoXZHO7i7qur1YYAuJQyZQFbrXlTuvTzog9NGiHNYsAJe
	 Cm66BnnLN7qdt4Do96kGlmMilg4nbbDtLwxC+QcOJ7rCEYmOfn8fiwQaip910DzHR+
	 3yfWb7R0CMLGJFtxEPzoWFL9wWGuzYQO/dEMpSm2HMUgVL5ZKoO51AwWhroQaH1eF+
	 fLerxYcWFBML8hW5V0T3N5ZOE13cahwqRQOIDz0MAjVCQ5OuJD1NbCs5Fgjc44nEpp
	 tl0qpn1h3OpCA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, Witold Sadowski <wsadowski@marvell.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 pthombar@cadence.com
In-Reply-To: <20240709221211.2130456-1-wsadowski@marvell.com>
References: <20240709221211.2130456-1-wsadowski@marvell.com>
Subject: Re: [PATCH v10 0/9] Marvell HW overlay support for Cadence xSPI
Message-Id: <172227614720.120386.4093330076823918025.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 19:02:27 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 09 Jul 2024 15:12:02 -0700, Witold Sadowski wrote:
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


