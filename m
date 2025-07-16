Return-Path: <linux-spi+bounces-9110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51E8B072EF
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 12:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E69506424
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057ED2F3639;
	Wed, 16 Jul 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZRpQi/d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DA2F3629;
	Wed, 16 Jul 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660909; cv=none; b=sHVTYJrF2SN350UOZWt8ZZyqWPQTCchkVXiNlv2lR1Jnp9AEQuZbrZn3A3Ch3+Al3YAshTN7eAHdQhveAO75vcaV85PvB7JgpYMaveXuNRyNJhjqiTY05fhV6J2nRYByYEXkiYEksvQTx/appv9PjkQqXfG0mghygc9UO7HSqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660909; c=relaxed/simple;
	bh=uHygiQuZVYuOZyP60B4wmiODV+vXIaSuz4a87aEJAcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o0KUdpzSziVYxXh85KZJ1hS3TdLxSbAU0ow7EuV39mz9eOZ6an7r9m2SomXcDAgvk25c1tyww7zkgD2MT/rNsohk4D0A/Mp3Jl9gA7wugxsKiGGYYw1ZbNUbuJLmX0vJOGtJF/UHDtICCjTLANb74NmMySXwj5b3pvvaivIPTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZRpQi/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9185FC4CEF1;
	Wed, 16 Jul 2025 10:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752660909;
	bh=uHygiQuZVYuOZyP60B4wmiODV+vXIaSuz4a87aEJAcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JZRpQi/dMHYUWl7Q+dyLlIcrudLpctqmrV8P1+rLksWPshl3BEoO1oH01cDpOZw9j
	 MvSG6h/5RwLjTnDVb5WX01su7FWAoMAXmnQbGaP0nH5C8VZtNl65RuVBvWmpjDdmZ4
	 bqYML/a+xI04WiUM6iWgVUalRZCQStG+ZFYdcRXu6HxSiQlZQprBHUaRD7knHpScQv
	 dZHbX2+4kmC/7gJuumgoKqvUnDwCZ0o46KBy6MGTJOqHOr0uO9uXRBZsZPOljiPHp3
	 sEnKpRlVnlBNnAtM9wsxG9QeJ8Gj8N0yLwxD/qf2CC5HbKoNIj9FY88SCcGQ/gSpMF
	 8WyaLPPgnIdEg==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250715202711.1882103-1-robh@kernel.org>
References: <20250715202711.1882103-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: spi-mux: Drop "spi-max-frequency" as
 required
Message-Id: <175266090631.17966.7228159355506888801.b4-ty@kernel.org>
Date: Wed, 16 Jul 2025 11:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 15 Jul 2025 15:27:10 -0500, Rob Herring (Arm) wrote:
> There's little reason to require the SPI mux to define a maximum bus
> frequency as the muxing is just the chip select and devices still define
> their maximum freq. In fact, several users don't set "spi-max-frequency"
> which caused warnings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: spi-mux: Drop "spi-max-frequency" as required
      commit: d5255ae7ec48ac1f702e95b472801dbb7bf1e97f

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


