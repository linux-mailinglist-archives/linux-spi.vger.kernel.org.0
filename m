Return-Path: <linux-spi+bounces-3838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACEB92FB6B
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EB4282C6F
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5A15F301;
	Fri, 12 Jul 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsTYyZP4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98108D512;
	Fri, 12 Jul 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791103; cv=none; b=o+WtEeof3w6fqBgf/EWSCLlRG9+SjIKF70x2/TrUrcVsQincbSnETkfUtc3Uj8TDqvFWEPEKRXVnhnXyqq6ZgaQrBgULbBcOGDx1p9CLsCwy54Ve9tElFF9q5ApKa3QwbHOEZiKyyZa2OGEuY0Y9f7XcBPzSqTVB5gcyoAgMj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791103; c=relaxed/simple;
	bh=sR/sihvCMh1BZfVoEaY4FYooiXR7Eb9typ4klvGYYPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ljDFKx5s7NXa0Jz1Le6mmEd0f3kIpGEh9x/JqBXoR3cQp2nkV4PqPAj2aiyLx2gsgNZOwEX2BEX6jAUDPlKu/oaTHv4TbWN7n2GJRvAX5G8o4FHBI2P6FSC3I3cVLwBWVgTlxlXVK/mwdpVEJ2vvtDwReClJINB5rhTsn8O52xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsTYyZP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066D7C32782;
	Fri, 12 Jul 2024 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720791103;
	bh=sR/sihvCMh1BZfVoEaY4FYooiXR7Eb9typ4klvGYYPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CsTYyZP4oTZZUlI4ixOMLWd1L2t3aWYPbplp2Ci5ZjCFH9Bp5UivMHesYvOoZa+Zr
	 6mTmMmkry4pay/9Ks8TvrKzcYLr73mtztD89+Ey2tyqYLF/X+R6OVvKjXM4JTGdpmO
	 +kk6IDG+j7yKbP1cVxz+HI6XE1mPIq5RCDLe0x+cY3WdySuheVRqAE+SbsuTReEHPF
	 KEq/p5HIs5l7co0ZZ+StTYzEb7bYf2NhdkkvuqN0sG5mBJab55kbiNZC8fZEp7WSYg
	 8vvdfZeQeAYxcYXrSDg4Q5TOVMsgUTVrEf7XFIQcURL7R/x7aF0aZk8Aa981tBtNcY
	 mXZezninWybIg==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, nicolas.ferre@microchip.com
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20240711165402.373634-1-nicolas.ferre@microchip.com>
References: <20240711165402.373634-1-nicolas.ferre@microchip.com>
Subject: Re: [PATCH] dt-bindings: spi: at91: Add sama7d65 compatible string
Message-Id: <172079110072.499335.9864167753803595728.b4-ty@kernel.org>
Date: Fri, 12 Jul 2024 14:31:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 11 Jul 2024 18:54:02 +0200, nicolas.ferre@microchip.com wrote:
> Add compatible string for sama7d65. Like sam9x60 and sam9x7, it requires
> to bind to "atmel,at91rm9200-spi".
> Group these three under the same enum, sorted alphanumerically, and
> remove previously added item.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: at91: Add sama7d65 compatible string
      commit: 3048dc8ba46b7ba11581f2a7e06849af0df13136

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


