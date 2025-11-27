Return-Path: <linux-spi+bounces-11620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A0C8E149
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 12:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3A43A94E6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13AB3009E2;
	Thu, 27 Nov 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocYnbeFn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050622F76F;
	Thu, 27 Nov 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243881; cv=none; b=CF3joXJ8Vzq5taCUrXDmVPJI7Y4Xmp0Ons3DWdSqY2962D6tDZzkV1uY+vqEnk9Pw3Oar1iB21g7x2iYFPaRzgIvsQQ1rvSYkZxIXyEHT2CNlIy5JgFSB7WHvaU/sW1FuLnvVEhQjizvtyJRQ7+1kkwu5xx+a9Q0GWI1F19fPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243881; c=relaxed/simple;
	bh=266LmUKXgAPdFDuUqdc5oet/Hk5JYy/stINU9sWH8G0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rly95gYdoWfLa8s3pRgjWiSYpgRAH7ewG3+PyJRtPIZLanT/Gdy8TYuWs0hGa2x35uTo6jEjo2uVEtEDkEa5BFuHEPyrpMgnpPY+lIawt02VRm/lsoMRjCWtSspwyVUC3JxEdTXxgcwt0CZqmkAs9Q5ti9Kr6J9LAG9RIJkjfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocYnbeFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD783C4CEFB;
	Thu, 27 Nov 2025 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764243881;
	bh=266LmUKXgAPdFDuUqdc5oet/Hk5JYy/stINU9sWH8G0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ocYnbeFnDMFRI3uCvORh0nExoAUXPUfzlCQdd55eD31uC8Ms6HeX+mWfaTyKgymDd
	 JwWs05QleoHwAbjeDVwlRmtHsq1MwwN1hqpxQrrgS41WQBT61KHrBShUH4c7cXWWan
	 S7OjOFBXh0HFz/IlOm4X9oG2IuroDLlYpIiqjoetjJo4Q9Sl1uSzaseUtWbIs3W6AG
	 +qcSABVayEnkYhM+2k//EMkyT3gq8XDI5QPCwkf07Fv/mjFHe1awA2Rmd0wYdbwBds
	 Bh1r92US9pRNzvorRGwEgPLYmC7ZJ5GUnwdpgrkuY6TR38+LgGR5Ulq9SgefgWjx+q
	 weGG/QItjP/MA==
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251126131619.136605-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251126131619.136605-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] spi: dt-bindings: renesas,rzv2h-rspi: Document
 RZ/V2N SoC support
Message-Id: <176424387849.25601.4895863993162218118.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 11:44:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 26 Nov 2025 13:16:19 +0000, Prabhakar wrote:
> Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> compatible with the RSPI implementation found on the RZ/V2H(P) family.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
      commit: 043cc033451530f81d7fe791dcc29874f6a147fd

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


