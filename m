Return-Path: <linux-spi+bounces-8342-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A2AC929E
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0514B1C08381
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749D1FBE80;
	Fri, 30 May 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8PUcENJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCCFBA36;
	Fri, 30 May 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748619686; cv=none; b=sid0AkeC/Eq/6ZNt0XH9jF8eCZplDo1IcxMRgdrJ1UBVQYDhEozcb4+YTIoqpBY8/XX/vOgYXNsSf5fwVlr2KPO7JtntTTTi53Shi6z5xrHQ4wyZIA2EtSK4wtqaDg8m8GpCB3lACn+1QmXIqr2D/mD0Kgkpz5zrVNYw7WQqVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748619686; c=relaxed/simple;
	bh=ekMr2FmgaRbVYIAQ+YHTfoWwPcnaFSvWFih63vUeoGY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gvpEyLg6kZYo9Ky1kspv+NcwblA4WZLHStbgSLxXB9nTDOwjIxkCgeNRh7VHIN3F6Tw+PohfsthjOD7mR7KAZJcvisZUW3ZU9BbXiYpO55AVy/eein+E2eJ8QEIfqQdlJgWx64HC7Zh/2hIY22vAaz8BF3lT/UUQKvZgCfBxRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8PUcENJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42150C4CEEB;
	Fri, 30 May 2025 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748619686;
	bh=ekMr2FmgaRbVYIAQ+YHTfoWwPcnaFSvWFih63vUeoGY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=O8PUcENJkdBsLg6FFli0m/DYz4pLVXXIv2o3G79QGabQ9CQ6Z6CxP5GnetFFzA9g4
	 V5Z79NiFUrLVc+wu/XwkisihuhfEvfDNmaXYopAEELyAaU0xs/KuxI0C2Cz6AAZZ6O
	 Ror83PtjRyoC+sOuY2xzJUMYRyQDAvvnofMby3Xt+elQr8Zy9zkINMmXKdbUGb4r2e
	 7dZEm9hPm15RSNErBiH/KmYNDAb9rxAqCo09ERU0H5QC5kPOT1z4vBeJWw/1bsk9QQ
	 c9EVR0XQc0aNm7MI4p3YvuENqgiLmJKNciiWQRa32xcKvoEUihJslDv1Zif+PL05l2
	 9XC0JEAK3zr7Q==
From: Mark Brown <broonie@kernel.org>
To: dgcbueu@gmail.com, florian.fainelli@broadcom.com, 
 william.zhang@broadcom.com, kursad.oney@broadcom.com, 
 jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
 p.zabel@pengutronix.de, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20250529130915.2519590-2-noltari@gmail.com>
References: <20250529130915.2519590-1-noltari@gmail.com>
 <20250529130915.2519590-2-noltari@gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-spi: fix shared reset
Message-Id: <174861968405.656925.4346094688034111453.b4-ty@kernel.org>
Date: Fri, 30 May 2025 16:41:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 29 May 2025 15:09:14 +0200, Álvaro Fernández Rojas wrote:
> Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI
> and HSSPI controllers, so reset shouldn't be exclusive.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx-spi: fix shared reset
      commit: 5ad20e3d8cfe3b2e42bbddc7e0ebaa74479bb589

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


