Return-Path: <linux-spi+bounces-5993-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E489EB196
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 14:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF58C16BA26
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016381BBBFE;
	Tue, 10 Dec 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9T4xDGu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B41BD007;
	Tue, 10 Dec 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835658; cv=none; b=gpyP+cwbVkEOvmp0aFisb3atbYKayAN3OLjYiqkwfDZjjaHcbXe9fpJ82BQgeKIPQFrOlf3dwkHyuNOUjcF+7Dtuol9X+u5DRnng6kEyo3bgQXNNJrnTdrjgadAXdDjOK3cl5bI9LYatmDdewwcurlTSV3J4r2dOLFuYfJGzLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835658; c=relaxed/simple;
	bh=PscAXMBIQetj/AnKbhFQ+vclBqKg8Pff7HND8t1S3b4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=noDWpkhp51fWviLlC565+U38ichEd3tEU7N8jiocLfYH2FI4blwQmXnYlTNAopTYy/Gxyph0/Qhm32PXcGzFGTMIXy7zXdwnwVnHFv3oHir06On0bjyGeI/Ls+tjxJ/fV65ncZwc7ogXr67rUKeHr44F6QHmnFAIHyUxcUdKMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9T4xDGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBAEC4CEDF;
	Tue, 10 Dec 2024 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835658;
	bh=PscAXMBIQetj/AnKbhFQ+vclBqKg8Pff7HND8t1S3b4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O9T4xDGuixTk6epsbO2omxilM0DXSGdDmcLNfTaTgUJOlcarSeotya7Mu7KXDmNOL
	 yGXeB7TZRigpnsng+gtu9ZLhL4oiMYaRe0cwKN0o4ptDWx+MWaUp+3+2vRW3dBEvq7
	 YtGSmxcXYdFueQ9j6FIPk31RrUzX4qfMsAkCyzXto1FwKxyqdTlgu9Tvte3GRYCBGR
	 ur0sFkyl0cs+fam8qpUYR0r7y3n0+cCBgxQgTAKyYvVZA4uhwvmRWzVf/EvPs36u7G
	 a/7kOakzdBzh6QUjAIO5FHyGR9d2IIa2r8MIz67YsiZMR9xyfHiIu4XWaWmzfij1Rx
	 r+HhN+Hu1ExCA==
From: Mark Brown <broonie@kernel.org>
To: michal.simek@amd.com, linus.walleij@linaro.org, 
 Mingwei Zheng <zmw12306@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jiasheng Jiang <jiashengjiangcool@gmail.com>
In-Reply-To: <20241207015206.3689364-1-zmw12306@gmail.com>
References: <20241207015206.3689364-1-zmw12306@gmail.com>
Subject: Re: [PATCH v2] spi: zynq-qspi: Add check for clk_enable()
Message-Id: <173383565712.34030.16922746389125728063.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:57 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 06 Dec 2024 20:52:06 -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: zynq-qspi: Add check for clk_enable()
      commit: 8332e667099712e05ec87ba2058af394b51ebdc9

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


