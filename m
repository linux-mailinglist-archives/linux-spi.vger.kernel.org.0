Return-Path: <linux-spi+bounces-4234-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB69573D9
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37352285496
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1261D189F37;
	Mon, 19 Aug 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzj1VCYi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC574181B9A;
	Mon, 19 Aug 2024 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093136; cv=none; b=jzeKCQ5UDHbNuHVxYzyd9mPUpxy3ed8g6hx6gMRgp3U8DAloxvzhHmKit6hofkI1rCmYpB6YVmKwrywmRboBqiTPnw5hFrKHMCZMgEUNnGLbqtPzVfmI/Jm8EfkrKGH5oY40G2HJTM2p4Pg9GZEaYiVHPs9fpGgqwFvTU+1wECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093136; c=relaxed/simple;
	bh=Y3MWz15DfyFGu/HpUcdJEg4vABMmmQCqbNxB7FNMooY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k6E5vgH0zlD7nxRdzpgWtlpZ3urFC44Qm4rUp9tTLoYtFum9oIpoBzPzWmqWlpil3TtMHJ5LF+Uacxwq7bAUy82Ap2Qj8AJr1qiavBGKZr4c2lOmHGd4MwVQFVJTquxREAPUS4yRcj3etwXZCjqOPgjgtBQv2rDihX1m7wPsnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzj1VCYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E21AC4AF0F;
	Mon, 19 Aug 2024 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724093135;
	bh=Y3MWz15DfyFGu/HpUcdJEg4vABMmmQCqbNxB7FNMooY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Gzj1VCYijPbVb3XNf4sdnjl3pHuOYyDosjEQjeIxCRSl03weA46LXypZQvV8yZA94
	 kOData7Y/Ta+ZHK2ozn+VL3+ljv1+ZiFcDQb9xeth1ewa5+vjgo+jSJhken0Zw0NMV
	 P45y6LqKd1PoHgz9dbnz8vEPDKmYIgTbWugMJAQHA7E61xNRHWJK8IdUQyU0P7t6jN
	 OZGi0DR7PaHcVK+vFnH3zOPVzP3nGJYtD6jbT/YDiUC9vr9M6/dLpEtucueMlzgaRY
	 L0urJLwvhlx5XP5UZEm9UncoHz6pW63kyLBL2wTsx0Gb7kvbb1H6RRAYaNSSrNJ2YF
	 kd5uOB0/yTBgQ==
From: Mark Brown <broonie@kernel.org>
To: andi.shyti@kernel.org, krzk@kernel.org, alim.akhtar@samsung.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240819040523.2801461-1-ruanjinjie@huawei.com>
References: <20240819040523.2801461-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: s3c64xx: Fix module autoloading
Message-Id: <172409313392.107460.10914334559728056091.b4-ty@kernel.org>
Date: Mon, 19 Aug 2024 19:45:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 19 Aug 2024 12:05:23 +0800, Jinjie Ruan wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: Fix module autoloading
      commit: aa6e8296a7ff55c7c40a616b87c521b2a7e96395

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


