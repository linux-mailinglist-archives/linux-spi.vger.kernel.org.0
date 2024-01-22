Return-Path: <linux-spi+bounces-561-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D3836EBD
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51721B2EC98
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112F59154;
	Mon, 22 Jan 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyNywacY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3705914C
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942175; cv=none; b=ex5S1Mv2/V80ho3xCoFr8Tlf1ej+f94odeRnF5gkDHQPrtGCmnUhsJKb85RdMftqjfybYZ2uMshq2c0aqSI40u8xN8GN0M/GqibVK6je2Ku7AiAR9TnvNlRUfm0zVupyPtmx3R+A1KEECmnt8cwZMxI2T7S3vN2WGUFty6y8WOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942175; c=relaxed/simple;
	bh=ODMvZJ1rCE/ZfYmP21C45QfWTiDBwE/riyOPtWU6/5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EBvH3JZdJ94ZFCh6X3JGAOmREik11OGCAbsD7NT+BepIyKFlf/Tgm0hLFJc4k0LasA2OgA+b/RzBg83XVGhOOYBOHuAl+2AjNhz60S7W92KloMnkez5IlhA4xN0a/wDHECd4imZ+HJX9k6rWaSxhdLqeaNlTKTWOPi7Q834AlI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyNywacY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15291C41674;
	Mon, 22 Jan 2024 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942175;
	bh=ODMvZJ1rCE/ZfYmP21C45QfWTiDBwE/riyOPtWU6/5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VyNywacY/68xVfzW0EAc2RxYpzc2Otr0HRm8WtxRsUxVVbU2DRiUWU0O4OfO/z9AW
	 d+XlDk0ZVLuc7Mr9W0aCf9GFNUHa9DinkUzr5l8vNtr1ZNhicSIMGb450AI6EX2VFE
	 UuDN4Jny8UCEvl3kJsJwG6aIh7pNPxdksIiCP7OiVUcpcanNLwNvLUEl2/kJ+Nlpkq
	 0udSgwoGQGKZwx3/XZPLn7sT6kuKkrc5OsdIoRNatx9Ix5e5nqRB37gWB/mmYG3FqR
	 kNqvJ6ibQdhWeTnuffSYcbc95ID6R2eMpxICXSJBRNVo/5gJ2EDrpLxeu0uc21tVzH
	 3yOdC/t6y2V6A==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20240118121016.3734770-1-alexander.stein@ew.tq-group.com>
References: <20240118121016.3734770-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] spi: nxp-fspi: Adjust LUT debug output alignment
Message-Id: <170594217380.69518.5112871167201645561.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:49:33 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 18 Jan 2024 13:10:16 +0100, Alexander Stein wrote:
> Ensure the command value and LUT entry values have a fixed width. This
> way consecutive output lines can be read much easier.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: Adjust LUT debug output alignment
      commit: 50c4f8172dbf9fdf152eae5179e233879a72dd47

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


