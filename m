Return-Path: <linux-spi+bounces-2673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74758B8B74
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5001283700
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7B50A77;
	Wed,  1 May 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWs2piy9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C71758D
	for <linux-spi@vger.kernel.org>; Wed,  1 May 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571271; cv=none; b=d7L6lLtu7IJUtDbc51RrvE8TX6BCLz8RRLdGAsV0BoIsobIXqRVVdcWOwMioAutPj4e5N0PWTlgSmbTAGsgNtA5aETM6kPwIP0lwSUYO76yXzUarXQQVp3ZQaG6q7/2Zo3JoMEsO5Fb3yDyBmJunPT03ZAzrdIHqk2buY52vIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571271; c=relaxed/simple;
	bh=epZmUU0/bZ2o5icUlh581ZrSDK9kYUdAo4qjaFJ/l+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Aa1wLHE6u/bTlbhg398kuuKQ5BnpxTkh/5xIxkmEtclIpw3OwagQFsxjKc3EEQzpjq8ULDql8hDPEvaBokDtMSbnXAr7kEaMFG9Tvya568w2Qn7QeZ4XKOIFCvPsHRn1tXhHWtrQxU0YEGcv8RGCe//RI9vZ1yRV4V3ZsRy03gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWs2piy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F7AC072AA;
	Wed,  1 May 2024 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714571270;
	bh=epZmUU0/bZ2o5icUlh581ZrSDK9kYUdAo4qjaFJ/l+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YWs2piy9FJXEQEOsTRFF8dezqagi6MYFoVOSG6C+K8/C0H1v0YbFMQOuFVHGCBIG2
	 P6agSoqR5cBbXU67aeZnsPj4tTolM2rTKfhBkojXAYaKewI2BVYJs7mYMO3C49QbBr
	 rz+ChcQqmt3RJ8s57T4tIPakXhT1wxb81egnHws919+FGrd0xnst5sLWnX971lcnbT
	 1t1De+rFhS31E4ySO2L1I0yyddZZpcYW3i+502uN9fgxc82bvC5+SiBHcfQsT2HigQ
	 b3PXC73dIWNjK6LwbvW9xpxKF1XtNGgs2JZTF8w/D2DMjzAG+9BPYb9RQqbnYXYkGn
	 xyEC/Nnqd9GPg==
From: Mark Brown <broonie@kernel.org>
To: Mans Rullgard <mans@mansr.com>
Cc: David Jander <david@protonic.nl>, linux-spi@vger.kernel.org
In-Reply-To: <20240430182705.13019-1-mans@mansr.com>
References: <20240430182705.13019-1-mans@mansr.com>
Subject: Re: [PATCH] spi: fix null pointer dereference within spi_sync
Message-Id: <171457126983.1892571.15279588004472260364.b4-ty@kernel.org>
Date: Wed, 01 May 2024 22:47:49 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 30 Apr 2024 19:27:05 +0100, Mans Rullgard wrote:
> If spi_sync() is called with the non-empty queue and the same spi_message
> is then reused, the complete callback for the message remains set while
> the context is cleared, leading to a null pointer dereference when the
> callback is invoked from spi_finalize_current_message().
> 
> With function inlining disabled, the call stack might look like this:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix null pointer dereference within spi_sync
      commit: 4756fa529b2f12b7cb8f21fe229b0f6f47190829

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


