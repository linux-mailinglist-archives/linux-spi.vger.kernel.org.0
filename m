Return-Path: <linux-spi+bounces-11282-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EDEC6BF56
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 00:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D4364C2E
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819A30FC2E;
	Tue, 18 Nov 2025 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVXJGIiU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8C2F9DB1;
	Tue, 18 Nov 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507708; cv=none; b=KrwqJppFeaCqRFabp8XfU/hqRLOtLWZ5w0jZ37RAhz+K0Dgl/BZ08j/oc03/taUZjIHptJhiDCr7RRR8OX8mkf359so965OUf3ZJm4hCJF9k2s0abRSAW+wCuLF425pFQMxiuJVbqmH4t1bmdEePZnkwGYU2WiQAv/2axXASomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507708; c=relaxed/simple;
	bh=wjOnpeSH0cShWbz8Nnic7ZJoqey1D4fTZlYzuXxqIYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SoNMFr19wm56q8y2IgTa1KPEQ5PxGOfXEQ/uO/K6yP3eXWuavVh++EGoTWurRxIlt4ZSo/V+ML3TOCUbFHWrecl2Sri3od2MGpSQa786oPiEkZNQyOLpW7Jisbg2kKatz6vSWvzmg/zAW57GTJk8F/7E9pWm0fBXmBFlkg6eQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVXJGIiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE5CC2BC86;
	Tue, 18 Nov 2025 23:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763507706;
	bh=wjOnpeSH0cShWbz8Nnic7ZJoqey1D4fTZlYzuXxqIYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YVXJGIiUstn9db05v8svunLc10N5L2z5f6bUyFCZ3TydbqiOHavDr2NAVBlAJUFZ6
	 5mLv9YkW8Vrc0goXkUN80NS0TUigWpCs6jqJLVdbSOjx9HBOjZiQOEeL5P0+anfch8
	 Yan3SgbHnq3K/WiqOX/jNX1pbefyVjDz4ds6c43yc0Pgnqd/y5XvCtG4+/m9R7wqL3
	 1gh/uYt7J7kvBy54B9QCSUONULewk65ymJ9tcrleY//76eboOi6kZ7iAKwlCygIrXw
	 XmiLOmAghprMkblCqQ6cGQn2XztI7QsR0GReUDuuu0SwQyPaONGam8mH5Udsw3P24D
	 bWXvPJn/UFaSQ==
From: Mark Brown <broonie@kernel.org>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, frank.li@nxp.com, Carlos Song <carlos.song@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Clark Wang <xiaoning.wang@nxp.com>
In-Reply-To: <20251118065012.1418279-1-carlos.song@nxp.com>
References: <20251118065012.1418279-1-carlos.song@nxp.com>
Subject: Re: [PATCH v3] spi: imx: add 16/32 bits per word support for
 target PIO mode
Message-Id: <176350770375.1411024.1671130391576223645.b4-ty@kernel.org>
Date: Tue, 18 Nov 2025 23:15:03 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Tue, 18 Nov 2025 14:50:12 +0800, Carlos Song wrote:
> Enable 16/32 bits per word support for spi-imx target PIO mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: add 16/32 bits per word support for target PIO mode
      commit: 4dbb5f6e1b4eed64037d4462977c196acab2af16

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


