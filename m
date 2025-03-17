Return-Path: <linux-spi+bounces-7178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF5A65E3F
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 20:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C93217D06C
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E71E832F;
	Mon, 17 Mar 2025 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1wLRMfR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748491A3029;
	Mon, 17 Mar 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240575; cv=none; b=UOVaytNtfqE9NviRbhCAPhiNNmD8SKFlb26HfWP+3/iIugk1kayTMPcGs/+V3ZXEXhuy5rdM5mdpcsQEAJ3t0e4Oh6YhBtoMYMtmFUS/TvR0fsfL6Df+t1GIh5lZZxm1VM6jhDXjcwfjFq6ISq4hmP9epTYLZ4ORq7VtO22MlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240575; c=relaxed/simple;
	bh=XiWrz+11kyAWxGygQDy7Vdn4bS1sVJE9smro36D4cec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fhpSFRn0FE+ZdavwDBLQ+Yf3CNaOQjlIy0gVxqK2vHGaHMDIpylIp8UnLi6hXcBBlysdfTT80iiL8uRfnbsAicBWlaalvNohmwneFT5s9IihkzfOzRnEdZ1akojDJiFEwTh8nc01ufNhrc7DJFc3GlBZAEKR/Utd1y70gGehd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1wLRMfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23091C4CEE3;
	Mon, 17 Mar 2025 19:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240574;
	bh=XiWrz+11kyAWxGygQDy7Vdn4bS1sVJE9smro36D4cec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s1wLRMfRHdqnjPV1a91xMW1CsNU18YTG3jwpMwIQGfzineQsA+Buz4zHxHcWydU+3
	 WJweCppkEgNjn53q6CP73f+Z5u8OKMCaVeovxhzrh2TgyVovLFOAfo3rbiBUyWZaBG
	 W/IIlBOkPOhEClWGcwb5WDaqNXzhm1xGYcCBCDxghZPfxz4k69k+Sett4rEIdXeIKQ
	 aDJiSOOtu040UNOL5MdRYWTGg7x9Iovay14bOziD/rhftRu3/CHpfcwNa3f59TuApm
	 yC0z9OX3TJJq3GxaX+ZpfUhTXGJ7++SwkGR/NOQMscXGHRi2dRqFdcR9v66VS1VD5y
	 XvAeyhkaQ3f8g==
From: Mark Brown <broonie@kernel.org>
To: looong.bin@gmail.com, Qasim Ijaz <qasdev00@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250313214545.7444-1-qasdev00@gmail.com>
References: <20250313214545.7444-1-qasdev00@gmail.com>
Subject: Re: [PATCH] spi: sophgo: fix incorrect type for ret in
 sg2044_spifmc_write()
Message-Id: <174224057287.315737.14282458820936385729.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 19:42:52 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Mar 2025 21:45:45 +0000, Qasim Ijaz wrote:
> The sg2044_spifmc_write() function uses 'ret' of unsigned type
> size_t to capture return values from sg2044_spifmc_wait_xfer_size()
> and sg2044_spifmc_wait_int(). Since these functions may return
> negative error codes, using an unsigned type prevents proper
> error detection, as size_t cannot represent negative values.
> 
> Change 'ret' to type int so that negative values are handled correctly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sophgo: fix incorrect type for ret in sg2044_spifmc_write()
      commit: 3c9403f150b70d76198e414d53c95e1698e3f99f

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


