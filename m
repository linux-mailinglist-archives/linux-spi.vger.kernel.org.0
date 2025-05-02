Return-Path: <linux-spi+bounces-7859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30746AA7C20
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6201898663
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A4521770B;
	Fri,  2 May 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cus4DwDT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6E215F5D;
	Fri,  2 May 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746224504; cv=none; b=SXMw01uwZ/843GzoA/UaBP5wPy7FPQQ2C94ViaR94qIt8pOZcIJ2ISEpo+vVlBXIxAKw786Ad4coDIFPW3TjGK/PgOko7wbUmKTurgWhJP3oOwozWsuNiJKGi/wEMq8mx1NmbppX/9y/7VdmLbSHc3l0nqRzO1isounjcw/2faM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746224504; c=relaxed/simple;
	bh=6T9qzilhl1H8Dc9dGScreUk6+w1qEHKSSSG9bBC4Bos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1WhO6Zx43DHaG67gvuz1FCJDaOPwvEZSy4Xs5Zpr1n25soZ+v8bvdRDL9p+qRAOSLXzMl0E+7ScSb2V48FgIsqo56Sx3rTdjd4MtKQ6RGa+pbrkQUvfDdUErDYbUDyMaNcYnmiKgAhi2ejDT3z2BfNy0LxiKC+IB+K5Tgs95co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cus4DwDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCD1C4CEE4;
	Fri,  2 May 2025 22:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746224503;
	bh=6T9qzilhl1H8Dc9dGScreUk6+w1qEHKSSSG9bBC4Bos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cus4DwDTE8jY9Eg0ad5+B71nGeZ9veoQWW6v6HNREUtExD6RpQX98nkmnw3qJ1yEW
	 MWdwPIArynoHdMOPYGWr9ZFneKLzp3B9ntCA6ys99dfS9d3OoJtBEweJBYdiDveuAK
	 oBMhzMXg6TU63V84tBx5GP3kWNqoSxBlzGYvwZCaoQGJdPPQqtyoBNXUC4VEG1jXPx
	 7bO3XgIeOVtlTyT5VMSVnYOVRGV8mhVRYMYvXagxIUO1QHWqBL9ChGdjTEpE2HPRnI
	 Zc7dvalE8/9jya089yMMRpfHL/noppVsL2Wsv7nFYIyPRP1HTfdVRB9PPPbG0hmJ5D
	 vaNJOPsRd1Ywg==
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mason Zhang <Mason.Zhang@mediatek.com>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com>
References: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com>
Subject: Re: [PATCH] spi: tegra114: Don't fail set_cs_timing when delays
 are zero
Message-Id: <174622450030.4079756.4548805140553254933.b4-ty@kernel.org>
Date: Sat, 03 May 2025 07:21:40 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 23 Apr 2025 21:03:03 -0500, Aaron Kling wrote:
> The original code would skip null delay pointers, but when the pointers
> were converted to point within the spi_device struct, the check was not
> updated to skip delays of zero. Hence all spi devices that didn't set
> delays would fail to probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: Don't fail set_cs_timing when delays are zero
      commit: 4426e6b4ecf632bb75d973051e1179b8bfac2320

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


