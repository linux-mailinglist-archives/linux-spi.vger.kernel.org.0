Return-Path: <linux-spi+bounces-10714-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52839BEB389
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05FA24F4D5A
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE323126A0;
	Fri, 17 Oct 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chBEFcY5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4C2FFDC8;
	Fri, 17 Oct 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725693; cv=none; b=d9NU3O2Q3hzht78KV/3ZffVALSU/SawkKwFUugHTgjDLE6dFpwgxr+HZpi8b1q3HIYRTAH+RcPDlL676+/ARjTiy3oE7UTOErAzSDL4F2keUvoE0CMWEAKhkHWjAoCH92QcZNOgLvJBvsR96VbiKm/2bI71B2axabTHaHe7vZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725693; c=relaxed/simple;
	bh=5cLbT2X/tFBAuRxHE52sCqVi7oz0uWxIVRufr/jQJYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oBzVpuOEXIAO9Y+kcFo3GUJAmoAoqMMeVPw8jpPu9ENe3IrQP2e8Hcg6JnDLFtFSDiibeGpczLgfrvGsz3mXV2kTzmc3rVLXHXJ5Z9E0WCyaNGrGWi4fNgjc4pTsSEsh5dMYvkMuIG+BloyOmZUU1yITeX3x7/GTC/xLJkLuGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chBEFcY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF90C4CEE7;
	Fri, 17 Oct 2025 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760725692;
	bh=5cLbT2X/tFBAuRxHE52sCqVi7oz0uWxIVRufr/jQJYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=chBEFcY5D6V/OVnkuwloQIaEU+vfkYkFz5RxJnY+9NXjZQ7BbJosIJbgJXDlr1bf+
	 w9+tNKVkdDG2Hw4mDY8FrQqIWm+MeuG13+meKG7tvCO7jCE47Vtny1281/zWVln8qh
	 JlxjbWX+nBAEe3wlIWdbJb/w+UXmfjVOXsS4anWyA2hr0EXJqPQhLmt8ZW7sx3A/xQ
	 gmQ1sZdw+PTM/m6osVZmGM0EWMeXwmQDGklvG89n+1xPNZdoRUxLq8YjzXCCCdiHX3
	 fKZukgNFYGNI45Qe6nXIq9hndvGxEJ6hM03KpMNwysxVPRMMXxld2w0q1ZrqjdNnbE
	 652G/X/933IHw==
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aPJpEnfK31pHz8_w@stanley.mountain>
References: <aPJpEnfK31pHz8_w@stanley.mountain>
Subject: Re: [PATCH next] spi: aspeed: Fix an IS_ERR() vs NULL bug in
 probe()
Message-Id: <176072569036.192503.11424414988999143165.b4-ty@kernel.org>
Date: Fri, 17 Oct 2025 19:28:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Fri, 17 Oct 2025 19:04:34 +0300, Dan Carpenter wrote:
> The platform_get_resource() function doesn't return error pointers, it
> returns NULL on error.  Update the error checking to match.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Fix an IS_ERR() vs NULL bug in probe()
      commit: 0cc08c8130ac8f74419f99fe707dc193b7f79d86

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


