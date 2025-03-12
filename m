Return-Path: <linux-spi+bounces-7094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A858EA5DCD6
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18E57AB134
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920224293C;
	Wed, 12 Mar 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbQ4ukLv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598052417D4;
	Wed, 12 Mar 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783196; cv=none; b=BvxoN+yDHAVf/ZPonTTNxO6VMie8ED8dH6l/7pr5dj2lE3HQyc9d2MO8msVRi1l8QKI3cKVw5f63eJqA3FFumlTxHhSg+eYIVhWfBRvfI54uoj7+4THmdSB6ls+tBA0VrAExJIdl/0lKoq8uYWnajjSZirfCga8e7fAvqQdm1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783196; c=relaxed/simple;
	bh=uZiOVB8yQ9iEfQm3YhLtHeR0IQkVJXdxQFzGtq4+Wns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qT1FX/ROdEXfMQST/dKRCg5LkU5xoHcIKx5Usxb9fTEwp0ylIPmKUHm96oayUg59iqLhyaG/9LrSOs78gT6a6ENHyZB6W1DaItdqfCbjJ1J74eZBTa1J4jxWyms8cdfYTE60pgrMyH32OGjhRQ4CgiSTqOCRxnw82DH2z6dJKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbQ4ukLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E249C4CEE3;
	Wed, 12 Mar 2025 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783195;
	bh=uZiOVB8yQ9iEfQm3YhLtHeR0IQkVJXdxQFzGtq4+Wns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bbQ4ukLvpEYQWQ1qWqxi0sY7vsSyUPCOm3PHti24zHG0WGJnQqmiwt9xEuUHr3KMt
	 htqoqorYex7ALPwAKmFH+rihbbwBKpjrpGMOS7DLt/jlJSfU67Ft4tYTaLO4hxQEtH
	 VOTHI062k12tz9zfAWsPF0fNYVJIJa64nLWxWq6ze8PkSbfqfIgB4brTphVOPRFxHt
	 SfmDpuucqlTH763Nfx6t8hYed2lg3MCcQTB176yG8fD7a39lOAm8ANOY1rD8nhQzF7
	 dnWrMIwVLdyj8Wv28N1fVFtHori2uW3SPtBxNmOUq+HHSiVvZeTVrxFi/YN1Zx968V
	 oOogCKhPP5P0g==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Longbin Li <looong.bin@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 sophgo@lists.linux.dev
In-Reply-To: <20250304083548.10101-1-looong.bin@gmail.com>
References: <20250304083548.10101-1-looong.bin@gmail.com>
Subject: Re: [PATCH v2 0/2] spi: sophgo: add Sophgo SPI NOR controller
 driver
Message-Id: <174178319298.22638.1373062138685342011.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 12:39:52 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 04 Mar 2025 16:35:41 +0800, Longbin Li wrote:
> Add SPI NOR driver for Sophgo, including read, write operations.
> This driver is only suitable for NOR flash.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: add SG2044 SPI NOR controller driver
      commit: 9f95e2dff3fe6a5f4cec786a106558bb8f268a16
[2/2] spi: sophgo: add SG2044 SPI NOR controller driver
      commit: de16c322eefbe9026d4eabc8ae934bb778cffd1d

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


