Return-Path: <linux-spi+bounces-10919-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7304C20C9C
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F9764EAE71
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CF1E0DD8;
	Thu, 30 Oct 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snP6zaDJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF727F015;
	Thu, 30 Oct 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836069; cv=none; b=l98pb4r0JmThJnOxof84EAHJNYDiNElzNBDh9DDciOgULAwYT61JdyFvYHCW8sNKTHu9xCcCZoJmPO/1FOYSBw0iYe1GtAHyZu81QRy7DmY181XL5E8b4Y8JXva5YK6MP+8XMitmMngvPf1QlQYk+OwiWY+OwgsyuYLeVI4rn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836069; c=relaxed/simple;
	bh=wtaOLqUufjz7lib9iMWLB8MFo/leqWUABYZrBbdtKmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X2WKhwKJKzt3Ga9JgjJ6ib77829ymq4107ZOuXr12Mj3JNvESAqhrfxrNLvy2dlDCrXHrIrY3Z5iItP8EyLb5vld05aYTIhgmVOUpIvp1o5JvRdrs6lC6HfBLPUmAspdYVQnKw4V+nLdLFWQrtq9BY/+9hsK935NZPFhoDNQCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snP6zaDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BF0C4CEFF;
	Thu, 30 Oct 2025 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761836068;
	bh=wtaOLqUufjz7lib9iMWLB8MFo/leqWUABYZrBbdtKmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=snP6zaDJBWor1jlhfqKdV7GdrgEaHZPKMolO2zHO7kSyEWuVBS3q40AHnVDLBJ3Qw
	 4GkCRHFghJmMgopa+P3t6O5XiUZKuK6mC3kissCrzRNBleseSxPXg7WJtDc6qAORMP
	 PUt/Gu3lUguWvGI1mN65xk4XYmC2YzjSPqbJwoxcmWiwK6uAohZekvulhIeDk3AOYd
	 bH22D1yWNA5OVDL1jOtc7F9xdrPdcJmLPgpngrj/E5uvL1bmkEYyrZmgYFE0j5KwTa
	 mWJ1vUXsyYLNVMpnajhbEGg7lDguemVNH3fiCyM+kblEI5ye8fkD5Xk4kLvdJq4yPD
	 rLi4boefa3Uzw==
From: Mark Brown <broonie@kernel.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251030124755.1828434-1-zhongqiu.han@oss.qualcomm.com>
References: <20251030124755.1828434-1-zhongqiu.han@oss.qualcomm.com>
Subject: Re: [PATCH] spi: tle62x0: Add newline to sysfs attribute output
Message-Id: <176183606744.67987.12357488709998439720.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 14:54:27 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 30 Oct 2025 20:47:55 +0800, Zhongqiu Han wrote:
> Append a newline to the sysfs_emit() output in tle62x0_gpio_show. This
> aligns with common kernel conventions and improves readability for
> userspace tools that expect newline-terminated values.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tle62x0: Add newline to sysfs attribute output
      commit: ecd0de438c1f0ee86cf8f6d5047965a2a181444b

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


