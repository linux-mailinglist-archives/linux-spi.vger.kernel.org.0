Return-Path: <linux-spi+bounces-3357-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DD900B1E
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0701C2125A
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2726C19A2B5;
	Fri,  7 Jun 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O850enW3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418C1974E3;
	Fri,  7 Jun 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717780728; cv=none; b=QNFk25K2S5tF5nVrbvG9jka8lFNAjX6zijEeyoujqOjwlg08s/5vmdZTpJ76TPw4jKaF+kd4zojhcZnjlqVU74anZHSeL4Ov6dsyPnueWz6qKKdyD12smhMdhPWhDAq/shRnGIji/rtjN7njF4eUYfaQaTitzklsJTV48gNy0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717780728; c=relaxed/simple;
	bh=3527d15ZyV8QF79cimdFE1xK69IA6U0tsZ4ZLpp8BKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FTrAkB5VbKG/3rE/PkccsA6QpqxvGOv5FNHXD7PVmAUsc/RQhMRNwz7tQkv7/o5Rv8cmE0KX8/u169BxjSk2frjR+BNGfwGrWNICjDwWFqq2x94iR/veOxxQp5bD4IqEqWFPTUYFi5OFDjeQKLlzjdqtedZ39wWg+e5vf4sIvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O850enW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F855C2BBFC;
	Fri,  7 Jun 2024 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717780727;
	bh=3527d15ZyV8QF79cimdFE1xK69IA6U0tsZ4ZLpp8BKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O850enW3o+K4Q8beCpTMaRAXdI2HnrVrRZYJumK83eWvaLp5MQPtl+29tVzBmU2dS
	 Be49RylyPbfq5iUTtQ48YR7208ufVXYWES/zGBUhwPq7r0prR3x/xJmud5Y7J1aB0r
	 wZ3nlfOgWaUdF5UxBUU4x1TdEvxszm37YwDkDtzOKIuN9j0hGo28IsuigPtT/g8Mbb
	 J0jr/I9kP3k7df3lcZtWNutLGcqqGhF3pBmsPE5QNvsotl+sgABc1kjbN4vOK6mUqi
	 auF+WEYQT+hnhZ8/AkAzzimUn8uHmozChJu+lzBC6T0dcnWxtAqI8gy0EUDOkvrCIB
	 RIROCqGFAOWzQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240607103423.4159834-1-ckeepax@opensource.cirrus.com>
References: <20240607103423.4159834-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz
Message-Id: <171778072618.80456.1164637774989487170.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 18:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-a6ee3

On Fri, 07 Jun 2024 11:34:23 +0100, Charles Keepax wrote:
> Some internals of the cs35l56 can only support SPI speeds of up to
> 11MHz. Whilst some use-cases could support higher rates, keep things
> simple by dropping the SPI speed down to this avoid any potential
> issues.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz
      commit: 60980cf5b8c8cc9182e5e9dbb62cbfd345c54074

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


