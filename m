Return-Path: <linux-spi+bounces-989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E963784751E
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 17:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50C5284385
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF81487EF;
	Fri,  2 Feb 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzRfI9ut"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7B1487EB
	for <linux-spi@vger.kernel.org>; Fri,  2 Feb 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892104; cv=none; b=cHNe7WglgRi4FpV/85CbeuKjYJZdB12toC0IOivT7DLeusegkiUxipcibNFUQlTcsT9i730YffMWmnHzv3U5+Cd2PmPPBNyz5ceFSdPUs5Xq1PESdmo6i6C2FVmnHayQeufLgk7ysX0lU69+EuMgekx1gAcYHjIy4yB4mhZCDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892104; c=relaxed/simple;
	bh=+I+q9+eUa8hRfxKUzqOUUS+N5hiRdn/xsxp49a2Y2RA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nyPaXvhrdmj5U1Mh2MHwUjAuGIxGDvTqVGC2aKS2Nxwl/n4BeyljbKRGTZhxGe8/sjsqu10x4r8ZY3Mxcx83Ff/TT9dI8kzonh5ptaBNo+9K5ilBEl4NLgZnNw6tifxIFEzQl7cTHOe1JRr1Dl6JnnIBHaDrNSvhjj7nrI5pq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzRfI9ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935ECC433B1;
	Fri,  2 Feb 2024 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892103;
	bh=+I+q9+eUa8hRfxKUzqOUUS+N5hiRdn/xsxp49a2Y2RA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hzRfI9utvFbYFS5c6vTQ69tGEahpEDvmXXHzBU3/2zItzcgaHUEtoEaRHFsbhQm+Q
	 PdYAtgXjHezf1WwQRObjKh/X7erEApntEfyT980WrCugFzpxkYWVrkgh4HqQZTYK42
	 qLMEk6ynuFaus7CFT/pYAqfWbQvkZ4c/yRhKu7eP1IJ2+STIAHoYExyTUixgZ2yNoz
	 696TQPhvr6uYuGMDlNWmOMaTs3QhQdM7AgxOx/WHSOqIh8DV947gr/qRQMUhuhKVud
	 9TMmunFxz3yb7UNd/j/wi7l4o5bzrZ1/5DoMiS5+rXVpw2464Bm0LLeS5p5yWuWb3S
	 TqJ4c1EjneGCg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: andy.shevchenko@gmail.com, patches@opensource.cirrus.com, 
 linux-spi@vger.kernel.org
In-Reply-To: <20240202103430.951598-1-ckeepax@opensource.cirrus.com>
References: <20240202103430.951598-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] spi: cs42l43: Clean up of firmware node
Message-Id: <170689210232.101400.2169458068362789446.b4-ty@kernel.org>
Date: Fri, 02 Feb 2024 16:41:42 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 02 Feb 2024 10:34:30 +0000, Charles Keepax wrote:
> As we get a child node in the OF case, we should also clean up the
> reference, add code to do so.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Clean up of firmware node
      commit: 1e942b5bb18e8a9709a5cb5293b15dd54ed79f98

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


