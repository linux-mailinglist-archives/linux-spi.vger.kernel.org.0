Return-Path: <linux-spi+bounces-3720-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499491E801
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 20:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1081C21499
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25916F0CB;
	Mon,  1 Jul 2024 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKA+eRc2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73C10F9;
	Mon,  1 Jul 2024 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860140; cv=none; b=S+qFPHobuBofbDA2nNTpySm/vM6wR4+eHAz392Z5dPFP4Ia/l8BV2tTlmVVXZf8j0Dao+y0OU1ALT32Ydi1rpZP+Evzv5XI+5Lgx9yoq46JGEHHubonS84SaVE2+4TxQgcZeW2UbUZXE0+PZUvXzv4YQQhwpFuFGqS4C2wjS9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860140; c=relaxed/simple;
	bh=tKT3AF9izf+QcbDm8dkJopSLoYWVl5irBxYlOLSNaR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zcx6DS+Xa7TuabE+AWkJKKDZiBHLq5nZH6kL6VTJNW6pa2qiIW0gmXDrDs9NHQfA0/zSPoRzABEInk+IybfXoN21ld8WqvWcmaZVf1acb52Iyty6N4fXbrzpUYYYRhVqpmeCI5jWQry/ioDYv9inV3MiepFU5WNHUdCQp+chAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKA+eRc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FFBC116B1;
	Mon,  1 Jul 2024 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860140;
	bh=tKT3AF9izf+QcbDm8dkJopSLoYWVl5irBxYlOLSNaR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PKA+eRc2WG/QVP+QVEAWhNXRYqqGSLfut7VBnaBRpAZJO1xra4VTRl1+VVRG1YFgS
	 GJOeh6qhazQ898pkD26mgVKvEZKXgCIlR1GqdTBtzyRl476Xc2t2JqD4ELuzeA93pv
	 usB5z4YxpOF4ZlR9l8+LirFB7TmIWTEre3iLQ7XyRmP1DC5etOAkz5GEbqQGH+4BAV
	 Rx6IUUdaFI7aEEXPrt87KFMaT5q9qUgPyiY53LsPAXSS1E4T4ANpbi1sFvoF7GStrj
	 1cuSthHxKsH0mlC5cYy5sKMNXMGU50acMP6L9iNiymQXfyUMfYPZZth1pz+Y/iLjBG
	 N3T9Ui15HvpTg==
From: Mark Brown <broonie@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
In-Reply-To: <20240701121355.262259-2-kanakshilledar@gmail.com>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] Add basic SPI support on TH1520
Message-Id: <171986013709.117703.4499828331646855828.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 19:55:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 01 Jul 2024 17:43:51 +0530, Kanak Shilledar wrote:
> Implemented basic SPI support for TH1520 SoC. There are two SPIs reserved
> on the LicheePi4A, one on the SPI Flash pads that are blanked out on the
> back, and one on the pins. I implemented the one connected to the pad.
> 
> It is using a fixed clock of 396MHz. The address and clock frequency was
> referenced from the TH1520 System Reference Manual [1].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: snps,dw-apb-ssi.yaml: update compatible property
      commit: 6c387fb263363347185bd7a213ad175c174d35dc

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


