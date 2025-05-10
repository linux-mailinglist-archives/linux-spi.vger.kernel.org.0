Return-Path: <linux-spi+bounces-8053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEDCAB20E2
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 03:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BC41B66806
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 01:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A98266EEA;
	Sat, 10 May 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8qycWpG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229211754B;
	Sat, 10 May 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746841883; cv=none; b=agdEXMSqWiTWPuiyLcCsald5LWmooiUlcHrFaa1B+2LCB6tvlvDEIP4+jhvA2setbWwkfpHihJ//W99uKyMzgSFz3hcXEEf7ExnqlJv8mSUNE8TPhHvrVg1oXI9s1TG5U5eyIH9+paQ4k8YT2n8eS2K9dqP1OCw6QHeJKD92rKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746841883; c=relaxed/simple;
	bh=97RdXJzhWuNgO+NHgDHCu6JgmKsxcavy2vgt0LibjAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=moMf4PxwvkwTHp/yQ8ymp7U/hKLVTDx1Jd7PMWd6bNy/KgEQj2xBkLQxlCLN6sJ9DOmdm3e+EI387pQgwf6b60v3SLGZfo72LpJsWumYesghc0KcKGIMXoGykRx995LgV2Cy/Ln0hBYmBN2/4xz71GINA3Bb4StbM5m257ywttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8qycWpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BE7C4CEE4;
	Sat, 10 May 2025 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746841883;
	bh=97RdXJzhWuNgO+NHgDHCu6JgmKsxcavy2vgt0LibjAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d8qycWpGU+AGABgxrrU6VoNPAPryCBC2bxzMnA6/J/cMbYKFM5nfIt2qCrGwG7oid
	 NSf4ChlQqo5tl2ZhTJ4UNaMGVMWzCj/nlD9cGPsNHP4/VcRa3y7ggJsLt4stIZR1wH
	 Y37kvm4o7rH4Can0bXnBpuT9ruUIWkZTSSEpS6dolU+FXHry0cDX8miZwWim+I+15v
	 ZuVgKGHsrB7XKsX38zmUWaSHGEtBQd0BB8dXTCPugn2H1pMwADBcEu+S5hh4INW2Eq
	 8GHIGBUJ3kcoStQ/HDXS2bZNgmzONQS7aaN6XIBrgOu86NCsVOQT0ryrLuP0QqDKIG
	 p7By0dSD4aRMg==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-spi@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Biju Das <biju.das.au@gmail.com>
In-Reply-To: <20250424090000.136804-1-biju.das.jz@bp.renesas.com>
References: <20250424090000.136804-1-biju.das.jz@bp.renesas.com>
Subject: Re: (subset) [PATCH v5 0/7] Add RZ/G3E xSPI support
Message-Id: <174684188045.50878.18296470644838923077.b4-ty@kernel.org>
Date: Sat, 10 May 2025 10:51:20 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 24 Apr 2025 09:59:48 +0100, Biju Das wrote:
> The xSPI IP found on RZ/G3E SoC similar to RPC-IF interface, but it
> can support writes on memory-mapped area. Even though the registers are
> different, the rpcif driver code can be reused for xSPI by adding wrapper
> functions.
> 
> Merge strategy:
>  Patch#7 in this series is spi related patch and has build dependency on
>  patch#6. Maybe an Ack from SPI maintainer is required so that it can go
>  through memory subsystem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[7/7] spi: rpc-if: Add write support for memory-mapped area
      commit: b0b8d3aeadb5c49bf78305a1bc844e5a9378257c

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


