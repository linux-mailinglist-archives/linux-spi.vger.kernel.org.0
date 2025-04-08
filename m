Return-Path: <linux-spi+bounces-7462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164CEA812C2
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 18:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FB288071A
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612B22FDEB;
	Tue,  8 Apr 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca7Fs8Xk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A595158DD8;
	Tue,  8 Apr 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130595; cv=none; b=qEDySdutkM5jDLHou2Ic9X3ubHEM27w6blrDoTv3GPXztz7r+6ZWXwOYYspoDeAORaOpu4bEEK+bBWIwA0dY+B6Bery+Q4XZLhdxw/ZriFmPIWNItvWV8qV4aoC/9vbGAB72XaFuwG4dNvWgMvHBtPx6ocj7B9EeNyRuxa03MRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130595; c=relaxed/simple;
	bh=6euOao2eAtJ0Z0zrGfX9QrQRF5t21fg8cXwT3RaDtnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IWh035tcYVJGs2q1cDYtqUJRNx+GRbA2AL1fhSxCIRYfeO5xscQqC+0YV6j+ncgIRY9ChugreacNqc0RoEKJD7hp8rXXXkESxHRZBai9pKC37qVKgCTRe2fvD1e6W6DJs+/qU6qKQNsnSn2/Ock8cBZ8Df0dyHrUq2RV5+qEeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca7Fs8Xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62F3C4CEE9;
	Tue,  8 Apr 2025 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130594;
	bh=6euOao2eAtJ0Z0zrGfX9QrQRF5t21fg8cXwT3RaDtnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ca7Fs8XkQuFb/FKXa9ESOVTGRnOxXszAt9veA7MdGHW4kgZxhe59XHkEaq+8kw3ll
	 pXNR/byP/mEmOPyTEl6SBuQ3om/gkmXVFEKFQ/ns+SpNY29osxxcVDwCRiGIb/EDq3
	 6XDeNSatxaE2mCbe97AoV6TY4rs61CeUAXcvm0iCC8+THYKhaRaYBBMwCeGfhXJimI
	 MKjBli7k+OIDjYp3JoM5EYEoUKPYHP5Q44O9BrqvUqmxKT2TZ6essWe7I8dRlivnWP
	 8MNdh2lrZeMQ3V5zaOBBZHNcIswbyWAPWElPGzwEhT77spADk8JLKvGeLAYXulGEza
	 MR7kTABOGDVJA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 christophe.kerello@foss.st.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250324-upstream_ospi_required_resets-v2-0-85a48afcedec@foss.st.com>
References: <20250324-upstream_ospi_required_resets-v2-0-85a48afcedec@foss.st.com>
Subject: Re: [PATCH v2 0/2] spi: spi-stm32-ospi: dt-bindings fixes
Message-Id: <174413059164.2217856.1996505992127496471.b4-ty@kernel.org>
Date: Tue, 08 Apr 2025 17:43:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 24 Mar 2025 10:40:12 +0100, Patrice Chotard wrote:
> Make "resets" property mandatory.
> Update spi-stm32-ospi driver and dt-bindings accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a required property
      commit: d58b4eb7c03cabb10d4eebc89d7596e06376e54d
[2/2] spi: spi-stm32-ospi: Make "resets" a required property
      commit: 69e3433fa5e24edc94e94b4f34e3dbb754bdedbf

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


