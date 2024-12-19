Return-Path: <linux-spi+bounces-6123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102D59F7C8F
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 14:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE32A7A076F
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BF17836B;
	Thu, 19 Dec 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMUD0UhB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B11BC58;
	Thu, 19 Dec 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615745; cv=none; b=Zmpt2wxk4wk5fpUOBy0ZspEV/mPN/Vv4CHhV1sD2HcKvO/N6Tsx7Rtln6gsZZlAAzaqgSiWffszzYJiVi21ZPCmGn1h3OVveCDIZ6Jyi8TAYKuSvlF8wfu5AvjttPTAh3bPTfPuxPWHwpypzXRv3FiNhZdQY1ivJr/RxolacI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615745; c=relaxed/simple;
	bh=BodwEG/s3P6E/2NShk1XvM+uIPEsnANNhnnZxJcTT7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k+ptOLOpaiwLNRbqtqTzkIRbg1OO/PhxzoU6ugqroswp8gsCvvtFrV/ZUgsgOufOPvdieU3pI3cKFk5aROtq5UTTXMMhV0L6ePv8QpND+DGDfqBORjoFvqk/MRAs7yz+S7e1xzQa9ywzvok5E4q8BhPsuCB6h6im25JZ6xOkmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMUD0UhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99276C4CECE;
	Thu, 19 Dec 2024 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734615745;
	bh=BodwEG/s3P6E/2NShk1XvM+uIPEsnANNhnnZxJcTT7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BMUD0UhBjwvnBoIorrBlY3odQNadBDjOgWdEwxwfK3rMJ+7NluOYcvhy9NLIRZ76z
	 Co+4FlyIOtmX0/CAx9wAvH2dQoEDJik5ZQ9KEExaXg12ZygauOWaxkIOX8IIezaGDu
	 mBK3+rIfXXYPNbVlQ0pqw1OWItnv+RS6Fqt4HxmFLpr0y+PdY3+GLWmxo6f4alaczx
	 sOcpeN6iuzxrMelvou70olDMXNF013w9288dHOfgZ+hzDEdlxpygiG18ap7JeAt1ij
	 6UfgLtJCeNirjSMS7PxLcJpb6eAe1m5CKzc+0Q9gK3LwnMrqA9L2FmRdeLtUBPOvN5
	 i6ow9TW0DrF9g==
From: Mark Brown <broonie@kernel.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241219010557.333327-1-jon.lin@rock-chips.com>
References: <20241219010557.333327-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Using normal memory for dma
Message-Id: <173461574310.119842.4743816830245681721.b4-ty@kernel.org>
Date: Thu, 19 Dec 2024 13:42:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 19 Dec 2024 09:05:57 +0800, Jon Lin wrote:
> Nornal memory CPU copy with cache invalidate is more efficient
> than uncache memory copy.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Using normal memory for dma
      commit: b69386fcbc6066fb4885667743ab4d4967d561b8

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


