Return-Path: <linux-spi+bounces-963-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B1845930
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FB628D56E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C17C5F492;
	Thu,  1 Feb 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjPHFtoG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F05F482
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795179; cv=none; b=k5Rq7S5COhKV/dtNOiMakT7olH0tws0M4LxKw1ku+97AWjkp3Le2S6nxkFwYh6xxMzFrO6NviQCSjw+aqNRdt8QCD1Wg5Z+NvCfgph9aWH8DZD4Ja43X4j88j0AvZIos8gJjbBUXFwNCQzYUlK0Kh5kfMDWmjczxno5/eUDnxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795179; c=relaxed/simple;
	bh=nf9JKjzsH38lE3eCZPnNOhTo1yC4CQLOdtabFcKTDRI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hgYCI4EoKGsyiHnkFuCrJSSFlHBlj+J4O98NfNgxnaiP6aw2zks+KJqbZgQQRNihxz3T7G6FD5oceHd0x70wI3RLhRW2NIfa/osbAIblrT6Ydpzd1irCJ0jBzXLZEOeoaj0utMWubVT3Rbon3yRmDnCc06PvA6odXWi7KOZzTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjPHFtoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C868C43390;
	Thu,  1 Feb 2024 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795178;
	bh=nf9JKjzsH38lE3eCZPnNOhTo1yC4CQLOdtabFcKTDRI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DjPHFtoGp1eXXv008PQHiY5pJTqCZs624ewY0wMgsItmv0dkVOVcnysPrWZATgaMN
	 XhUUXywBqXc9eRq8fBHcWkbWUXmOLG0xC36AfuN5pew5QGi+zs8432711NbmLrRg4d
	 lgnLVWAktdkBadM6jRk85AxikyPQvG397WArPSOAjH/3hJFmpaLcMk4pbo1YJam+Qw
	 bPthqIAu14uNgHyHOc61/m/X2/oPsoSODqfjCws8NqXZTIcqr3Oh0RCDtUxkI4He1R
	 0K+igg6upuVvpZpyglKoQIZ1Hl4hcakiEdnt/5Fc46hKhioKbTqLlWTw6jnIrNCMXF
	 OA650DzQKqbOQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: andy.shevchenko@gmail.com, patches@opensource.cirrus.com, 
 linux-spi@vger.kernel.org
In-Reply-To: <20240125103426.2622549-1-ckeepax@opensource.cirrus.com>
References: <20240125103426.2622549-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] spi: cs42l43: Handle error from
 devm_pm_runtime_enable()
Message-Id: <170679517728.44749.18221740616934636534.b4-ty@kernel.org>
Date: Thu, 01 Feb 2024 13:46:17 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 25 Jan 2024 10:34:26 +0000, Charles Keepax wrote:
> As it devm_pm_runtime_enable() can fail due to memory allocations, it
> is best to handle the error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Handle error from devm_pm_runtime_enable()
      commit: a6fc5c5b35f688480167a7a7947ddd91c07e72c8

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


