Return-Path: <linux-spi+bounces-1091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4684B4CC
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 13:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4211C2111D
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97E137C4B;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfGM1OFY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44513137C39
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221362; cv=none; b=AGQE4q1Z8sC+HIaPPZDr/UlIYaHok8a/APpE0cZbujjWLyf0S7OCExENmoR2/LjzSeKi6C3+E3lVawzMw3QGWDNECM0282xu4+QeSTLgWSVnAcagBkpy1tvXZxfZsOY1BI4kKeH2eXIcF62If3aPGX5FMrO2PuohaM4Op7n/3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221362; c=relaxed/simple;
	bh=bhzjs8R7sbGn+87s1FW9V15rI90gCXYsB4OLyhnwb+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=msOUnIdGcfqp0e6/VoyE5D/Dtjc07yrTIhYTSX6nJETlsT3ZNym1CBV4T1zPZ1YuORW7PBhB30Jh+8CZemN0HV0iX4JSfWkPdj42vWjFZ1jcqAL3kzDGXZHHlqvHdfbzVLLk7rubZeH/1Pc5lQ/dIJLF8Kxzdjrs19KByYTUcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfGM1OFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2143DC43142;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221361;
	bh=bhzjs8R7sbGn+87s1FW9V15rI90gCXYsB4OLyhnwb+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bfGM1OFYU4HkcmBMBddbA/WPbkmm8Sm3dEMhc36T8tBLGium8YmlmZrNB/nl6Xrqh
	 rOQ+hVKxL/cOVKOHGc6qa1u5T9ZElmXe2Z5BdEf/grW5faIAAFZK0eeNEiJj9re+4D
	 xQnXMgvt6PEDO83IPp/VDuyvTalhUyARsOOy7ilLUONORRBhzekD3Pi3z/vOFfDzB1
	 YMQmQoMU6VfkaAdWXcvnrYMnDixCKCJ21IWLfGcfG/gZCDnPdLr00G6cs30wZEIpt6
	 kZnMuOAO4EGcsb48EAxDmXpwofmFiTEm77w4lhpHufziLvZCTxS3RsH++PlTVB3+bE
	 hZH62IbetfUkA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Luis de Arquer <ldearquer@gmail.com>
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 Robin Murphy <robin.murphy@arm.com>, luis.dearquer@inertim.com
In-Reply-To: <4d18808e85b85077761c5655083f20ebfd7d3770.camel@gmail.com>
References: <4d18808e85b85077761c5655083f20ebfd7d3770.camel@gmail.com>
Subject: Re: [PATCH 2/3] spi: spi-rockchip: Fix max_native_cs
Message-Id: <170722135988.992289.16551970004382399267.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:19 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 26 Jan 2024 20:46:44 +0100, Luis de Arquer wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] spi: spi-rockchip: Fix max_native_cs
      commit: 07d6749317bf8cc416fb7eb8f997a884bd610f8d

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


