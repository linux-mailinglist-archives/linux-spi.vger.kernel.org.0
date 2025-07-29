Return-Path: <linux-spi+bounces-9214-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B196B151AE
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 18:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07FA7A4A38
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BE28DF27;
	Tue, 29 Jul 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btbLX4Rb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7954215191;
	Tue, 29 Jul 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807971; cv=none; b=ZLN4OqHLv5ibv/Pk5f+m2+4Syyi+QHaoB+pIggWXxGosQIPS2Muaq7HgVn7hh30rffX9TqUkv3i9rEs4GDJTREh8AbgcUkpi6C7+jdJ95RsvyHxh7cn+1jMZDILQ12DeYgrM4ozLWlZwn03vEVtrDo+W36JmtsnTg3VeSYs4yR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807971; c=relaxed/simple;
	bh=1+WJoKvOdfzOnz1RyuC1YBVUXZTMqzeGGAA/TvJXqUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cTFrN1nxi+FTA/8Rdn0ND8Tymi+SYS4AexO2NV9TaLjGpJxAsKaBAVO5dls6Wq34J4l2/u5ifxCOhgaeifemAF+bld3yIxVy9Rugm32ACyQoV+TsOC/OGrKIcpf53OCok4wviAnDnlrzOl0CCq53vLSYE078/9KJmIzLH1utxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btbLX4Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26906C4CEEF;
	Tue, 29 Jul 2025 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753807970;
	bh=1+WJoKvOdfzOnz1RyuC1YBVUXZTMqzeGGAA/TvJXqUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=btbLX4RbHSOMcsUr4iZDOea3Y4k2GBUPeIzw26+KEFSKPqrayPS9PC63lgeM4X5ez
	 ZsPyokp5MO8phDwnn0naTN3LbiSzzjwakQDm/ZstFbl4Rnakom7ZLuASeQINcZkciq
	 dfTfqyFbPzEyJ1cRCO5yRK9p0IV8E3+dTXua5m5XsUBelAj3F2jmlkhFhC15wNGoL8
	 bwCVohXY51iRqj/YDgju/t504MQ/ySt7hf1CHhArZlOJQMfSiT+rL5cUJQkoXfauPS
	 uWigBkP5VHqPShtBep3P3+oWl+Q4sho4+Syaa7NuV4ykOEoHwAZbxXdBaisaJ8hqOE
	 L0BlEWpYabSMA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250729145110.37258-1-fabrizio.castro.jz@renesas.com>
References: <20250729145110.37258-1-fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
Message-Id: <175380796790.160619.8661684220183752769.b4-ty@kernel.org>
Date: Tue, 29 Jul 2025 17:52:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 29 Jul 2025 15:51:10 +0100, Fabrizio Castro wrote:
> Add the MAINTAINERS entries for the Renesas RZ/V2H(P) RSPI
> driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
      commit: 926406a85ad895fbe6ee4577cdbc4f55245a0742

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


