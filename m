Return-Path: <linux-spi+bounces-11381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCCC7341D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A93A3576E5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163132471B;
	Thu, 20 Nov 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHrop4fc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713D3246FF;
	Thu, 20 Nov 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631639; cv=none; b=dGQVlPsGJykL75J/oL0HSD2ENoCC86NEkv38W8hdqT7+ss/NTYWxmPsZ7o7X1XK9xNYyoU6opnsmua0RAhLSwud/eJipZod014yE7UoKlp2YMCi4CVWj9r9j9jwCzjs1OB4GIRJoxfkhgSxw/V9ABNi3wkJBSHcqFAQ6wQN0okY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631639; c=relaxed/simple;
	bh=7BnkVBfZwH/GgcJi42gXFcou07xV11HOso4kZIdc+/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Af2M+bQkkoc56dIRAMOvLrAEcdZgjtg3V0BLTiAmwWbS/mldCJnKT1Uiwjesj5OlZIX74QJ4SI+ZJdaNGG9rjRfdnzwALdbQLFC9cg2oGgdvHMhOMdmF6KeCQcLYjqlPiGcv3j6J+yBnveDrjlOUSNsDKRtbKfM3wgUHiCwyqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHrop4fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D325C19421;
	Thu, 20 Nov 2025 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763631639;
	bh=7BnkVBfZwH/GgcJi42gXFcou07xV11HOso4kZIdc+/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FHrop4fcLoyg462hCVE7uqhq0Uf1MkSyCBrwOpplzaXt3s3fJcUqRZj6OidX/o0mC
	 vYN21e24P4uh7XnkKMgFcCGMWf6A3d8HRhsL+lcqI2FKwtU9mEznHScc6Ur34QdEun
	 aMrspbHHZxWvCMy1X1CDd3UO1BH91bLxrIwiIMCznwEvV+lEGaN1f9T/CBQiUNabLZ
	 38rjKIwdPgcfQDBccgrSesRkz4v3mPpxtR+GBFp2Il9OQ1lP1HhAjTZdxHrj0u+2in
	 clvgFjsjP0wFlrtIhDgBySfOyJPtcCvthoOeC3KP3CI8AeD88tzaRNjlr7f52YnIs3
	 tQaDz2NcIYW6w==
From: Mark Brown <broonie@kernel.org>
To: Hang Zhou <929513338@qq.com>
Cc: jonas.gorski@gmail.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <tencent_7AC88FCB3076489A4A7E6C2163DF1ACF8D06@qq.com>
References: <tencent_7AC88FCB3076489A4A7E6C2163DF1ACF8D06@qq.com>
Subject: Re: [PATCH v2] spi: bcm63xx: fix premature CS deassertion on
 RX-only transactions
Message-Id: <176363163691.560683.17445804312439204869.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 09:40:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 17 Nov 2025 01:08:35 +1100, Hang Zhou wrote:
> On BCM6358 (and also observed on BCM6368) the controller appears to
> only generate as many SPI clocks as bytes that have been written into
> the TX FIFO. For RX-only transfers the driver programs the transfer
> length in SPI_MSG_CTL but does not write anything into the FIFO, so
> chip select is deasserted early and the RX transfer segment is never
> fully clocked in.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx: fix premature CS deassertion on RX-only transactions
      commit: fd9862f726aedbc2f29a29916cabed7bcf5cadb6

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


