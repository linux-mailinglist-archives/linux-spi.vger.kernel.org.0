Return-Path: <linux-spi+bounces-3588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B5917354
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 23:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E942858DE
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9F12EBEA;
	Tue, 25 Jun 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PksWNvkU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8733B7A8
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350586; cv=none; b=HFBcBMhuwnc13J2rFboDr7EzMmq5ZBwQ0FsWjkVN58hnIpwEOOdWhCfhCrbBJSymujRNWkY86AyEWJo0LNfXCKR3bR2XDPJoEIVvyHATRmE7QIjEDIXFG4d2KTruZJnvUJTpaX7xTaoi8inbMzhyAE8kyXwhUmZrMFF1v3kMJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350586; c=relaxed/simple;
	bh=wCp8sxOpfMcaTD+OUNFc26DDcTTNWOcxTDU6BzqC+m4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SVjj92B9Y312h/TtxsQOvpCJP6++yZAr4ufjnxCUra3zb/EzGsCKOyup2HnVvQREdDuKTlsDTNCKDAICBSOcdS8CQQSwl4xgemFXg2zf68/HIZEUpj3AVMdGXirBgDDrWMlgvZtMUc0JFVFV5iIq7MgHauLb7Nir5pTnRYET3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PksWNvkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC0BC32781;
	Tue, 25 Jun 2024 21:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719350585;
	bh=wCp8sxOpfMcaTD+OUNFc26DDcTTNWOcxTDU6BzqC+m4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PksWNvkUyKhwxjIpUFRgjYoaTfY6VecmRrksEDP9bb4JUDjsjQbsLjZidZPBS0/XK
	 TNy8zyMJAwHX2u3Sj1dAwodRxrM91jMEx4iCuy3eNEwXfy3myi7ZYjlN/g+awbOeZ9
	 f+FzT8ChwSj7T1I9rasdjbmcHzFhocSNgpXNlcIcUDpI09Rqg3wWrpuRHPVhFX9nxk
	 1YxW2Lh3LEgH6EAukQpXYGn3Ugwf3Fr3uAKModFy+WoVlDd4qRsWaJnoWSkmitsJw3
	 8zlCfUZRu0atFwBO1yuYTR2+Bpg2nGyNe/etvcYGsw5l+J4+fxVWJ9AlRRH0olxAXe
	 x8iUx7v5mEhWA==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, Fabio Estevam <festevam@denx.de>
In-Reply-To: <20240625183919.368770-1-festevam@gmail.com>
References: <20240625183919.368770-1-festevam@gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-imx: Pass pm_ptr()
Message-Id: <171935058455.1254277.17259597027934894179.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 22:23:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 25 Jun 2024 15:39:18 -0300, Fabio Estevam wrote:
> After coverting to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS, it is necessary
> to pass pm_ptr() to the PM operations.
> 
> Fix it accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-imx: Pass pm_ptr()
      commit: 2d4e40dcdc5590550704681f1b147c3dadfdbf31
[2/2] spi: spi-fsl-lpspi: Pass pm_ptr()
      commit: 14201399457ce5314224c2898c936bfaa5849fcb

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


