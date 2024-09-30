Return-Path: <linux-spi+bounces-5058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F898AF48
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1421F22D49
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051F1836FA;
	Mon, 30 Sep 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz+V042b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E917BED0;
	Mon, 30 Sep 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732518; cv=none; b=VxpVHEK0nRaU/FCWhaKz82PdsN6APQn/c+jAsQfjtP2WttA+6vXaFRbwh487GFLF7AsRupA4M8KUcOE9NzlWcagrkJhPNwn/bhN5MhIpYk2zR1tG5fDLxyeY8GdlXAPs6t4BlyfP8U9SC8uGXXGVGLe4byG4IY/CKnqKfuOvqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732518; c=relaxed/simple;
	bh=kIzn169MtkAN2HkACFY2/QLGHvP6gz+0jEILgzg4yRk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aakuueIwpBTE55aK+Wh1WjZ0qyxOLrWGjxLI0/0pa5pp5+yBFEngU4pmMQtwHD33Joi3Sr5M1QkD0yaOYa2kSsbW5mkgq5O0ML3WE1jmalwqANd6roNY/kqnQm1S9xEUWHD7Sn0Wlgr/F3cTma/3S0dUHBaZAHZKmNtUviNcWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz+V042b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA78C4CEC7;
	Mon, 30 Sep 2024 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732517;
	bh=kIzn169MtkAN2HkACFY2/QLGHvP6gz+0jEILgzg4yRk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Pz+V042b6rXEpNih3/+gmWjUnsCGl51v/kHvAB5+rPy2uk5+5gZnN6Es2M3YSxRYf
	 SoM8j6K2s1LzwyO4K89jQEJeT/CnHgtBi/uMpMkvAM9AUknJZuouh8H5wZ8cU6xK21
	 MehTJyMzjkzD9/Dc8KbvEPNUtfmFOoRAPPl4Bg45Up5ZNeU4DUKZufrSwz2jygj3ZP
	 +CmX124h53+HP8mBAY1LbFnCksgl+cQ88hzYy3aal7sQJqKtnpupBPhOFmk3773LEq
	 5W7Iab4P57IvGsbPaZQL95dvtswF7tqR8XyVRTL7r7WGHp+A1Otc+P64zgnydVIO2b
	 KmInww/alZpUw==
From: Mark Brown <broonie@kernel.org>
To: xiaoning.wang@nxp.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240906022828.891812-1-ruanjinjie@huawei.com>
References: <20240906022828.891812-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in
 request_irq()
Message-Id: <172773251643.2210210.10683436336684726945.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:41:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 06 Sep 2024 10:28:28 +0800, Jinjie Ruan wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
      commit: 003c7e01916c5e2af95add9b0cbda2e6163873e8

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


