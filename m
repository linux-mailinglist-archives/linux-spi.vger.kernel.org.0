Return-Path: <linux-spi+bounces-12348-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D7D19821
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8170300750D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4962882C9;
	Tue, 13 Jan 2026 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVXSQufB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF35231858;
	Tue, 13 Jan 2026 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314964; cv=none; b=bdktfha0u6u8cTTzXxxkbwMOIC5MzCdDhvI1f7Ql/mi/MyOieHkUbht0gHb0wVIBMGm2RmttQykP7kcoyFxyDGa8CsfglLeov8yFzG1p+9dA/qSllFZvPo7ZyJheQvS8Bu2Hzvq7zBdP+3xEqvIVOTnUioHxb8lUXl4WlxhkoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314964; c=relaxed/simple;
	bh=agm6ua/gEqt7B8Ovt/5L8e6HuY/saZKOjqNBQaE4u04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=irvVQ5wpoevWEYm8quZLLOCr8ypihCXbpPgiSixFL7Jw4BBjkBxamKZ+s/oBDymraEPOx4dyhaY34LacX0uBfzl548yBqmV1E4Vk2G4ZO32b68ma9eymeXyW0KEQz1Qj/pR7N4gsSSzQHjBrpAPJ+CMp1qRZLmmjL63Ti/8Mc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVXSQufB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D5EC116C6;
	Tue, 13 Jan 2026 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768314964;
	bh=agm6ua/gEqt7B8Ovt/5L8e6HuY/saZKOjqNBQaE4u04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sVXSQufBTaekvIUFIkwqleReDAYz0f8vLeAtrNqUYZ2IN2wK0aOOSoLW4+vfYCLG8
	 K1rVZ7TO7hUOBCGb7QhLqJEy/Zx+CAciwQuGfHObVA4kZ5hrw3JEz4dVmv7kqQ2Klk
	 U9YKNllSIxuwAhrRjtns8yAi5ziJBdaJrFluLcQE11smT2re9WeVeSZf3zgD4NuMFP
	 vtK0y4Z1HY2Mh6n4aOId9VJkAwjqLLWq9AxAEIIB9RbKzCUvdBjLNEbNW7/sUCyUmz
	 DzWUoYULTqaAD3k4LMGGEHs7B3oY2Ij4OkamC20NL0kqq863GkD85DDcDDnXQFmWz8
	 Tbrcd0KTntaag==
From: Mark Brown <broonie@kernel.org>
To: Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260107-axiado-ax3000-soc-spi-db-controller-driver-v3-0-726e70cf19ad@axiado.com>
References: <20260107-axiado-ax3000-soc-spi-db-controller-driver-v3-0-726e70cf19ad@axiado.com>
Subject: Re: [PATCH v3 0/3] Axiado AX3000 SoC SPI DB controller driver
Message-Id: <176831496192.83859.8720209174414217917.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 14:36:01 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 07 Jan 2026 23:44:36 -0800, Vladimir Moravcevic wrote:
> This updated patch series address the review comments from the v2 submission.
> It introduces new SPI controller driver for Axiado AX3000 SoC and its evaluation board.
> 
> The SPI controller provides:
> - Full-duplex and half-duplex transfer support
> - Configurable clock polarity and phase
> - Interrupt-driven
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: axiado,ax3000-spi: Add binding for Axiado SPI DB controller
      commit: 7b122b1eb627059bd331d5119124a2da5e142c01
[2/3] spi: axiado: Add driver for Axiado SPI DB controller
      commit: e75a6b00ad7962a7ed1c9c777e9ab1eb29043ec8
[3/3] MAINTAINERS: Add entries for the Axiado SPI DB controller
      commit: db4371d13f82fb12463fe053f4864980a2af2106

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


