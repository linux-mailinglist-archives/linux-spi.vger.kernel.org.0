Return-Path: <linux-spi+bounces-5453-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0C9B017C
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 13:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C9B218DD
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A531FDF8B;
	Fri, 25 Oct 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl3O2XqW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEA1C9B62;
	Fri, 25 Oct 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856421; cv=none; b=GpR4I7v83z/JwwSAN4iAIGVDPKdpEd+/hv7yDxBJhLom2XCO7Cu6Ub+XEX3p1z4zP7IJUfXUG81qSydzGezDTVItrAoPZkml/sL3XE0DM8fuptTlnewWYGiFtX3ljdrOXKnmieY8NGENPeSaR03vU0XOot72tauWzZPpjq2lT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856421; c=relaxed/simple;
	bh=ofSPYgFrnu8JAd+kBqIWgAgIW4Xr/a4YZqs3eSHQFog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TsAXkIxb0tmXC8YZ2pgyjRQr5L2zSH+aZUQ+VauOchR7znaavNwXL5XYQQkdLBrn4Y70HU1nsha86ZEw9SwZayeCKxWiD7C7FGHWN2umuLu/r/vO2T94H8CezEh93iuIqHOuRq2VqgwxGv7ovnRosAYXycsPD6MJt1dgO9C1su0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl3O2XqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDEAC4CEC3;
	Fri, 25 Oct 2024 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729856420;
	bh=ofSPYgFrnu8JAd+kBqIWgAgIW4Xr/a4YZqs3eSHQFog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Sl3O2XqWZDBw8pmzVtZwnlZBqE8CmJK8JRlxrWtudGBdlvwZ2sKJdvVQ2aKboogSe
	 yzL8RDCiLjk4k07dUK2ntF7ERHNQs6v7JH9pHtSJTFErM5c8MjEF3Q5JCHO11aK8kV
	 wFS4Gwl6gGiYYQHLhMjofLamNC8b7GmI0lOA+sCPIwGescFrXHx+ve206nboo60rHU
	 BNtG2cCOsU+4OnMj1mVRlPIPVGLqmPlpT6fyLyNzG+WY+E+UHat7sMtHMZcMuPqaMi
	 TETDLEGyZJz6B/HWqeXcr+E6yOiE5PUtNF3VFkIgKHy+v+1TaicWSqH41kLT/xEt7T
	 sTWGRMmbuWXQw==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Dhruva Gole <d-gole@ti.com>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20241023203032.1388491-1-Frank.Li@nxp.com>
References: <20241023203032.1388491-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] spi: spi-fsl-dspi: Fix crash when not using GPIO
 chip select
Message-Id: <172985641837.7496.8327028410387327926.b4-ty@kernel.org>
Date: Fri, 25 Oct 2024 12:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 23 Oct 2024 16:30:32 -0400, Frank Li wrote:
> Add check for the return value of spi_get_csgpiod() to avoid passing a NULL
> pointer to gpiod_direction_output(), preventing a crash when GPIO chip
> select is not used.
> 
> Fix below crash:
> [    4.251960] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    4.260762] Mem abort info:
> [    4.263556]   ESR = 0x0000000096000004
> [    4.267308]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    4.272624]   SET = 0, FnV = 0
> [    4.275681]   EA = 0, S1PTW = 0
> [    4.278822]   FSC = 0x04: level 0 translation fault
> [    4.283704] Data abort info:
> [    4.286583]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    4.292074]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    4.297130]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    4.302445] [0000000000000000] user address but active_mm is swapper
> [    4.308805] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    4.315072] Modules linked in:
> [    4.318124] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc4-next-20241023-00008-ga20ec42c5fc1 #359
> [    4.328130] Hardware name: LS1046A QDS Board (DT)
> [    4.332832] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.339794] pc : gpiod_direction_output+0x34/0x5c
> [    4.344505] lr : gpiod_direction_output+0x18/0x5c
> [    4.349208] sp : ffff80008003b8f0
> [    4.352517] x29: ffff80008003b8f0 x28: 0000000000000000 x27: ffffc96bcc7e9068
> [    4.359659] x26: ffffc96bcc6e00b0 x25: ffffc96bcc598398 x24: ffff447400132810
> [    4.366800] x23: 0000000000000000 x22: 0000000011e1a300 x21: 0000000000020002
> [    4.373940] x20: 0000000000000000 x19: 0000000000000000 x18: ffffffffffffffff
> [    4.381081] x17: ffff44740016e600 x16: 0000000500000003 x15: 0000000000000007
> [    4.388221] x14: 0000000000989680 x13: 0000000000020000 x12: 000000000000001e
> [    4.395362] x11: 0044b82fa09b5a53 x10: 0000000000000019 x9 : 0000000000000008
> [    4.402502] x8 : 0000000000000002 x7 : 0000000000000007 x6 : 0000000000000000
> [    4.409641] x5 : 0000000000000200 x4 : 0000000002000000 x3 : 0000000000000000
> [    4.416781] x2 : 0000000000022202 x1 : 0000000000000000 x0 : 0000000000000000
> [    4.423921] Call trace:
> [    4.426362]  gpiod_direction_output+0x34/0x5c (P)
> [    4.431067]  gpiod_direction_output+0x18/0x5c (L)
> [    4.435771]  dspi_setup+0x220/0x334
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: Fix crash when not using GPIO chip select
      commit: 25f00a13dccf8e45441265768de46c8bf58e08f6

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


