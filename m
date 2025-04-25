Return-Path: <linux-spi+bounces-7759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B679AA9C8CA
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 14:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED9C9E1E46
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86C2472AD;
	Fri, 25 Apr 2025 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1Vz4erU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D92451F0;
	Fri, 25 Apr 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583460; cv=none; b=PuYtKxjl5ntr0eBOehvLQNfxHz46Axoq7vYd0doeP2Fva8RRUW6jcpnnYFb54EfZgtv4sfceIlcEq3qHef9jxvJXbWUMj2b19P08OT0iI2Syv0omBOdA+Z4YXCSlKgILZkCw44Y9f5TYgUUDO9sRIWqmbE0S63heG8RtwNLSC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583460; c=relaxed/simple;
	bh=4MYw+OiWjZy5NvznOlobaVbCe5rT9u35DDQsuwAxFjU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KvY1SQc2I72n8Nq8jV/4utAFuP+said6rRxVGTNRS+IzFIQcrK7gCl5iwDxkglNhq2oeaQJmNFHduBBGmIjTjvzuQ+ijcH8Hg4orczsK8dhDDaGu1cTFu0hrEUiiAof+ygqvWT6eE410AnuoPIaG21R4A3E3CSlJScPOg+AXgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1Vz4erU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C66CC4CEE4;
	Fri, 25 Apr 2025 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745583459;
	bh=4MYw+OiWjZy5NvznOlobaVbCe5rT9u35DDQsuwAxFjU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d1Vz4erUhPGFhzsnAAeuZ5NElwklcHXMRTNQM7LTtlMIzmi1z62RWza4rm/4RoKRc
	 ztnKRz8avF+zp0K5+ZuNHbcPUEQBLgdtkRlxwTm4/jthwS/pEvl3j3bR4tm8HI9q1g
	 v5au4njtwe/A+SkRvMjT9xGb2eWREoB5fcyRyS5IzvcxoxKOYBnF1+2MCXTko5/8cz
	 uFQT1vRHR/2XI13bXtTP9xx/F70b01jk2LhSCm9PeA5JL+GwuXmbJn8BRSucyiT0xb
	 bU0lhpmhlKICUj/venIce/kMYbKYg92xjUbrS7BaW2baonQsVWd5y2QRTlBRcM7+GX
	 jwdEuSp0jnPrg==
From: Mark Brown <broonie@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com>
References: <20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: propagate errors from
 qcom_spi_block_erase()
Message-Id: <174558345792.35738.16221002646787907698.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 13:17:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 23 Apr 2025 21:31:57 +0200, Gabor Juhos wrote:
> The qcom_spi_block_erase() function returns with error in case of
> failure. Change the qcom_spi_send_cmdaddr() function to propagate
> these errors to the callers instead of returning with success.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: propagate errors from qcom_spi_block_erase()
      commit: 722a6ad4867ce8c4cb131a3371d0b5389a75dee0

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


