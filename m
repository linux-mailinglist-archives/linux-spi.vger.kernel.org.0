Return-Path: <linux-spi+bounces-12329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D59D1886A
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 12:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBF623014138
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C902BE620;
	Tue, 13 Jan 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoMA6EXm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F738BDD3
	for <linux-spi@vger.kernel.org>; Tue, 13 Jan 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304576; cv=none; b=GWw7pcDPafur1bfo0Z6BK2buvtv2FbhJPlzCrNw6BoSB7yI6Ksw4Xlimsz8yxKzX6xvb7QaGR6r2Lv1r0Q/FIXq8Ag+g0IAY8lm+Xt9/Db24imhsw+WS4HGQDn1EAffM8P3GzkH1fwUM6mP5OZbS9WBLWlKRfWIeSPxFySCi6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304576; c=relaxed/simple;
	bh=KiWzf5kGCSQTL3S3lojnfr9SeyYwyG2WS7wgeq2OlQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=piZ/I8QeUpZzh03EmQJ2MA6QTeoEY5/u3v10ij6e/63C+ASLxNJXE0ZWE8vs7watoJJgu3bh25EztzJXezIlHa1pv0cDqkObrYIr68z2Wkjy5I51L6LZh9NPHI5FqWvXFt8C4/dvOqvm3Yb/Q4LeKeZnO9Hdv9rsDXb5/pmIa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoMA6EXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ADAC116C6;
	Tue, 13 Jan 2026 11:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768304576;
	bh=KiWzf5kGCSQTL3S3lojnfr9SeyYwyG2WS7wgeq2OlQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QoMA6EXm9/2V4CmtvPzckGtXxTaoAsWjjppaYHOe/l+Oz4ySiJCZBC2wBWrT+/4kV
	 gZpXXzF2HHZTAA1K+A4v40cXq8eB4NpQb2Luyzix9ALNS+Rb7SAMQtEnquf7i8HXg6
	 3jy+zgGxclqficmJt+ukQVrKZEvU8EN4eFlMVfMwuB0MmBfIralU+7MfxpWSJecTx/
	 R7vD5iW37hCztm577qSyGaSb5HRhYqDLVeqdmoRnk7HjJxZLdCyAbICY84q7aQHT0J
	 xicDPZEq78+QUIYn/jNmBrIdD4DwE5pN89WvAnmkst/PqN+eAHby8SDhfLHimwy/3E
	 7a1BU66QR6B2w==
From: Mark Brown <broonie@kernel.org>
To: shenyang39@huawei.com, Devyn Liu <liudingyuan@h-partners.com>
Cc: linux-spi@vger.kernel.org, linuxarm@huawei.com, 
 jonathan.cameron@huawei.com, yubowen8@huawei.com, zhanjie9@hisilicon.com, 
 liuyonglong@huawei.com, kangfenglong@huawei.com, alireza.sanaee@huawei.com, 
 salil.mehta@huawei.com, shiju.jose@huawei.com, 
 kong.kongxinwei@hisilicon.com, lujunhua7@h-partners.com
In-Reply-To: <20260108075323.3831574-1-liudingyuan@h-partners.com>
References: <20260108075323.3831574-1-liudingyuan@h-partners.com>
Subject: Re: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name
 in hisi_spi debugfs initialization
Message-Id: <176830457375.25724.8454029111549041009.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 11:42:53 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 08 Jan 2026 15:53:23 +0800, Devyn Liu wrote:
> In hisi_spi_debugfs_init, spi controller pointer is calculated
> by container_of macro, and the member is hs->dev. But the host
> cannot be calculated offset directly by this. (hs->dev) points
> to (pdev->dev), and it is the (host->dev.parent) rather than
> (host->dev) points to the (pdev->dev), which is set in
> __spi_alloc_controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization
      commit: b062a899c997df7b9ce29c62164888baa7a85833

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


