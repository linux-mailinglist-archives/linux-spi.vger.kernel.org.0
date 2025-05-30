Return-Path: <linux-spi+bounces-8343-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE3AC92A0
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3711D1C08449
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30B2356B3;
	Fri, 30 May 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avICfzR3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA72356A7;
	Fri, 30 May 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748619688; cv=none; b=gLQMJ6jbRwVwxri6u1otASIVkuXP/tlvJ1yYV7JsxlhipZjQmhP2aG1nDfClFXtbmVoWiIwx7Usth/7+SVP0/Kn/HKDy6OzP0NzgXLDzzYjB7xZFionxWisDxFEXbPSOWVPYwwq6gwyUp2UqARjhxbN8kS3JY6woBt5bqwboNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748619688; c=relaxed/simple;
	bh=fP3/MPEkqWYTER/4VjVnFo7B5KkWWe1JsVPclIWRWds=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RY6i4OyCg9n32XV+lGTX9uQ9YGN9AdIvvxzpD6gUsTl9tR/Y1mM5awPiJHl1kxTVSaieJpG40QqxOPuaj4iaGdeHlE5F1Ruxodg9UFo+SiHxSNnAqr1n2jgFTvBHymobHas4Kx5mW9SmGwEHs4wiWS4pMO2mbbdL1IYIQSfgDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avICfzR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E04C4CEE9;
	Fri, 30 May 2025 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748619688;
	bh=fP3/MPEkqWYTER/4VjVnFo7B5KkWWe1JsVPclIWRWds=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=avICfzR32NbCcsTtfq0qwiZKQ4S8x26apEq15QNnnkQBSfDKcGwYH5x1ri9lFFLjX
	 Ra3Y3eJhoSAbRo0QygTuZXrV/27pqJrJ6mPna5znErocPb8ZLuhoqpu7u179Pb+z1x
	 pfPLc+Mlyvy9t3i75QiOjD3XiCygZBUcJs9cZt0sJ045BuZtDsob1TD8nLfeUWs5AI
	 1n4u1XlMiIqwo27EV57Cd9alr4Ev/MMIefpvG1T/D6a5LYKA3/cvPwW/A55Mo1/ZCp
	 Td/cvM8FZHt78jTi0OlSdSaWjaPNR5mFagXLUqtwPWckSQeTBKHqZ9lJKdnJpg4QUw
	 qJFOYfIIYZU3g==
From: Mark Brown <broonie@kernel.org>
To: dgcbueu@gmail.com, florian.fainelli@broadcom.com, 
 william.zhang@broadcom.com, kursad.oney@broadcom.com, 
 jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
 p.zabel@pengutronix.de, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20250529130915.2519590-3-noltari@gmail.com>
References: <20250529130915.2519590-1-noltari@gmail.com>
 <20250529130915.2519590-3-noltari@gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: fix shared reset
Message-Id: <174861968637.656925.5551215410725929280.b4-ty@kernel.org>
Date: Fri, 30 May 2025 16:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 29 May 2025 15:09:15 +0200, Álvaro Fernández Rojas wrote:
> Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI
> and HSSPI controllers, so reset shouldn't be exclusive.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx-hsspi: fix shared reset
      commit: 3d6d84c8f2f66d3fd6a43a1e2ce8e6b54c573960

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


