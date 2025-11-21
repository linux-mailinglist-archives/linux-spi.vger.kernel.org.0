Return-Path: <linux-spi+bounces-11456-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA2C7A3AB
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 15:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8E8B62E0E0
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE788352F86;
	Fri, 21 Nov 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te6RDEOd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A641B4244;
	Fri, 21 Nov 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735988; cv=none; b=RrYJODVhn3ZD9XNi1Nt2A0cIN01Hx1M1OkGh4x03Pd4SAd8wC6dOOF3qirth9ysQ65uDx3+HpnJ4zvwJ7J/vCkY07F0Cr6LCHegvyipgvvAg0F043KHVJhiaIFKVS3DJ0hYco8rf05uH12i5cYw93Jxg4xIvtvC1rS22e9cs1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735988; c=relaxed/simple;
	bh=pnM6zj86IqldLJPS+Ht6crPpBTtueu6/UR4GDU5+lHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jvDyGKBTpeZwwelYQ0IpLEQfwt4XQAzoWJU+4M7oXcRRmChb3JSvlQTJf77VbxMjxRL5175Xx1aNMomINJhYB0BtKe8/idWdYR8LmzEWi2eUq//G86J6H1W2eNjfPU/eFSWI4R0zOjMxW+dqsB+2niuplidtgVNxcZkFXJdYFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te6RDEOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B3BC4CEF1;
	Fri, 21 Nov 2025 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735987;
	bh=pnM6zj86IqldLJPS+Ht6crPpBTtueu6/UR4GDU5+lHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Te6RDEOdyGphjrHER0QQGpNtE5pzBwo8AYMnhRlsTSP737QewqjciixM2c9k4an4a
	 6sOfxv346z52RYZxC73xZT3rr6A+FVPuzRw2RGYzm9YQM+Xf64k9TSE2xWGUGZ8xKr
	 HeFcja7evMSOOdE0R1wISnpO7Cqr+IqC3SlGrIyz0ZBVuBKwxwptqOJ+6wR3Hg9wWN
	 Q79HMi64H7qQkyFEXMnRxLLgjrZPblBWhHPfN9NB/+pL/KQJU0KfOM2mJddM4t7PWH
	 M8jF+9PMH8ypMxE+On3gZ/u0re5h0No9UP5C0bk2SdXx3la2PFYEsTZppw5vuInVfh
	 68pDSluqUh3Ng==
From: Mark Brown <broonie@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, 
 Riccardo Mereu <r.mereu.kernel@arduino.cc>
Cc: linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net, 
 naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com, 
 chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com, 
 farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, m.facchin@arduino.cc, 
 Riccardo Mereu <r.mereu@arduino.cc>
In-Reply-To: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
Subject: Re: (subset) [PATCH v3 0/6] arm64: qcom: add support for Arduino
 UnoQ SBC
Message-Id: <176373598316.33640.5262167228570567922.b4-ty@kernel.org>
Date: Fri, 21 Nov 2025 14:39:43 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 20 Nov 2025 16:58:19 +0100, Riccardo Mereu wrote:
> This patch series adds support for Arduino UnoQ single board computer.
> UnoQ combines Qualcomm QRB2210 microprocessor and STMicroelectronics
> STM32U585 microcontroller.
> 
> In some files we decided to keep UnoQ code name as "imola".
> 
> As this platform has a microcontroller connected to the microprocessor
> we needed a dedicated spidev and to add uart2 to qcm2290.dtsi file; both
> are used as interfaces between microprocessor and microcontroller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/6] dt-bindings: trivial-devices: add arduino spi mcu interface
      commit: a7bde7c10902a0f6f903d3bbe67461f2b402a9ca
[3/6] spi: spidev: add compatible for arduino spi mcu interface
      commit: 43a3adb6dd39d98bf84e04569e7604be5e5c0d79

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


