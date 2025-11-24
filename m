Return-Path: <linux-spi+bounces-11489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BAAC82402
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 20:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFE6134A7D7
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 19:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC02D73A6;
	Mon, 24 Nov 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHkj7A6O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCF27FB18;
	Mon, 24 Nov 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011718; cv=none; b=HzgBNc+uhwmwJqs9qaQKd4lx9xjqApSpU+9tF2RSbSylr/0CjtfP8FgHq6pcC+Cj2pYvf6bvp5zIxxZl3MuGk0K8SLcbXPJsIxHWxo8eDy6UG7tyJ/fYNXY6F3XHJEKSp/ZKJikTdT5J/CqRDsEJyCPJ0gg+XompprjnpyBsklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011718; c=relaxed/simple;
	bh=+QwuBL0wNKIpCY6FHQZUa+NQUqMLdd9Q7/OdSTIYHuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tdkZv/mesVwpA2Qc81ulv0ECXeWyAtLQPAVB0ZNnKKp4YRn20jKDMf+hVp+d0o1Ju/NmqXyG+o1C+axJDuarMT6S5pH75DLbxEiR9v0LP5+hJpm6HcS6+MDN7h8spMI7dlUM9qLOKRKdm78pFtFGpJynycSsKxKaLhivQNW3bIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHkj7A6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD832C19423;
	Mon, 24 Nov 2025 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764011717;
	bh=+QwuBL0wNKIpCY6FHQZUa+NQUqMLdd9Q7/OdSTIYHuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lHkj7A6O7+0ZbDXcvlzmeSRmmRuGdTxZ7kIG2e6JGpDpl56ZbsMJo9Ih8z4RDSjjM
	 0Gui6etj7vFRtppWeJMtfAKEVMJPQq/pLgSN0HRRxrkPwpcul5lu40BbuE1JUISEQV
	 0ZN3OMjJaUOFTRfVBP3bFyFte4WVY+bODKP+2sYvaRMuPx3hTT5E08MrLXe5/q3Zmu
	 i8LW/pYpD9tgc7fto0fllzvkIb1eT+wxA8OfS0s5hLUPgEid+JHQIVagjaKuklIR+S
	 /rDZ4BUjzny1yUz/YCYeguiFbYWA3NiWXNcqDF6v9LiONQKoIWMW9CHkDJNDzy7kyG
	 aHTLgbv5mg2vw==
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aSQPkfkiJ0w-FJMW@stanley.mountain>
References: <aSQPkfkiJ0w-FJMW@stanley.mountain>
Subject: Re: [PATCH next v2] spi: Fix potential uninitialized variable in
 probe()
Message-Id: <176401171651.101831.4873072118786072827.b4-ty@kernel.org>
Date: Mon, 24 Nov 2025 19:15:16 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 24 Nov 2025 10:56:01 +0300, Dan Carpenter wrote:
> If the device tree is messed up, then potentially the "protocol" string
> could potentially be uninitialized.  The property is supposed to default
> to "motorola" so if the of_property_read_string() function returns
> -EINVAL then default to "motorola".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix potential uninitialized variable in probe()
      commit: cb99656b7c4185953c9d272bbdab63c8aa651e6e

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


