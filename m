Return-Path: <linux-spi+bounces-4292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D995D96A
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 00:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D0F283994
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB841CC17A;
	Fri, 23 Aug 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm+YnwkL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592E1C8FDD;
	Fri, 23 Aug 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453842; cv=none; b=Lv7176+r+2IDLiGSvIrz6vhRjcdK+hLf5Q4E9y76NIXd+XiKQNtHcWZKgorZAnZH2DlXrVETPnvwjq5xC/qtgMl9/y6H5ZP3nGg8JBH9PSDbJOGpRou/HZjxdGn1X3gJzfuIsuKA8+df/xL8w8cPvlRyzQR5MbpaoUwnTHO5pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453842; c=relaxed/simple;
	bh=n/mUAtQFjE4JPk6hyRDQWvCtSI8173z0B+A3NP4ZAmc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ISDSTZeRCnnaIMbdBnVAvZEWI5VDuc2AAdoJIS1mXSK7mhWx7a2gpYbe/44HCVbBsnujzaG+wttNqHrFPm+9/HL9K9sKWs0BH1zuCo7oeoM2/YRH1HTlTExyvVY+TajxwIC8vsTVW0ATZ09GgQvRTD6GWQvpa1gulL2mm2nrj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm+YnwkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF8AC4AF09;
	Fri, 23 Aug 2024 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724453842;
	bh=n/mUAtQFjE4JPk6hyRDQWvCtSI8173z0B+A3NP4ZAmc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=cm+YnwkLGmnty2v3d0rec8Lj5dGUCwZI0jJA1gl9g5iThygB7r5cgYes3UBrIFY6b
	 AcsPH2dVn2ycn6NuiRfWOD4hSh7PBMNlqg3/W/B9IS+U6jgUPdsv10W/rha7GxWkPD
	 y3Sn2SJ04/GdhoCF1IfAw8cXLrtTMmPcEgBli/W6nuUEC3szjKBnurwzaJhpkAy1wO
	 7rTPqCSaEtpx/SWF6REiQ+ZFQB0eo7srFTm4OSFT52mcDtylCh7YdemUBF6axcEivf
	 uXbB0ySLFbLVfzG++0Hzwm3r67xW0wewcCsFttgmwHlNq7iScKkQM9EepWTilKH2AP
	 vE5B+y12XqKlA==
From: Mark Brown <broonie@kernel.org>
To: william.zhang@broadcom.com, kursad.oney@broadcom.com, 
 jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
 anand.gore@broadcom.com, florian.fainelli@broadcom.com, rafal@milecki.pl, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240820124011.1788479-1-ruanjinjie@huawei.com>
References: <20240820124011.1788479-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: bcmbca-hsspi: Simpify resource lookup
Message-Id: <172445383901.842317.11362631915105690405.b4-ty@kernel.org>
Date: Fri, 23 Aug 2024 23:57:19 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 20 Aug 2024 20:40:11 +0800, Jinjie Ruan wrote:
> Instead of calling platform_get_resource_byname() and
> devm_ioremap_resource(), simplify the code by simply calling
> devm_platform_ioremap_resource_byname().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcmbca-hsspi: Simpify resource lookup
      commit: 91232b00b1a5d2486770c72c51a752a77c7601b2

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


