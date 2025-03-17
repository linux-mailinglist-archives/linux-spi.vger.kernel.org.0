Return-Path: <linux-spi+bounces-7180-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD43DA65E43
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 20:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126C116163E
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 19:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB81F3BA5;
	Mon, 17 Mar 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX1nIBwZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634001F1934;
	Mon, 17 Mar 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240578; cv=none; b=BzS7BRxKqZtvcfmxEhBF0MTkA8cOQDnehIomO+bAYdvZSOGlcav74GapK3sJSjpHiqmWHfI/SNVtSgkE1+NPoB/vxgaP/5yEFtjoOLihnnoLbeqbTSZ2gGCN70ZO/2qH7T8wG91GbVTLjFROiqXq3DnEenWxE/LMC5p3nThxfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240578; c=relaxed/simple;
	bh=pixIi8HOmDovFYgnyjMAMsQG2ysAU7ZNKHEa2xoDO5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dGPEy98Q5iG7GUhqVG8LDcdQx8rlEzRtoYZq95Aq5oEA3IXnnb5DsBRtXqoLB6rJmGJLBxIe72tbxegmqkoZkYiSi+vb9XFKkZwKSeSZi6rFhE+E+Cbcj/+kfX9b+1zsaF8rQZuWOhZ2EZ5vh7EhMynLtwD55kFWVpj1rtrVeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX1nIBwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F5DC4CEEE;
	Mon, 17 Mar 2025 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240576;
	bh=pixIi8HOmDovFYgnyjMAMsQG2ysAU7ZNKHEa2xoDO5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YX1nIBwZQy/Vc0u8YC8qCO51Ck8f28LvtMANqRbEtOnyUbdjX08bwZHS2SSlm+Lgx
	 qoW1ASrhC/g+cYOV5aV6se0U7Tb0DFCN3XGTL/xZep4c+XCfnhNBInZViAGa7+9XaU
	 GMXJ27AhKkDyHefaTeaJbnfLFNeanc332M6lA3dDFC+ckXlh8L01nUP3bDPAdHp9Ru
	 ubWy3oguPZsjBTUccWCEgXembBKFOWg8nxCYQkoE899rhHc+FYRA0Smg07DihSa7f9
	 NwrZ2fZs9GFyHYqTIfpLM7blMbQaAudQs0qClVwmWRnZZHzn9JdhO/pmvUfGDqvK5N
	 T/6+WmPJvtp6A==
From: Mark Brown <broonie@kernel.org>
To: skhan@linuxfoundation.org, Sergio Perez Gonzalez <sperezglz@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250316054651.13242-1-sperezglz@gmail.com>
References: <20250316054651.13242-1-sperezglz@gmail.com>
Subject: Re: [PATCH v2] spi: spi-mux: Fix coverity issue, unchecked return
 value
Message-Id: <174224057580.315737.13134675216872556124.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 19:42:55 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 15 Mar 2025 23:46:06 -0600, Sergio Perez Gonzalez wrote:
> The return value of spi_setup() is not captured within
> spi_mux_select() and it is assumed to be always success.
> 
> CID: 1638374
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mux: Fix coverity issue, unchecked return value
      commit: 5a5fc308418aca275a898d638bc38c093d101855

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


