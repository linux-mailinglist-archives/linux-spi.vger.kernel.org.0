Return-Path: <linux-spi+bounces-4778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9B974621
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2024 00:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B92D1F2674E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400A1AB526;
	Tue, 10 Sep 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+jJWpM+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBD1A2C3C;
	Tue, 10 Sep 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008411; cv=none; b=g5GatZn1rr74goL7tqACi+gxJGFfF/+tu9TajnOLMxLt+tLCs35dNHW5gA5woXKqoaKlodWF6IlVerj3Ws0t61l9JY7EPj0fnxq4Om0EJCb6Gihkanuwgf+28SckLHrBtYE6kW1+EnmLq316lC8iEx5k8DtsvIaitFaTVm1yfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008411; c=relaxed/simple;
	bh=k3mDn171AUzFlZD+fChjSea2+yRKJJxLZt2Bea1T8aM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cUfoMCbLn+PoYyz26zDIzW86g1vO1w/lBgj4U/DoaH+UWC3SlVf0oRr8osJ5fY52phKLxaNvsFB6+Cti/J8+FVD6ZZGGO+N7k5HPry1mK8XLAA9AEhZJHmXPj58I5USHPooffXSNgpST+cTTehJDGoWFOJ5C5n2v2iIPWISFCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+jJWpM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA6CC4CEC3;
	Tue, 10 Sep 2024 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726008411;
	bh=k3mDn171AUzFlZD+fChjSea2+yRKJJxLZt2Bea1T8aM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p+jJWpM+v3FiZW/bN4vJhpxBpuz+inoFGDA8giq1oCr58aj/JDlj0czzHbAnRKAzY
	 ELxDyHUh47XaalnrzOawaIVPPTnnII7FJvaI46rzunzhsuit0PIrdTYmjN4wj5Jq72
	 iWMhR3wM4TWUuuXlSmw09bYMGZ29adLLQiWCeI18pEZ/m7R8EJUUcoI1fjgxKvWULy
	 rRh78kFJtwPRZb+bUDyVpPDZsNsfjBVPEYT/DPzpLFC+MgDB7wgMTO5trKkZmjMB/u
	 nQ07VNG2rjs+dzL0vI+SL1ZWxHduXXZ0ej1aq9kqJof2q/p6U9D0wrkqpLbOcU3/as
	 u++5bUJ4stL6g==
From: Mark Brown <broonie@kernel.org>
To: hdegoede@redhat.com, matthias.bgg@gmail.com, yangyingliang@huawei.com, 
 liwei391@huawei.com, Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
References: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
Subject: Re: [PATCH -next 0/7] spi: replace and remove spi_slave_abort()
Message-Id: <172600840962.1208917.8561132443772433710.b4-ty@kernel.org>
Date: Tue, 10 Sep 2024 23:46:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 10 Sep 2024 10:26:10 +0800, Yang Yingliang wrote:
> Switch to use spi_controller_is_target() and spi_target_abort(),
> then remove spi_controller_is_slave() and spi_slave_abort().
> 
> Yang Yingliang (7):
>   spi: switch to use spi_controller_is_target()
>   spi: slave-time: switch to use spi_target_abort()
>   spi: slave-system-control: switch to use spi_target_abort()
>   spi: spidev: switch to use spi_target_abort()
>   spi: slave-mt27xx: switch to use target_abort
>   platform/olpc: olpc-xo175-ec: switch to use spi_target_abort().
>   spi: remove spi_controller_is_slave() and spi_slave_abort()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: switch to use spi_controller_is_target()
      commit: 1e0cc8d0a14271fbf6a50e680c8020458121a52b
[2/7] spi: slave-time: switch to use spi_target_abort()
      commit: 6adfdf0780a7a8a8b185af62302317ab20f1d066
[3/7] spi: slave-system-control: switch to use spi_target_abort()
      commit: f4bf5454f852b86d3b4be69f058fd36a61cd81bf
[4/7] spi: spidev: switch to use spi_target_abort()
      commit: 94628e5a07e71089a61951eb2d2e13685ff82760
[5/7] spi: slave-mt27xx: switch to use target_abort
      commit: be03763d247649b39e62ec55efecb1e7499e2e7f
[6/7] platform/olpc: olpc-xo175-ec: switch to use spi_target_abort().
      commit: 5b2e4d15154cb75e522701c13f66441e29f2caa8
[7/7] spi: remove spi_controller_is_slave() and spi_slave_abort()
      commit: 740c1c84bfa3d8c63bd3b01fb570e7452f51fbd8

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


