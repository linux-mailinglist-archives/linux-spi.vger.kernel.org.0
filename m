Return-Path: <linux-spi+bounces-4425-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AEF964454
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853CD1F24CDF
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E57192B8E;
	Thu, 29 Aug 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8hpWNY1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0F191484;
	Thu, 29 Aug 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934272; cv=none; b=kEs9C7AEW5tXgHigAGi1heAqmzpeW4TeembItjPuhy3YrTk3yYB4a56AFWM4qK3/xjFtWBU+V9/ZyHvZuk4HL7qJPK67ORW0dNFqZhH2sv9kclnPu/13zQC0aZGUxkVGZzLY/XgqIbR+lmdhKHHhSJ7/KdXZIRS/oigp4dwoTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934272; c=relaxed/simple;
	bh=8q5dePvHecEGWISUoUyB9pSR67Uw5EVyugueLsakF3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LMQBjFKUBPVOYIN1J1rHbqm6E6wj/r8E45Lg0M6K0G6vSn7Vw+YkhfPlZ3McgtePf3/15Fd4Sn0KAQhuFxOZhv278/3DNPR2dcFne3MqTJ7hfrb5z3SGPKM3czZbVKZD9GYQM2IV/+AAeg4Vr4H6yDjrT3yYWrEL8dGbE5rOQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8hpWNY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA5BC4CEC1;
	Thu, 29 Aug 2024 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724934270;
	bh=8q5dePvHecEGWISUoUyB9pSR67Uw5EVyugueLsakF3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J8hpWNY1cCk7W2ZPRTJzMmu2RWAeCMLJU4KUtr/D048++ZwY8Kq9TYJ6A3aKs8wS9
	 gvJWOucOayjghBUSD8g1Y8xbetYqai7DXwFRwXzk1daArAsqyOJJebN+YPcDu78IhH
	 1/Q9XUUTKobNN22HCXINGIMzEYXohuvN/KF32p4YeGMmhQkkYnSzPQs9aEd2k32T/5
	 wpImGE27kOKSA/jA7CJDQNs6dPXq8oo8FKll8qwOFHYsLjlbAQSVCx+WZro1hhBCaw
	 BTM5RRM0bfGBDBsFIwM0E4drhsY48sHhMxujnCxmZv4+xYm0v7fG4i2k6zfpTInMoj
	 X17c6izstukrw==
From: Mark Brown <broonie@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Jon Lin <jon.lin@rock-chips.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, stable@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-spi@vger.kernel.org, shengfei Xu <xsf@rock-chips.com>
In-Reply-To: <20240827171126.1115748-1-briannorris@chromium.org>
References: <20240827171126.1115748-1-briannorris@chromium.org>
Subject: Re: [PATCH v3] spi: rockchip: Resolve unbalanced runtime PM /
 system PM handling
Message-Id: <172493426855.31273.9511769608557747574.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 13:24:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 27 Aug 2024 10:11:16 -0700, Brian Norris wrote:
> Commit e882575efc77 ("spi: rockchip: Suspend and resume the bus during
> NOIRQ_SYSTEM_SLEEP_PM ops") stopped respecting runtime PM status and
> simply disabled clocks unconditionally when suspending the system. This
> causes problems when the device is already runtime suspended when we go
> to sleep -- in which case we double-disable clocks and produce a
> WARNing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
      commit: be721b451affbecc4ba4eaac3b71cdbdcade1b1b

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


