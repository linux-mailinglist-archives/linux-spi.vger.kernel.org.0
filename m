Return-Path: <linux-spi+bounces-7666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA41A9311F
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 06:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E023BFD01
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 04:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A723A1D5170;
	Fri, 18 Apr 2025 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEErWDKd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D9262A6;
	Fri, 18 Apr 2025 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744949505; cv=none; b=TJPA2QWcPBVMrTcCq1DyWNmMYOuGEBRQ5Gj2WhNj6hecdUjTp/WrI9CCNYTxbTPyw9iYw2UqlMTjLY5t9NzymsdYdgrIBXfTr8scSZJMlj0fHjKL1+UHVI9x+QGJYbYxl3+vOUwp+h+L1pnctSX/1JDi0x9E+Lo8ozmiOXLrOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744949505; c=relaxed/simple;
	bh=qDEOwP5b4S5cvN4LY06Re0n354mmsZg9nFhmQ8J/N6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MvpeKzomK/z2ly1FbclRPVSuDPs2eTy541GmiuMpDWw+k3t3Ob+igLQuPiBwHfQH5GgFVZovVJ9gXav/O8UmLVpmkNjWVO2OXpeNyfpnX9v4J9ZbyXbBPxe5lQhAQ+4SDvA2EJXeR7/lxI6IBJsRoiWEvfsY3IN0rCR2hmPkudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEErWDKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860BAC4CEE2;
	Fri, 18 Apr 2025 04:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744949504;
	bh=qDEOwP5b4S5cvN4LY06Re0n354mmsZg9nFhmQ8J/N6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NEErWDKdszxV/SJPO5Y6RDUj9+Ix3Bp2S79yIw8+v9ZGR629a26shTjdUcjCZzug3
	 H+G3qrUHNmqV2NTDBbFNLtxebqxq4QkAYflKG2RLCOzf7lIVicQZoVlimhXtuuW8Qk
	 Sz3F1cMEqSeC6sbaZP0SJRCMpw9Rldm8YC4P/4YQePlOqAm75FkpsXKEHh45+kP9Dp
	 oDmu5ZjmaYSqT7bytCQuXMsiQmXqxeOMrfDKT78EMFTco/byPnj7kkkWGjQORk4K7K
	 3K9Ae4eckmM9mHSbT7YHvJSi0fB4SQ0SkxJiSos/8ykEGdX7RY+WhQx9sl0SEHIPLM
	 81CipSbJIjaMg==
From: Mark Brown <broonie@kernel.org>
To: linux-renesas-soc@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20250417111630.53084-2-wsa+renesas@sang-engineering.com>
References: <20250417111630.53084-2-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] spi: dt-bindings: Fix description mentioning a removed
 property
Message-Id: <174494950324.341452.7517425061718095722.b4-ty@kernel.org>
Date: Fri, 18 Apr 2025 05:11:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 17 Apr 2025 13:16:31 +0200, Wolfram Sang wrote:
> 'spi-cpha' was removed from this file. So, replace it in the description
> with an existing example. Reformat the paragraph to adhere to max line
> length.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Fix description mentioning a removed property
      commit: 4cc9cf2f437ccf6915100c2f38f63cfb1abad6f9

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


