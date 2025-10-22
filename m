Return-Path: <linux-spi+bounces-10781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FFBFDFC2
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BC374E7B3A
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD48F34EF01;
	Wed, 22 Oct 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmziISPK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1D2EFD86;
	Wed, 22 Oct 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160500; cv=none; b=IKt8XdVvCPcc8EIWAAd9Z52+hUPSivj/hY6VUlWH78SPfZG/ZnwVn956oNxpbB7y76MRLa/RMjNTAImLImce1xko7Xs8LdJ7aeh5vZRgZCVIAb3YsUuxqd/3quYFFzLEWEXWuUabvFP6JXGlZhLBJg6vB0fpHpuUhOQYPpboVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160500; c=relaxed/simple;
	bh=Jj4YEIsqQhqZWmMJ/tIr/DjyokV4153P61w7wWugois=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nc6kJ1RXH6TiH3n++0tMAcPXQLLqo/cnjy5RlKJtC3r74YgiPQcTu/g/TIcVJXi+7BL/wiQf5JRU57+kovKyH0ExFBFuibydG5MAtcoOSms1qOUwwgLkYncSV1BSEWvrDrCokNdnS+u/gigCrnM6MvB88ejPgs7ycXh9p+JOocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmziISPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEF0C4CEE7;
	Wed, 22 Oct 2025 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160499;
	bh=Jj4YEIsqQhqZWmMJ/tIr/DjyokV4153P61w7wWugois=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NmziISPKLTWkjCzS7qn2h1p24U8fSEHKoVmBSHvaLDq4gssyxrReLIDLmVGaOy/Mr
	 PVBqSguvH0YP+NZdxwCKnpHwVE1Do4lLS/X3XEJNHcekRHUUy2wlJEeUr/S3mfkHFu
	 JbSmtz9l7WhgoAaxYIT/bP+TEYWtfXLkibySvA+rbBwIPvgREjpbjXWIwt6ZQdIHjR
	 fzwMbvLIagfOUPypz8M9HRYm2Mz26PMD+gbbHeGRDwobMUMZW0qDO/gFzFWTHwiY2g
	 e/LvMqvWZVd2tK2VJ3VjsJiBc3o5QJXCNzMeHBrtjmmwf03fxAJB988//DpeB4RBJ7
	 eP+V37QA4m2uw==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022004200.204276-1-heiko@sntech.de>
References: <20251022004200.204276-1-heiko@sntech.de>
Subject: Re: [PATCH] dt-bindings: spi: spi-rockchip: Add RK3506 compatible
Message-Id: <176116049600.324570.1351275211432564524.b4-ty@kernel.org>
Date: Wed, 22 Oct 2025 20:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38

On Wed, 22 Oct 2025 02:41:59 +0200, Heiko Stuebner wrote:
> The SPI controller found in the RK3506 SoC is still compatible to the
> original one introduced with the RK3066, so add the RK3506 compatible
> to the list of its variants.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: spi-rockchip: Add RK3506 compatible
      commit: 1b824134261d2db08fb6583ccbd05cb71861bd53

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


