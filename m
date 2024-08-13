Return-Path: <linux-spi+bounces-4174-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECB0950881
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0309A1F21C52
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38F19EEC7;
	Tue, 13 Aug 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGzFbalx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910613B797;
	Tue, 13 Aug 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561655; cv=none; b=Jy+hj0iqubmFia2kUURrzefk2qW89jB0K/2vMmUQ3tpQVyrAwuxlU0EMSDNfQdqYiFzES3Z+9YhgugPg7oXB/Hug3dsbIClOLH2DML4HrQLGyKT1Ug9ttxN1U84RZqnK5lDD0h/cy3lUgYZ55DXExvS0EH0nEvXFza4JtxkcuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561655; c=relaxed/simple;
	bh=Q1kOwnydh+q5wn/GtqDPJCn8l91T/EYE7DPSZ9zWuWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ci8zrl4CQzjRLPeZlkmb9xVvDEn6BtXPUqBhDTaKw1pZT87V0qGaTVxqB9h+JM1LCwnM2pmX/k+3qjoRbj7D/LkGF+dqO9i1d1bTlL+mPTcg262DTKVgDib6GYLELq8mMOexv/tKmAM6N9Z+Xf+NBzGXXHEvSpQrK2rIpRc/8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGzFbalx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601BAC4AF09;
	Tue, 13 Aug 2024 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723561655;
	bh=Q1kOwnydh+q5wn/GtqDPJCn8l91T/EYE7DPSZ9zWuWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BGzFbalx/YQGCjWeTDyNRiwxySa14d95PqPJBclEaF9eHM5ted/1AdiYnu2DUjiqJ
	 i7455D4bPgTdg4NtNFkW+IlDkU/eirQ17VqHDOmH3DHIZ3upnRrRbkcU7+6nCvxpc6
	 DIaSiHSHAMM1HlFXd3rhG3OVuZAKGIfbOLC9kweelQ9x3OO8tPBmtcdgUYP3KZhJ1d
	 MhY64qKQken4jkoSOXpjln3Jjbx1vb3tCUfXDfV8gwxAikF2TCUQU98EgXlo2iakRv
	 vjT1bOH4TNl+5Pvj8L+2c3NmAcgN+bdrwu8s17wPJqAPEmLWaRd3yC/hV3cVCFhTYo
	 x9KZ9Yt6/77iQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, 
 Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240809201540.3363243-1-sean.anderson@linux.dev>
References: <20240809201540.3363243-1-sean.anderson@linux.dev>
Subject: Re: [PATCH] spi: zynqmp-gqspi: Scale timeout by data size
Message-Id: <172356165412.69018.3689361849577189863.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 16:07:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 09 Aug 2024 16:15:39 -0400, Sean Anderson wrote:
> Large blocks of data time out when reading because we don't wait long
> enough for the transfer to complete. Scale our timeouts based on the
> amount of data we are tranferring, with a healthy dose of pessimism.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: zynqmp-gqspi: Scale timeout by data size
      commit: 5d61841c74db8b5bbbf9403f1bd4879f614617d2

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


