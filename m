Return-Path: <linux-spi+bounces-5729-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562949D2986
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147EAB31A4B
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88BF1D0E2D;
	Tue, 19 Nov 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H77Cyo5B"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10EF1CCB35;
	Tue, 19 Nov 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028732; cv=none; b=txCCbSIJPGZHDp2WwnjoVhVyOhB3VR1h48Gu9V5R9+ouku40p2DUTVxeAYOdCUub6+jck0IJXbsN1MeHepVuI/g9k+pzPJaTel6RiLqV0wQC4WGeJVHWqWol9oMavJuIyVbQl2Eb383QgtTafyPEDIcIA3yLSbjDe+gVY19f+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028732; c=relaxed/simple;
	bh=omKQ1LXz60S6HxBgblXKZPTRNsNAVHlmyvMzW5gHqZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bqU2Crl5CupNBkeuwKkNA1jC95ZN6NVu/snYEFCrRFD6xCXo1D76ukCFD4l6BdMfbe01fJvChPdEkx71PPpFPgsv+Ww+e8i2kmJBcvbbetPCra3UYK6MNXzkJ1RVVEzisPlzs9yFy7K0F2oZTfmYbA/MmHWZ26H21iJgB3//xS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H77Cyo5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AB1C4CED2;
	Tue, 19 Nov 2024 15:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732028732;
	bh=omKQ1LXz60S6HxBgblXKZPTRNsNAVHlmyvMzW5gHqZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H77Cyo5BofT2Mo7U07KbqxmaNWxSV4hXPpQ0DwTbvqnnQCsF13MsdlDphEyJE8xod
	 MSwHsn4XMe1f5J+5iZN0ln9IAaSuTBtoEzELQPLJQPQAl2tVlfo5RT2+ylHIEt8aZ2
	 zSzWnGqSVOwWRbSs1BeJjN9pRuEbwggP3L8Wc+Qgh29SxKGOA85b4YgghDaKfq75A4
	 QyrpwI1LDYJa1gjr01Q2XgtfBeHy2ByCbfGQ2aUcewiEp9zkuuaPgDKeo/vuj1+HpO
	 KhUCoijwlQDUHrg8uVAk2iGkFEzVeKtz30NJ11GSWPohoiglqhhqPFYrP0xnOaBZfN
	 rZ5w7qR1oB7zw==
From: Mark Brown <broonie@kernel.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241118145646.2609039-1-jon.lin@rock-chips.com>
References: <20241118145646.2609039-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Embedded DMA only support 4B
 aligned address
Message-Id: <173202873074.60406.1798640869476341414.b4-ty@kernel.org>
Date: Tue, 19 Nov 2024 15:05:30 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 18 Nov 2024 22:56:46 +0800, Jon Lin wrote:
> Controller limitations.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Embedded DMA only support 4B aligned address
      commit: c752e87b9c3982b78dddcdd70dcb826df3cfd75d

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


