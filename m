Return-Path: <linux-spi+bounces-7764-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB009A9D130
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231411BA464C
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0121A427;
	Fri, 25 Apr 2025 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISyIsbyZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2012B73;
	Fri, 25 Apr 2025 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608195; cv=none; b=YJ0pgnyLIzeS65nN6ubdfmRHsTR+542yJHsDwkbL23qG1Ku78JGmu68GOfALCprtpgkaE9wuc3wTd9QQy8ViZZol03/hauvKHUwIoBqPmMu3z5achwn5WaYQ6RWuIKtxlqtJSVunfoaEy6MtvQY0Wrl4+ucuG+4EPo1VEittmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608195; c=relaxed/simple;
	bh=ZwjGs58fIGmmPZzgrAaZeb8UcZDv+QdIHiBKPllDCsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jyl40c3TNZyvpcOvcISJ6eAaRfpHxRW3NKDVYBrS16VsIknckbAMWWWOODPcDLHvyJAfWOumXwhL/+a4O87kxFfDJas4GvR1X9vXg4KG5lrxF/yAA+ZdAKdJQimLh3plO7VE8plzhYTFLQDPyD5yyfA+1p52lNAuj0abyp2lDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISyIsbyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15A8C4CEE4;
	Fri, 25 Apr 2025 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745608195;
	bh=ZwjGs58fIGmmPZzgrAaZeb8UcZDv+QdIHiBKPllDCsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ISyIsbyZaYi/x7N0b5j9Aw0ZpEeJri7HmLK2FOLnlE3M5t/E+2wnd+fCpHrusVfDD
	 iZExre0JRBFngC1WiakfeOPjjahWJlWuPZE/aT+dKg+kOVUayozatDAhGK2JdN7RN4
	 Gl0dZtJvRCQXi9d8Fb+fWVSDyaZvcTtFNAA5wUGCC9uCoHBTeaoBsDoqdx7Ijh1JLo
	 g/hbIRtVhIwG3bUeuRgPvVKtnCI2w0uTbyVuDwAxqXyb9YaBxYWCqaKqAqzcjOrmhw
	 q5nyswMGCCv1lPltP1nVnQC4RprI6fHDbYUFYQ/T8QJ4tRitQkHiwc1YV4+Td9BOJS
	 3Tyfer/QBSrJw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Inochi Amaoto <inochiama@gmail.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org
In-Reply-To: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
References: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
Subject: Re: (subset) [PATCH v4 0/2] Add basic SPI support for SG2042 SoC
Message-Id: <174560819152.249436.5095077877581819518.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 20:09:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 07 Apr 2025 14:35:11 +0800, Zixian Zeng wrote:
> Implemented basic SPI support for SG2042 SoC[1] using
> the upstreamed Synopsys DW-SPI IP.
> 
> This is tested on milkv-pioneer board on bus level. Using
> driver/spi/spidev.c for creating virtual /dev/spidevX.Y and
> tools/spi/spidev_test for testing functionality.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
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


