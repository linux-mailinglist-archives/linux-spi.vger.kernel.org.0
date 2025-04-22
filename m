Return-Path: <linux-spi+bounces-7714-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6662A96C39
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 15:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECA43B5F9F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC328136C;
	Tue, 22 Apr 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEPQ+72b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BB27CB15
	for <linux-spi@vger.kernel.org>; Tue, 22 Apr 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327593; cv=none; b=MbOm0EmIcUDNBjMYg5YAI5k8IHL0Li1s5x8TXXb0kp6vRg2LCEXl4PP3nAjxz0VeouFtErBVR5PUD9EKPxUi+U76o3bJUgFQTS2T4OUivZIz4n9dw5JpOMvdXV/AzBr5Kit7ROmay6xyezCa+k2BhxDJnD0v8F0t8BWkn8p6k0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327593; c=relaxed/simple;
	bh=ce5BCnRtaHmECacsxgCgyVWeVIfgO0I8Bv9XtCLHKy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J/6Eg7NG2CjptbocaJHMCPQPWDO9Fj/XcSJlNTFvMQWmwo+WDWhQlBeI56t89GfYHXRRpaz4/up+ZyLtPYFToQnri9BQw3VIeXSfKOHE843JiyG11SaRMuagIUw94uDIR7+XBCSZXQ9Jib/ovBWoib8P+YgFPBG7Ps35ay+r9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEPQ+72b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C44DC4CEEA;
	Tue, 22 Apr 2025 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745327592;
	bh=ce5BCnRtaHmECacsxgCgyVWeVIfgO0I8Bv9XtCLHKy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aEPQ+72bKEsAAojGN2pUauXS8ohYN+wBu1hT2X2siCuhePuQlzSMlRgYgXmx5UyUj
	 MfOJtgCebpCNpLr66hc0M9NQ34WCYwbcx7xYyIe5AcL88+EIAnmI+JVMMo2AiO0Sxi
	 up89qAtmOtJmGtc6k39GJtgSVPDWE/0nwcFadqIJQS+L4tgGZNAv3krzr6llLMC1ot
	 rvEzIKPYa8stgi6ddDMf4UvH7GiTs2TestH367hw7pt2VoxZbacPAVJS3w5g2cNcgY
	 bH6kn2w1nEgSGs3WRKBXH92debPhFkg9a1/eFIbeZmh2P74rk1dzKEZ8qmVXHVUVc2
	 VZmDbfHLFGNMA==
From: Mark Brown <broonie@kernel.org>
To: dlechner@baylibre.com, Andres Urian Florez <andres.emb.sys@gmail.com>
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
In-Reply-To: <20250418224750.46219-1-andres.emb.sys@gmail.com>
References: <20250418224750.46219-1-andres.emb.sys@gmail.com>
Subject: Re: [PATCH v2] spi: offload: check for match callback when a
 trigger is being registered
Message-Id: <174532759176.44373.3150193355948451411.b4-ty@kernel.org>
Date: Tue, 22 Apr 2025 14:13:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 18 Apr 2025 17:47:49 -0500, Andres Urian Florez wrote:
> Make match a required callback when a new trigger is being registered,
> this allows that other functions like spi_offload_trigger_get() could
> safely invoke the callback when it is required
> 
> In v2:
> - improve readability of the condition
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: offload: check for match callback when a trigger is being registered
      commit: fcab1637bb115b3b7bbc600a6d019b785653f2d5

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


