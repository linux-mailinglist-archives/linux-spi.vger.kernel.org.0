Return-Path: <linux-spi+bounces-6240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C0FA03E65
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 12:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF723A5201
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399D1EE7C6;
	Tue,  7 Jan 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaoM5wfX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944D1EE7BC;
	Tue,  7 Jan 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251104; cv=none; b=tygcRdzdIgX5kcx1IQTcN7SHz5mq7HQwlAuDHvMXxwFaJSqrHfo0zcuCIuq+xen5zBjXorp7+aOzc5IKWiPYX9mTWMe0+2m+C3PDnX4g9SBh1ipOuRsJt3v7XlaF8+NloTqHZTmrgEl5zQvesk2l9WHbZyLhCYjQTrQzUrOy7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251104; c=relaxed/simple;
	bh=JHRpYXNzTasLGOx33u2irRAWwer3YDDAnZyLXm0wAk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KxXImy0e3MIzRUAKv4CFkOSMPLztfiL+AnCwzexzEKf/17LUFB05NqnZjTMEqMLkGcbAlpGYAodn/AEaI8CTij+ZXK7nDqbhsXOd3PSN3tJT5u8s487iUQvh+ilgWhFM+aao+DviYoDGuVH86TEzLkNhRLXXbzaoL4w4ZLVFan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaoM5wfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BBAC4CED6;
	Tue,  7 Jan 2025 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251104;
	bh=JHRpYXNzTasLGOx33u2irRAWwer3YDDAnZyLXm0wAk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RaoM5wfXo6eVfWrThIoBURxwQmBgYs9zHZgSpVc4tbaEKrpl5CpO7qkY2+GtbPDa/
	 QEPCFMm6/KMi2I7Nyx+IYTCINU5OJcgmdha9r7x7dAsMiBc3eycuEr9Ozg2XcBcsPD
	 Jt0mW1yJnbCG/Jqjld87rNaVhjtMMti4owMSktUc0mRP63u8JeVzLeXz7bGgzZhHqu
	 D5JSPky5ThjHtrrT/9GeNM9G7QFoThi4L+sQmGS9nm/LV5oXrUgZ4AzN4x7Onk5ker
	 5prw7/KmSoBz7WqvNzP3wZGuuYPXZ7ngD31A3dUGjAdlxMDmoyZDQ79uB83zuWVDWB
	 wcmUdtKVVJsgw==
From: Mark Brown <broonie@kernel.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241219142216.2123065-1-jon.lin@rock-chips.com>
References: <20241219142216.2123065-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Support sclk_x2 version
Message-Id: <173625110270.23847.15036834629603583307.b4-ty@kernel.org>
Date: Tue, 07 Jan 2025 11:58:22 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 19 Dec 2024 22:22:16 +0800, Jon Lin wrote:
> SFC after version 8 supports dtr mode, so the IO is the binary output of
> the controller clock.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Support sclk_x2 version
      commit: af103eb7d7d881cf6ff7414242bce2d8e394cc32

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


