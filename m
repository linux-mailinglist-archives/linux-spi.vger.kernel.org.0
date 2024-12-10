Return-Path: <linux-spi+bounces-5988-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5894A9EB186
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BBD288B94
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7311E1AA1D8;
	Tue, 10 Dec 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9SKrsHE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C51AA1D0;
	Tue, 10 Dec 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835649; cv=none; b=YLsYP/qZ6PYNNfEqHhakxFMeJNZudRErMYpuLK55sPtzgsU92JdXX0LXNtrKPbL4c8DLtFFcdovKFPt+Q5ZaCMuDvnKej/HEU14SVnmjqD/aMzzEjVxEX9byQeH0EqmiSYra0/S3+myKXNO/wHA7DhiQ260psSyiHyh+r/bcvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835649; c=relaxed/simple;
	bh=It95SmPzI/uYFCjtze9WMOUpDuiAQUXv/qlPmJM0ve8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XeEg1eLxuBNA7EdEFiw0avaB3SLhCtFh8s4O0dUwXzvJyxirn7LiuyrSLd1m70VpumyzNnqZHocLYFi+lmnYCpMa1ukfF22W+zQoGRjF2koeCLyLng5+shBYY9+37w+XVMohwGHj4l9LrIEYuG+WGRDPiLN1+LrWLgkEOEjDBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9SKrsHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A25C4CED6;
	Tue, 10 Dec 2024 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835648;
	bh=It95SmPzI/uYFCjtze9WMOUpDuiAQUXv/qlPmJM0ve8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=R9SKrsHE+ljnN1+7oc+xCpVBCJmBl+jl0GuhyhWQxdz63bukx3CEvjlQUJ+IIyLNN
	 DXqy9SSiL0ExmnqpugBKOppHMeSDW/IjhSsC5qj7PcAz7m/4NJ91WIXxIu4iwhQj+h
	 lUSk1WsYKq32FUtR9WfG+6Tos+lJ37d2wdJ5F7zgJpEF4VQWF9ODyelHfe7Hje1sJS
	 qQfmqqbL4G4l+ztD1huFBAqSgXybb8hhnOdahXKzq1YHhBxTWWAB1N0naH+SqYH3/h
	 NcssqUasHExtd1gaBvZPTJs+nYYmvM5IoPB4heXh3lwN6Fo5UBDanuUG2gmll4ux0a
	 wH/tEoctQW6mg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 niravkumar.l.rabara@intel.com
In-Reply-To: <20241204063338.296959-1-niravkumar.l.rabara@intel.com>
References: <20241204063338.296959-1-niravkumar.l.rabara@intel.com>
Subject: Re: [PATCH] spi: spi-cadence-qspi: Disable STIG mode for Altera
 SoCFPGA.
Message-Id: <173383564799.34030.1706263961375450973.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:47 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 04 Dec 2024 14:33:38 +0800, niravkumar.l.rabara@intel.com wrote:
> STIG mode is enabled by default for less than 8 bytes data read/write.
> STIG mode doesn't work with Altera SocFPGA platform due hardware
> limitation.
> Add a quirks to disable STIG mode for Altera SoCFPGA platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA.
      commit: 25fb0e77b90e290a1ca30900d54c6a495eea65e2

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


