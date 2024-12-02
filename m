Return-Path: <linux-spi+bounces-5875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9FE9E0379
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 14:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE3284134
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1D20371E;
	Mon,  2 Dec 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqlA1rme"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB920102D;
	Mon,  2 Dec 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146243; cv=none; b=JEJDA7yBYf+Hm0WyALWIPoRmUXuQTfLCbqv81bsHHPMZP4Zcqq8Y/i7oxFPzmbO8moqjLq0Op6UrphqLyNw9GLHRlPE+XBU2Loa9XsFF7Fks4YU3/vMGM0DYLHua6KnTynG1Y3TKajZMUInIldDZQzXqfNLuRAHp3NrK67mn1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146243; c=relaxed/simple;
	bh=vBACjh86A19xFipmnv80G1hclQRyL8jWXYTPsMeFaT8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PHyDsXUbVpsQoL69yg8oz2US7uGiugbqyfHbq/vZE7aaMC+XoYZznmY/Y7YYKMGlKBTTQdYwlx4pq0oaOiK6O9IFCQZjvdtx6F9UIdKfJqzCQqBjm+aqxWJOsLmeA9CM8YpmCJl2ccoSy2F75nSoWV0UYgtV6gLgFUvhQXKCvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqlA1rme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C635C4CED1;
	Mon,  2 Dec 2024 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733146242;
	bh=vBACjh86A19xFipmnv80G1hclQRyL8jWXYTPsMeFaT8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CqlA1rmezZrZYHsI5ko6fH0KDsOEiO7UC8+VTp5QDVSAcMuBwITkOjjG4jMr9tlkG
	 YoCt/MbA1+NxWZ/rFEHG24f6mDpRglhVBIO8xMCCze6cRqtO9oJ4lnvkRcmKB+ZVTm
	 fnQGMjQwuwNK1VLgaQ12/Yo8XRW58uN3zh7eGdlXYCE8pwf3diRV3K5ZdeEj+4/Xyi
	 H1M+ZxkAlkhc0naSBhSA09mc2imNx1ZPvQxHpq7H9Zeg73p6YVxJJiO18PKfINRenM
	 yn1AIDG5GLfg91C0s+7Zw8PzLMMe1JbeH4F1P2ZiP/hsAkbg8yEMhutD2DgdREVMIl
	 0x94zsj8CkTDQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <1f16f8ae0e50ca9adb1dc849bf2ac65a40c9ceb9.1732783000.git.xiaopei01@kylinos.cn>
References: <1f16f8ae0e50ca9adb1dc849bf2ac65a40c9ceb9.1732783000.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH] spi: mpc52xx: Add cancel_work_sync before module
 remove
Message-Id: <173314624184.54221.7774657892110514848.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:30:41 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 28 Nov 2024 16:38:17 +0800, Pei Xiao wrote:
> If we remove the module which will call mpc52xx_spi_remove
> it will free 'ms' through spi_unregister_controller.
> while the work ms->work will be used. The sequence of operations
> that may lead to a UAF bug.
> 
> Fix it by ensuring that the work is canceled before proceeding with
> the cleanup in mpc52xx_spi_remove.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpc52xx: Add cancel_work_sync before module remove
      commit: 984836621aad98802d92c4a3047114cf518074c8

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


