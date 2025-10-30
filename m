Return-Path: <linux-spi+bounces-10911-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC783C1FD50
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 12:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DAAE4EBDA6
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8F72E889C;
	Thu, 30 Oct 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV0abB9A"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894332E7182
	for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823822; cv=none; b=NZm1bz+q5rD4Nz7HtA6rLU+EHIdl7uwGR/ZwXFxtKDbgcogu4CzRC+I6VPOpSBbu1nQShtUFt4mD1hhKx0A+v5fCjifFAFVTpAr+/XChFo+MyRU4uswttd7GV2+ROWFCiUn2SJNnGtK/pg4i2f7tGMsxAVSCzsRnkkXFIpW3Y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823822; c=relaxed/simple;
	bh=GC0x8GSppfTJqkaxY6HGOCHa7uS4cRGB2YZfVluI1YU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Aw1qqUK9iktVAxi2nNE6lLlKrjj3E83iQXbbQTB0IOf6HzQzxUOiwtniUU05ax5xusGU0wre6Rai7JpatwtYd2BM+zDElXSSckAiwE+SfP8yJbl1EIp5bZoyj5Rllb4a+DskaWSgVINETDP0Y+a7M2bI31IFfTwlFwoXFey9hyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV0abB9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8891AC4CEFF;
	Thu, 30 Oct 2025 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761823821;
	bh=GC0x8GSppfTJqkaxY6HGOCHa7uS4cRGB2YZfVluI1YU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eV0abB9AjHD5q5ozdOlA4ekE7Cj0E7B+1ExL7thz5AtJiMFo+E/KqhABwbMtgiOxn
	 67CAzQ8doXVbeBa6rqD/T0lOug6/vfrcVV8YtmeCs47inQ35lCpyBkcmHzKIW+IcrE
	 BA0uKOsN855rL5+ALZkj+BNbWi6hSivzDEeUSwssW01Mh5GUBpzC5k72nOeAKCJKR0
	 hdF75YcqtNdQMExeg6JtI39IOXwmbwe9eoWkMwZ9QMsKXHv60P9/oGQmMyHlkxntpc
	 7UPagyNRqFN9+63DNrgkfgftbuN+oLZrO59fTFM2R0Gbs2wAsYFfIx7TsC4stmEfrN
	 zQLFoXArTpntw==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-spi@vger.kernel.org
In-Reply-To: <20251029065020.2920213-1-mika.westerberg@linux.intel.com>
References: <20251029065020.2920213-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Add support for Oak Stream SPI serial
 flash
Message-Id: <176182381909.28786.15967251100168153528.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 11:30:19 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 29 Oct 2025 07:50:20 +0100, Mika Westerberg wrote:
> Add Oak Stream PCI ID to the driver list of supported devices.
> 
> This patch was originally written by Zeng Guang.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add support for Oak Stream SPI serial flash
      commit: e7dbfe6f15b4df34bb169d180bd10f1a3c043814

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


