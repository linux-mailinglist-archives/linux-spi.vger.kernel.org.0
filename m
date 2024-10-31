Return-Path: <linux-spi+bounces-5576-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBA9B82EB
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 19:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C971C21AFD
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD571C9EA1;
	Thu, 31 Oct 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVSb6xOZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449513A865;
	Thu, 31 Oct 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401014; cv=none; b=oDAcp802hPLbcEslGK0yXDW/B9i1tX4n34H69MmHfGUWmPuhPjo9SsRi6AWIIXyQa2P2NUmD50VpA+yAoeDI+18AM96PrIZOac71OzyB1pbkaT25tB1aEhr6VG3NXydoVLryfHcGl86ETw0RxIA3E84BsNWT+ndNKV+wiAUxsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401014; c=relaxed/simple;
	bh=vpa+AfaQ2UYbWDWP+bn9pYmpp+731Or4NVOZhwUaLUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dADDL/MqGvmBUK8MYWKIyO0yplCKTHKQWh/oR2ppFSQPZjLAvqoaljw8eeAgYBkB52oK0xFaFun4AODT5RY8NH7We+a8MHT/ehyxJ5TzNVecL7Uh2lPfmoxDYdaX4o9jimZvIa2nK/Kmpubl1CeNSBKOIN5sisb7rnvBqBdNYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVSb6xOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0648C4CEC3;
	Thu, 31 Oct 2024 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730401013;
	bh=vpa+AfaQ2UYbWDWP+bn9pYmpp+731Or4NVOZhwUaLUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tVSb6xOZYzm75G0dZac5PNQECoEUP1HyCbljiC6sbqjV5HxNPl1HtN2e1KP8cebnW
	 Uo/ZuDpdrts6dinRsK+FoeVsvusjgKhLBhnEQ1ggi8ApB/gZpUFB599bI/F5Zr9cid
	 YhG9e3HsAs1oHJ4NP8Go+viS0y+Qd4XbTLTzgpvK7ZB14BGkF3FziAEhKe+buLZQoN
	 23PCHCd4QsjCLn9mArVeoeDDAVWdEWf+zSkRzqEym3mYTDpZduHPW+F/L4kez7flpS
	 YpcU1l746fi2mkrS+udzLSfJ9tm+T7nJ+dUabm7kLre6GBYfcvbmhusYW1eAsCMpr7
	 TJVJ1L8rBNdYw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <ZyH2P3FlneLtGxXo@standask-GA-A55M-S2HP>
References: <ZyH2P3FlneLtGxXo@standask-GA-A55M-S2HP>
Subject: Re: [PATCH] dt-bindings: spi: sprd,sc9860-spi: convert to YAML
Message-Id: <173040101151.938392.8456134374988290865.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 18:56:51 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 30 Oct 2024 10:02:55 +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 SPI controller bindings to DT schema.
> Adjust filename to match compatible.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: sprd,sc9860-spi: convert to YAML
      commit: 8a9c132389bbd162336fcbe6725692455151bd7e

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


