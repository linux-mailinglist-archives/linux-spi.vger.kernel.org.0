Return-Path: <linux-spi+bounces-2750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001CC8BC50B
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 03:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A521F21A29
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 01:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59624206F;
	Mon,  6 May 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOuIEG9P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0944C71;
	Mon,  6 May 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957498; cv=none; b=EffizgillMiw7xyJ/o5p0a3XA5C0jAgpywzpSQrJiGi2CxJdhet0XoEAbByWwdADP4lMNB2IcBR5t38IrME1ZN7rwjCVfU34uTob3nNJ+YaMYu8fhpPrJfnahZePiIunoqToH1uEiVRYKNoWYaIIiJVgjzvbnI/CzsBoiQ+uoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957498; c=relaxed/simple;
	bh=du05CgH4+rHW9mjQn5ukWXtDyAdmeX0fZqLFqHbiWXw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fb8+vmTzbdj5qY/yZXq+PAFdHs9PD7AyOjIZSXAWhb1tD8iKWuLvpJYT4++X/QN0NVuwp0XYGR++JZN/gF/j3nYZYCy5S/LCKVptXtnKuWYEINc7djYCJ1k+J5M4lLMSw5OdCF5htz9ig45jTuukQGTbTlPM8AU3BLt0CAVKLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOuIEG9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA94C116B1;
	Mon,  6 May 2024 01:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714957498;
	bh=du05CgH4+rHW9mjQn5ukWXtDyAdmeX0fZqLFqHbiWXw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=cOuIEG9PAU5z6gwoEtQzbM8lqiTfmITzTsuCfnwACod/yWE5HX4cCP65e4YLgjUrg
	 sSmpnFLhRMT9L3bZqwVG9YS87QhN29pM0u5rb6dPTVVq4sWRG8KPe70dz8EyeBZ3pv
	 zHC6dB46D4oRc9ez0abp/6kWxbAtkuQ//QOj1kbuXCEf4fWG91ES5RISC63v/BrZee
	 Qmt6WYV/l0LJxCDpt2zYdhnDP2AnebwFLjlUH7cLaXTFb3NljtVyszadRopPPlm/dC
	 60slLrFA8dLVTvfj1odBFTgYBA8JLfQyzpPw7FplO298hR1luvDtv1TCn5gz3T7FPX
	 +k2lC6S96DBVQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240503170827.2920457-1-andriy.shevchenko@linux.intel.com>
References: <20240503170827.2920457-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()
Message-Id: <171495749742.1941246.10791450013064725852.b4-ty@kernel.org>
Date: Mon, 06 May 2024 10:04:57 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 03 May 2024 20:07:47 +0300, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-bitbang.o
> 
> because there is a missing module description.
> 
> Add it to the module.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()
      commit: 8ee46db14169fe1b028078767fda904d2fcbc04e

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


