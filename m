Return-Path: <linux-spi+bounces-10484-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A8BC7161
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 03:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B119E3F2E
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A01F37DA;
	Thu,  9 Oct 2025 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5N8+h+/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF801F0E2E;
	Thu,  9 Oct 2025 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972043; cv=none; b=IEdaUD9EJzDi7pIoSgBG4SbVFY5TPDlRLsT5fzGr3GmqbEksCOUBSVwSOWet8tNg9tq6Ysgt13fb8t6TEweohlQTIyKAGWm1k9pXkeDmM32dpnAq40MrlsRET+CeYs73M/PVzVZit2vl09xieCk2p7pT+pnmlyzDl5zNJwwfXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972043; c=relaxed/simple;
	bh=8SQsDQoloTxTr71LaWPc56p2Al3DqRO/PNTgELW/Rqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O/Xazw5FzstXePovjl4HY36kDx+VIi0U6j2tM681V38CKtGzFUYEJVy6Y/QmRY3TPbtmgiBfchpggIzsQ4pxEM0mwo8n0PFuA2rF0MCJlVtEJJnVzZDNQm/u18e8c1EKjSjMCjqtpOSTBsfPGfnfb1urmGQR/AKExuONwCDZQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5N8+h+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B32C4CEFE;
	Thu,  9 Oct 2025 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972042;
	bh=8SQsDQoloTxTr71LaWPc56p2Al3DqRO/PNTgELW/Rqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h5N8+h+/J1jXv++dgDIauQcFpu8xcohWpSqElhPUngssaN+blZLXv83TBTDJTGByB
	 g7CPPClrkwY+JVC0iBk9rOOxYj84NzrZCifKBdPItESNFWSNwSB+DzF+LeX1k0dedr
	 9lDqOe/SLCPLi5DhGQTPGuinUmeoaB7eMapsntqh3zKpF714QDX2b0uxUfpkHChyjf
	 7aHz3/+xov5Bg/nYoRtH/OgSTlC1jrT1WlmHe2ynHJ9COHdLSsVfFxOdWH/OPVjFiS
	 9wb2j/cIzqDsaTa1xmPgJZsjXHngKE4k6EEI10fcmkB4BCYRAovIkJ7ycYxsEmssWQ
	 yNU3oH1T6Lu2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDE3A41017;
	Thu,  9 Oct 2025 01:07:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/6] spi: Remove the use of dev_err_probe()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997203075.3661959.13983624116098440178.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:07:10 +0000
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
In-Reply-To: <20250819092044.549464-1-zhao.xichao@vivo.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-riscv@lists.infradead.org, Raju.Rangoju@amd.com, broonie@kernel.org,
 sunny.luo@amlogic.com, xianwei.zhao@amlogic.com, conor.dooley@microchip.com,
 daire.mcnamara@microchip.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, daniel@zonque.org,
 haojian.zhuang@gmail.com, robert.jarzmik@free.fr, andi.shyti@kernel.org,
 tudor.ambarus@linaro.org, krzk@kernel.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-samsung-soc@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Mark Brown <broonie@kernel.org>:

On Tue, 19 Aug 2025 17:20:37 +0800 you wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value instead.
> 
> Xichao Zhao (6):
>   spi: spi_amd: Remove the use of dev_err_probe()
>   spi: SPISG: Remove the use of dev_err_probe()
>   spi: Remove the use of dev_err_probe()
>   spi: mt65xx: Remove the use of dev_err_probe()
>   spi: pxa2xx: Remove the use of dev_err_probe()
>   spi: s3c64xx: Remove the use of dev_err_probe()
> 
> [...]

Here is the summary with links:
  - [v1,3/6] spi: Remove the use of dev_err_probe()
    https://git.kernel.org/riscv/c/2aade32d1ffc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



