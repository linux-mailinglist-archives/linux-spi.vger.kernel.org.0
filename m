Return-Path: <linux-spi+bounces-5083-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044998CA1B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 02:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604D21C214D7
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 00:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4E2114;
	Wed,  2 Oct 2024 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzGsgvYZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E01FBA;
	Wed,  2 Oct 2024 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829541; cv=none; b=AferV39o+9Xc9Lrsn/upIOTBDei/acnWMUljRY0aHbgFrEXbg/rd6PqL7qkjevwdZ+Box7jxvVOQSju35OFTpu0PFlph8A44oKo6CNueg3okj5U3PiwXW9dXWdV3gxzFEYQLwI6FhJWq+3M26/4TicT1U8RLZfIU9RykkVX1C9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829541; c=relaxed/simple;
	bh=ybaVeV8JJYACSNev74TAhL/xyOhbNnHvUWwUmKf5R/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dSKDq4rx5/V/QFfkz8NPcB5N0IwEGvNmgNTCLNFcj9iLGq2h2E7ypA9I0HuJwLy7GPWVezW4lkJmNJT857v1Cj0msqJC10zCp/wLqdrx1vvOJTD4RPeBXgi5O55mQHTR4/a6xpmgmEj/ogXC/oaCcAW108EYE+jAViFfWaJXiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzGsgvYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFCBC4CECF;
	Wed,  2 Oct 2024 00:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727829540;
	bh=ybaVeV8JJYACSNev74TAhL/xyOhbNnHvUWwUmKf5R/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CzGsgvYZv8CDHY2i3ESOjhc0Tg+OfnEQVbpDGD+kaSOwr2iJ6qxd0oqoZdPZThaXA
	 O0Vmh5zVHgjEVWM8pWoVJXkMpYMEWNFPkdZnqGjYNCYSwwW+loQGt/QbMtCi1XD9On
	 J8TgiU3gwRdOJQz1dvKJ/pW5Ckt79B9D6L0xGDJmUzDFTGueOH1/dhGvQS5ICyWzVz
	 x9Ttwrermh5WpO8v5F+esVQQOzw/Tq4Gj+ioJ5kRZJITskBiNt03Iaprn1EQfp5mxM
	 zbkqY2AQ04FNDkLsvefNp8w73KBcRMRCyfKfPYThdxVlSLgqDTk24VDQdW66eNZTNr
	 itXUHcwIzPBJA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
In-Reply-To: <20240924134009.116247-2-ben.dooks@codethink.co.uk>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
 <20240924134009.116247-2-ben.dooks@codethink.co.uk>
Subject: Re: (subset) [PATCH 1/2] spi: s3c64xx: fix timeout counters in
 flush_fifo
Message-Id: <172782953761.2314893.16208330510622172964.b4-ty@kernel.org>
Date: Wed, 02 Oct 2024 01:38:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 14:40:08 +0100, Ben Dooks wrote:
> In the s3c64xx_flush_fifo() code, the loops counter is post-decremented
> in the do { } while(test && loops--) condition. This means the loops is
> left at the unsigned equivalent of -1 if the loop times out. The test
> after will never pass as if tests for loops == 0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: s3c64xx: fix timeout counters in flush_fifo
      commit: 68a16708d2503b6303d67abd43801e2ca40c208d

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


