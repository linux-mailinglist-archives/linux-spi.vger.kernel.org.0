Return-Path: <linux-spi+bounces-3053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2BA8CD7DE
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 17:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9115282BB9
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6861400A;
	Thu, 23 May 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6B5koh7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810E12E48;
	Thu, 23 May 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479772; cv=none; b=LlKwK/RI5S587mjPYI/hXnDwakDwKasamhEo6mvKJBquk3OofsT78LUuuzZKfOCe9dvLFScYimeevr0+VvgowsqrPNQDhTNoBqxBGo+SHWhUDBC0fK7mU61Ry/QVJ7JXASHESTRSYmVlaazw6oLiphMXauMQWFmRnvXgsp+GQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479772; c=relaxed/simple;
	bh=kwlOr50hDecx9CSQs76/4I0/JMtKbZpx9ixjyWXqNXk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wd+mjugjwF9UwfaZDIlVVDhwdU4xa+CkqjWeA928Ny9Uk7x/9mHeg/WJcNYGP3klZJO/g1DS6rkzjiHUzJ0PkzfIJSlBUQozcZgviJtXxg2D/rfcqeg3GyDz/9jiAwHDlBxuRyvt22F8FS944zeUQeuXFgm1o5/2jqSw8ljiHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6B5koh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9E7C2BD10;
	Thu, 23 May 2024 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716479772;
	bh=kwlOr50hDecx9CSQs76/4I0/JMtKbZpx9ixjyWXqNXk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=W6B5koh78mxM1zYbqMEHsAzILo3+0hmqtLrrd/FSbK1CEWdIWlutnR8AkPZsR3S11
	 EpkG7uVElOCXLDQ+NlWiMR04HUbytcN0hyH+UWvFSL/49DNsI6KOcOWlsJrMktuIed
	 Dvt/lUbxd8EdivBpCrGja8mMJeP00B26Dms3KfmWborp/hGn12Qh1Tg/mEkQICLkRQ
	 /muyz9hRhl+KpAZ50J9NTBlJnDjoZAdA9fuJo9E1LxVcaZFM7ITHiv9H02aAkuTiyP
	 kDOozXTdVj5CdMNlNUYikHF5iPFSuP0MA9zdPbjU8Ki2dHzDSrMNuj/paBZk0NfQ44
	 Q2eLzaxbEU0zg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] soi: Don't call DMA sync API when not needed
Message-Id: <171647977136.55224.8875410677372985509.b4-ty@kernel.org>
Date: Thu, 23 May 2024 16:56:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa

On Wed, 22 May 2024 20:09:48 +0300, Andy Shevchenko wrote:
> A couple of fixes to avoid calling DMA sync API when it's not needed.
> This doesn't stop from discussing if IOMMU code is doing the right thing,
> i.e. dereferences SG list when orig_nents == 0, but this is a separate
> story.
> 
> Andy Shevchenko (2):
>   spi: Don't mark message DMA mapped when no transfer in it is
>   spi: Check if transfer is mapped before calling DMA sync APIs
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Don't mark message DMA mapped when no transfer in it is
      commit: 9f788ba457b45b0ce422943fcec9fa35c4587764
[2/2] spi: Check if transfer is mapped before calling DMA sync APIs
      commit: da560097c05612f8d360f86528f6213629b9c395

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


