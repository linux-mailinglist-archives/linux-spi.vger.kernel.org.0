Return-Path: <linux-spi+bounces-5192-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301769984A0
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB91282EF2
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523501C461D;
	Thu, 10 Oct 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Vb+UnX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B431C461A
	for <linux-spi@vger.kernel.org>; Thu, 10 Oct 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558873; cv=none; b=gGPbDGQcc63bc0mzXrTTiRCiKEQDKOsJXRGgRAx0Cpucr7dkrPqFvOGjNXqPhCp4YKQkWB02OZ0b36KRIW0qpx8JYBjVhn80mpSYYlBJ4EbhNbapfY9moLp5DTWCgERAIXxIWpdUVQn6v9jqQT6Rkd+3Ml48H2tmg8OtHMSKPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558873; c=relaxed/simple;
	bh=iVPsbnXYr0IWEdum3ohIZ4GSaWHJnOkr23pu26/OT7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SG+crKjzlE1olVwX41nj5w1vUu+awjl/B52jvFvBb/nC1E5u/dhwHHXglRq6YTSB9CKLroT40ORa6CQwvRFGlXlHExGMkj8w/2XnJHGhw+EOdJ9U7F1uqW89iVrr2UTPxHOfnVMDKWRbGlwNyUcQ79AOq0nbLm4pOymdqZthXwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/Vb+UnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D42AC4CECC;
	Thu, 10 Oct 2024 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558872;
	bh=iVPsbnXYr0IWEdum3ohIZ4GSaWHJnOkr23pu26/OT7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B/Vb+UnXrh5PwsHrDg0UKBXk6n6nP15UWqvCJRQMheYfh7oHrBBLgm+iK+hve671B
	 qn+4T+wqnUiabPbsFHCcdclS4sC4u0Xj/M7JiZpLecXC8lm+hYW9iXmGaTOh4HIeQR
	 AmB/R2JeaFDSfmDxb2uB4bFMRmxMThpHJCyvSrZDRjQnlIhVOAqkOuBb5eA+hgr0Lk
	 brGuilfXJBcObQmQDk9WKeKj0WU1US6E9KVwzHZWSYZSr70huiq3ltrtYgmTHcNU92
	 U/8F0S788T5hK/6m0WWQvUvD+VgiXkrpcDoSTOiW33UqalvcnPBEq2GbZxn2Bj7xF7
	 lX8KUtBNexn4g==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>, 
 Tomas Winkler <tomasw@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241009062244.2436793-1-mika.westerberg@linux.intel.com>
References: <20241009062244.2436793-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] spi: intel: Add protected and locked attributes
Message-Id: <172855887125.3260167.2944535070302678929.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 12:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 09 Oct 2024 09:22:44 +0300, Mika Westerberg wrote:
> The manufacturing access to the PCH/SoC SPI device is traditionally
> performed via userspace driver accessing registers via /dev/mem but due
> to security concerns /dev/mem access is being much restricted, hence the
> reason for utilizing dedicated Intel PCH/SoC SPI controller driver,
> which is already implemented in the Linux kernel.
> 
> Intel PCH/SoC SPI controller protects the flash storage via two
> mechanisms one is the via region protection registers and second via
> BIOS lock. The BIOS locks only the BIOS regions usually 0 and/or 6.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add protected and locked attributes
      commit: b1258105f9ce5203f48a47fd2f2cec8c38c41841

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


