Return-Path: <linux-spi+bounces-3463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE790EB75
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26281C2125E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629E144D3E;
	Wed, 19 Jun 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2I+uINO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C41442F1;
	Wed, 19 Jun 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801450; cv=none; b=LEgRn3Pn65pmxrfGdAnvNPMrbCgqyBfE3UT7fImxk1IH6pqavbAeoNp4P8JmbOn/vphYoBZis7WazHza+wBwK4mAuAPYeWPbgVMqLMkaWXNBXakYhQGnrwkEDvPN0jazhfooaHVmQ+au4UXce0AMiw+SwyO2yA8zXBAz/nIUCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801450; c=relaxed/simple;
	bh=6K6iblTkgTBTOPh40fvr/BKHmHNj+OuCMWSU1j1l17o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8YRfb4YA5o3Mptfxs7dIt0ZWc38QzC9HDuVoEnNc/3/TvZYMdYr6gGJAgcBWEl8we9esq5SFQihuOt+/vLqIQjQ+HEHXX+15u8s8BLeaCNNZSZTG64Of1pdeJqdFb1xvKlCydJbjl1A435q7tZyE/WcvhM+I5Sq6bKw/XZWCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2I+uINO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB836C4AF1A;
	Wed, 19 Jun 2024 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718801449;
	bh=6K6iblTkgTBTOPh40fvr/BKHmHNj+OuCMWSU1j1l17o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q2I+uINOriJX8XjkW3c8/BNkNskneTJZJOMY6Cl2ieA5XORuUq54zTiD8V6FL2pLx
	 HU8XfBYOVUVk2yr132flM6NMaJJoii5VDBZKOOZEqfbs61YbeWTTgq/TYKD3gFu+gW
	 dAPLbcOF2vFi1TKQvbdUhdjd2d2hOPW4/cPgjQhY2XCjbwLQCE5jjMQltQPt53HbxF
	 1wH9iHu4dHAZYqptFP/vAXiKt6dB5RV31P7Hb7TnzH9FNhumMgvUSDwQoEMIoEoIKw
	 duEkbvex2leqTxDRspE35tW6vwCPUcR3InfoeEq2N+JNF2+HUdTv+geSm/6Wv6bQxH
	 7wiyQL1xNfTLA==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-Id: <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
Date: Wed, 19 Jun 2024 13:50:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 19 Jun 2024 13:17:02 +0100, Charles Keepax wrote:
> Refactor accessing the SDCA extension properties to make it easier to
> access multiple properties to assist with future features. Return the
> node itself and allow the caller to read the actual properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
      commit: 6914ee9cd1b0c91bd2fb4dbe204947c3c31259e1
[2/2] spi: cs42l43: Add speaker id support to the bridge configuration
      (no commit info)

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


