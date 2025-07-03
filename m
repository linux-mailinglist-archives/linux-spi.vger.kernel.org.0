Return-Path: <linux-spi+bounces-9031-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DF9AF7D70
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE2A1C26B98
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E42E7BBC;
	Thu,  3 Jul 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDoOapL1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EE019DF4A;
	Thu,  3 Jul 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558561; cv=none; b=ALSLUISJGH7CIW/C6VoA9llD7QoGjgu7OCJgxQ8GlgII7o/wGTHDiOZ8PDJZx9KPWJfxFV9BLsMALubqglcXzPZpmR8dVgOoqI9oQ40rn5w+rJh4sEc8uZBdWj66JDhvowSdtHdbmwtHaq0cgL3XULL+ZoydF72RQjxiKbP7U/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558561; c=relaxed/simple;
	bh=v3id9QZOO5mULU2gl2RNa0JDLRkIsFGzv0uGDL0A4o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g5hCsBAwbgomlpxNNyWvfvIQafxBIjYIjI+XIsvk2ykmqPgaoVoXZREWO8NKhm3m8cdO1xnQmxUbtTUNyfmgxh3eO27st4alTQZosA3kDX//mGFfuUK0bAuKhYYoXRmjbNlmWOLDHJzaOT8Gor07AlT072NRNERbB9zb/nNRgsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDoOapL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2248AC4CEE3;
	Thu,  3 Jul 2025 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751558560;
	bh=v3id9QZOO5mULU2gl2RNa0JDLRkIsFGzv0uGDL0A4o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sDoOapL1vB48aQOSxo/5HupbQrj+0zmdxJI9zT/gkYPwCnCL2UkFDNQd4NBohmZv8
	 YD4pMB9kJ2ZPcd5eao9ES0F2v9fLMxzbxWHRWeqe0Sn+HWr1t4aN2ZqPPItJrvQEY9
	 8IWYdAXTb9XojvwtOcZ3jv6S34ILJ7ZD8wBw3wuLBSHLOt9ZuJtPNryPpGuwX+TBVw
	 CwqdiXdpxg5IsiI6mljIgozAsTvFEPGzpFrEwhdMTelaUc5YERDVelsC4mZ5wzl9Kw
	 ezsDtLQDfjp7J7miJXJKcYHRqrevLZb2w5jGd5fYsxUhFiFVRaV2k4Yw/nW2yNyKZ4
	 /USX1Pie8L0aA==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250702222643.2761617-1-robh@kernel.org>
References: <20250702222643.2761617-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Convert marvell,orion-spi to DT
 schema
Message-Id: <175155855786.620355.17818557037434839983.b4-ty@kernel.org>
Date: Thu, 03 Jul 2025 17:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 02 Jul 2025 17:26:42 -0500, Rob Herring (Arm) wrote:
> Convert the Marvell Orion SPI binding to schema.
> 
> Update compatible strings to what is in use. Generally,
> "marvell,orion-spi" is a fallback compatible, but newer variants only
> use "marvell,armada-380-spi".
> 
> Mark cell-index as deprecated and not required as some instances don't
> use it already.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Convert marvell,orion-spi to DT schema
      commit: 7105fdd54a14bee49371b39374a61b3c967d74cb

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


