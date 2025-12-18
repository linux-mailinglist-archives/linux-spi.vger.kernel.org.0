Return-Path: <linux-spi+bounces-11996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A2CCAB2A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7433062920
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498502FFFA5;
	Thu, 18 Dec 2025 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPoRO7nL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0062DE1E0;
	Thu, 18 Dec 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043410; cv=none; b=LIUe5wcNZoTjiL4sbANcnKuMagMxYt3Ac69sTc3LTHrZCBseVoNj39M9OP2cIGjtufW8Q0ZBGc6qLFtvrIZqdG0D4CmA+LvcqFywcZ8P3vBsuVLC1BZVd/dQgmKpQ4oYnP+VbzDryej2xp/VYhbAQkhy4WXAcqDJl9PQj6p61cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043410; c=relaxed/simple;
	bh=egccrtVw3HByxVzw/WWhOtHIeoGo73qZkdhJjEVMPes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cgsjsVxkd0l1HC4Avh9qaHg07Gk/SWKSCa4NzvnkK1Mzr31vc02E0DufgxLTQ9B2yBI3XY3KcX+e2zXUiGGBatEpTvS7qkBMoGtxrHpvCpbTelYi9iBIcxMwYFoONrhxIhYCsq6jhMkUDCh0NYDuImsAKlfjUqzdVwh03Iq+15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPoRO7nL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78696C113D0;
	Thu, 18 Dec 2025 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766043409;
	bh=egccrtVw3HByxVzw/WWhOtHIeoGo73qZkdhJjEVMPes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YPoRO7nL8KtC7XENet1FB3jMpsrHXh/99ASmhbmhIOqDBMLXMS/qHfnJOuOWdem+f
	 DJrTgNV+g3ed9wccq5wZri68klvtTU14f/LjrCevpcMcFyMaAqpdfGQnb4Vw72UxJW
	 LYoRSI0b4hcS5lefkIh3wSiFOK6n0RdNgsHN/D0XgcDM6rGpOWWNkmeik9KSR59Edj
	 kD1COGYXFPk8CweCtLMWAlVoC6mHGnC1T8tO2rQSymUSHnjeNUN0DNLsM+ENqQb4aP
	 OZhm+XuQiLon1+6jZCyvnnN9l7u2UPsSxek6brKOEHoJ8AkaSxgcj+7KLKSZdIrJgZ
	 HXyoTn11iAP+g==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215230323.3634112-1-robh@kernel.org>
References: <20251215230323.3634112-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: snps,dw-abp-ssi: Allow up to 16
 chip-selects
Message-Id: <176604340821.24947.4105982029008973557.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 07:36:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 15 Dec 2025 17:03:22 -0600, Rob Herring (Arm) wrote:
> At least the Microchip Sparx5 supports up to 16 chip-selects, so
> increase the maximum. The pattern for the child unit-address was
> unconstrained, so update it to match the maximum number of
> chip-selects.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: snps,dw-abp-ssi: Allow up to 16 chip-selects
      commit: 1d24636a9c87c32ec626a56593c98544e6c49fef

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


