Return-Path: <linux-spi+bounces-7766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B63A9D136
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF141BA657F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE6121D3D9;
	Fri, 25 Apr 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goTFm2rw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600B219A8B;
	Fri, 25 Apr 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608202; cv=none; b=CCi4WL2AF6l747ODgH8XB60SeY9t7RqWg5nnuI6T3oQvuMi/9TsOJ8luQQbbNM6+lWV8kmEjoN/AiKEaNumXUGEYeFO6oW5oU9qina+gh6N9P6y6Lk5Y5ZBl25xm7ZYtrdhhqjSpXqdyiwcaW//9HfEAVqY4fgDF8RscoZMwFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608202; c=relaxed/simple;
	bh=LesrsmhbSWqU1lHUIefA8ynfKKgU2mtG7p0AEsjZN88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pQIbd4C7bWJhj+KZIsyzp0lOdc0ERuVnmVc8YKJmj2BaDYdKAWq997E9tUzs8F5LtgIvhM30j5ue0h/X4406TAvVJs9FH5kcAvat0uI1/yUWDb0K/uSeF8WS57vPn4K8hjxxCizD924S9X6ft9RJnm+A64X9QLJWfs1Au5fChD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goTFm2rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE858C4CEE4;
	Fri, 25 Apr 2025 19:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745608201;
	bh=LesrsmhbSWqU1lHUIefA8ynfKKgU2mtG7p0AEsjZN88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=goTFm2rwiCqQJYjGFcgZRE81Bq8qB9LHlup/kh8HtQJXmVmvA27w6BzqdvzcwSy9B
	 6pINSKBnwDv3w9blgWzcQKRp7m+2haABsUoZbxO58HvrY0W/Fr834O4ljXAf8D3mKp
	 WV10C7tasbi22oAbYs63bzZGkWumDG7rvUn9ucnNtkOeBKDVt1NKZ1v6iTlmeLekPh
	 7DuEVcc8jdUFWC//uqkYJSzGQUbxAMo9EGFvWBdhV0F13NUc5Dv1ssPidGcwvtaTka
	 cg2lhZksHnZEtWv6UNqcQ6utAjlP7Q7GDdUYhI5Ab49dU9ugiPRzr1N5hvxKhsidz+
	 DWci7Kld73wtw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Inochi Amaoto <inochiama@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, linux-renesas-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
References: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
Subject: Re: (subset) [PATCH v6 0/3] Add basic SPI support for SOPHGO
 SG2042 SoC
Message-Id: <174560819765.249436.3389646166213533296.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 20:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 25 Apr 2025 10:28:11 +0800, Zixian Zeng wrote:
> Implemented basic SPI support for SG2042 SoC[1] using
> the upstreamed Synopsys DW-SPI IP.
> 
> The way of testing can be found here [2].
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate compatible entry
      commit: 71cfb1f88f772fb92a68a4ab85b16ccd5cc8535d
[2/3] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
      commit: 0889c4d28ad79b55ee8cf3c818e9d86203ace8f0

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


