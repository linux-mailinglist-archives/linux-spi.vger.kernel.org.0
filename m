Return-Path: <linux-spi+bounces-247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83280F1A4
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B1B1F216C1
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B976DD8;
	Tue, 12 Dec 2023 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzKMpM/H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF276DCC;
	Tue, 12 Dec 2023 15:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D16C433C8;
	Tue, 12 Dec 2023 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702396687;
	bh=kHCIVEVBzI52qhmBl5M/wcd6l7pWChQnaNSwcL3b+5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UzKMpM/HT5BrwYhI+RBWTK2uGUHe2gsvdSpEI2nxj+UO8pc/xfHfYmjwFwyMhLLfb
	 fARJRune7QMLqNucxKrdbNamxf1wl//qAxlCZDvRIo/Q9a9mqLwHOuJxeBa3Jp1u2M
	 b/Y+xtXhCL4ewzwOP1/D6vjVe4QrvraCRSAJOp/wCu8atLGmj7NwNubEBsRB1vCyWw
	 kanRco2eswcI99anGBA5OSMjWjqEKooJevRdXIW3kIrGQBjci+ZSeXX5VUWnLbuKSg
	 V3XHZTD3fAlUxvzLYlxrQ2qacm/A+M52+mIovvIeED6dLipIBy9udwu//pv0jH7cuk
	 m/uF8JBZltyEQ==
From: Mark Brown <broonie@kernel.org>
To: linux-renesas-soc@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Simon Horman <horms+renesas@verge.net.au>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231212081239.14254-1-wsa+renesas@sang-engineering.com>
References: <20231212081239.14254-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Message-Id: <170239668506.84470.10579761461556330418.b4-ty@kernel.org>
Date: Tue, 12 Dec 2023 15:58:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 12 Dec 2023 09:12:38 +0100, Wolfram Sang wrote:
> Documentation says only DTDL of 200 is allowed for this SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
      commit: e5c7bcb499840551cfbe85c6df177ebc50432bf0

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


