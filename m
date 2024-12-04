Return-Path: <linux-spi+bounces-5909-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C99E3F8A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837B628195F
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0B20C462;
	Wed,  4 Dec 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoQHSMtd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E319993D;
	Wed,  4 Dec 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329520; cv=none; b=FfpfGpIKAqUXR62kmPIw1HYkFT5XcEIrmE8f+6ntLV9yaWxAR1jz5TjO+Lqsy+OwuzLB1UUDLB6RWySx8g/vL8DdhoVGRTysbkV9WM2DWoYXnebfxwJf00Ya7TbERwvodfY8TusXXnsIkliG5BhrTwTcBLXFRDLoDHBLV9gQENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329520; c=relaxed/simple;
	bh=Nc+FOIpt7TbIStp6l8xTivwnrh0gB0h1NmUqHHiH7nA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gtryd7prF5L8DgWOKOHt9g6wlK+zTKRNZntMA3dnJ768RBGi7HKj25BZF+RAj/B1hJSNF6VZOIDqo6qs9VPF5vfJIkqYNlnv4XykMhVJqsmuy4DTMaBm+EyAeU3wS2Dyql0HTpvwK2Gj41bRHfmss1NBtDcWVDVwn3IjWHExbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoQHSMtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25188C4CECD;
	Wed,  4 Dec 2024 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329520;
	bh=Nc+FOIpt7TbIStp6l8xTivwnrh0gB0h1NmUqHHiH7nA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QoQHSMtd4xRonXrPYqRL5VXJnmIHOEMFLAjKen/RG11dUzDEesTySsjhWqTTjzqnZ
	 MAKhvpaB9jZCECSo4t7d+Y0PvsofWNp6HV0LXi31HY1e8g7pAJ6V3F9GU/eCOmyEud
	 DbLP/nBZh5Z07dtyGnM0xXKHJg9nwgzYxsPmnjLR+VYyG6TpI3w1WWaXb5FzgV5Cwc
	 5lTFhVNFjQQ7JgihP759ATsJEtYFrBCj4AY4a7/ZGuwuhq+MQx1t01UDlmcqFDBWvs
	 I6VQBGeeEeiGYCM01I+7vKkhjdk/kh+D/o6wU9l8QfxMikyQgcGyjMKY7KVBJIEfJ0
	 ObcI5NywDCjEQ==
From: Mark Brown <broonie@kernel.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241203013513.2628810-1-jon.lin@rock-chips.com>
References: <20241203013513.2628810-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Optimize the judgment mechanism
 completed by the controller
Message-Id: <173332951887.13421.11537303801053149682.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 16:25:18 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 03 Dec 2024 09:35:13 +0800, Jon Lin wrote:
> There is very little data left in fifo, and the controller will
> complete the transmission in a short period of time, so
> use readl_poll_timeout() for busy wait 10us to accelerate response.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Optimize the judgment mechanism completed by the controller
      commit: 577f1cf76ceedb5fbdc9aca4f712b21864ac15ee

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


