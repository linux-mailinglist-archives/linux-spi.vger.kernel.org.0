Return-Path: <linux-spi+bounces-11462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE789C7AD30
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B0454E05C1
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2F2ECE91;
	Fri, 21 Nov 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzhtlxro"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C21ACEDF;
	Fri, 21 Nov 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742301; cv=none; b=cKvgFh2TMZ5F0yE8eIZxZN9JBTEiB6rm6am0wHD8DwXCDSw/b9aEq8k6lDpDU83tg7Nh6lVP/eXR6mr4GCCy4dWcAMJhGqiLmcpyzMbLBLbhZ6/cyyv1LXigssyqNz/MOAICMYDQ0vt1CCAZmLMHjd1ZNbk37pDZTBzkwE1Sjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742301; c=relaxed/simple;
	bh=M2lWvD94t+QENSK1sKY6MCUn+R1BeyqsTINMW1UGDI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VTpUeGISdwkdD4okS4zJOktTujlMOtMnUveHcaueWpr3qpZYBCMWrPV/UG4UQtwS/MyvxWimRBKUCvu0a7iKy1Vap/xbmq87ybx7zIncEO9Pw31CJsIww+71Th55SuElL5+0xoHyL+8QLeAuDw492ntPLHRP2LjyFLUlB3/L0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzhtlxro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE6CC4CEF1;
	Fri, 21 Nov 2025 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742300;
	bh=M2lWvD94t+QENSK1sKY6MCUn+R1BeyqsTINMW1UGDI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qzhtlxroqvoqq4/zpP5kJST+Hf3d3OGunyEPIgGzOxBKh9KkYMt3m54xI9GObf/RF
	 Lp5+5ivt8Nr5ud0GFEduzfwS/vAXWJc0duTZFwZuwNLrJAw89F9mtgsfNbZxqovoMJ
	 JIOKLXGi5uq1LwSNDX6U9VR/qhYHIpXYflCIunTaVwti7wmhbZKoYX6Mo+XHmg6wam
	 zhEh0akEVgvANjwJcJNWGJeGP7sNj6e5HSPiFJPCsqLCnRiHyXU/k26wTWDKXDxG50
	 pCjeRAbndcxUWKOf8pqOmlxLoWURe4vlvgVfaT5kbgaC0mCMeOKs4YMDRmszFZfeDc
	 aMMNUBCoumGDw==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, rongqianfeng@vivo.com, carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251117030355.1359081-1-carlos.song@nxp.com>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-Id: <176374229925.52495.4055621963901778213.b4-ty@kernel.org>
Date: Fri, 21 Nov 2025 16:24:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 17 Nov 2025 11:03:55 +0800, carlos.song@nxp.com wrote:
> 't->len' is an unsigned integer, while 'watermark' and 'txfifosize' are
> u8. Using min_t with typeof(watermark) forces both values to be cast to
> u8, which truncates len when it exceeds 255. For example, len = 4096
> becomes 0 after casting, resulting in an incorrect watermark value.
> 
> Use a wider type in min_t to avoid truncation and ensure the correct
> minimum value is applied.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: fix watermark truncation caused by type cast
      commit: 9f0c21bac5a8089e74b21d007e26fb4594b10d73

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


