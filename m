Return-Path: <linux-spi+bounces-7875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DC3AA8362
	for <lists+linux-spi@lfdr.de>; Sun,  4 May 2025 02:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE267A19ED
	for <lists+linux-spi@lfdr.de>; Sun,  4 May 2025 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4936B;
	Sun,  4 May 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcXOP8pP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDE18D
	for <linux-spi@vger.kernel.org>; Sun,  4 May 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746317162; cv=none; b=qB3I+1DWjoagPb+bxR/TgNxPx6z4ps0nRMa6bw/g3Kyomsa1gQXUHGSOb4EIdYUx7zXwo9XSX0FX1Ut2thlDqb01WAXSDmXbJNmu8qqRgh2iHs1xTFeZ3onG82H3pzUhrrMUWRcONtKXx/XwR/70NXAou+nJTa+5wlYRUiW+gUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746317162; c=relaxed/simple;
	bh=0Vrp+Ur6ISOTzJlrzOPXGRAgwHCJ1gHHY5mb9EEyYeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SFQ/e0ux6TSHwLLlYbPTnff6qsFPCmdSg6hekksBEtcTu5AUKwvLi+6WPGbB937BusVS6xL8SGZKznQfR42NshFVLtHTW9qI8us1TRsZwPnDV8G6zGBtT2ZiwjceaN++sSIgsMtFo6qt+n+p2/BeOutscCRGQetlVggz94n1gI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcXOP8pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41341C4CEE3;
	Sun,  4 May 2025 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746317162;
	bh=0Vrp+Ur6ISOTzJlrzOPXGRAgwHCJ1gHHY5mb9EEyYeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RcXOP8pPYTOneCRD0XmLHE9DsNb5CS9qOf+duwEUUxC+XAbCLdX0Juy3aYsCxv/o5
	 JFniwOLPL/iLhZGwrk7BZcp/IvXokMHbfeTRGDuXaOSdGj/gGFkHAx5AOiQL4Yzcf9
	 EW6vwsPPBmd1cY2lE420emi42l/bQmi3rJzfHyhFLe+J11t4CLdKFBib2aeydW5kvy
	 swKKhMHhbZG18MWxlt+UiUsiELI9Acb8xXsJx8XkvxC7jzOl683Cz9lkEYlZbzKDqV
	 P5zUK5kv1dV+UZd9EupeyR/XYAOK8zRuvOyhQzartYKqS+cYAIzjw/H2SVhrZ5zrP2
	 eDCeEXokDG2FQ==
From: Mark Brown <broonie@kernel.org>
To: Martin Sperl <kernel@martin.sperl.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <da612090f543c8c7cc99fb9dc6ef4abc9560abe4.1746184293.git.geert+renesas@glider.be>
References: <da612090f543c8c7cc99fb9dc6ef4abc9560abe4.1746184293.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: loopback-test: Simplify strange loopback value
 check
Message-Id: <174631715990.4097732.7258246864070806147.b4-ty@kernel.org>
Date: Sun, 04 May 2025 09:05:59 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 02 May 2025 13:12:39 +0200, Geert Uytterhoeven wrote:
> Apply De Morgan's Theorem and drop superfluous parentheses to simplify
> the check for strange loopback values.
> While at it, add the missing zero in the related comment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: loopback-test: Simplify strange loopback value check
      commit: 233d740e3a819829ccd6d21319015a94349d64eb

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


