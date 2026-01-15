Return-Path: <linux-spi+bounces-12396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D343ED23CB0
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC04830006C4
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635D35773B;
	Thu, 15 Jan 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etyY3ota"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7A35E52A
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471207; cv=none; b=T1L2GyIj5y0gDLbOQ/YGrlGOCYUHgUIzYnBGZf/WkOkR7p4ICWB/3D62U8aEOdSTyR/FJXndc64ixHXIm9IvYeJgBMCIG4vcQTk4opkjb75TA7wIWrDJPjCG4WPFOaHxnjpAhyTfSjEmDHRX7y0aP7c4Fwwkd1MxM+lOz9jgJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471207; c=relaxed/simple;
	bh=Zv6Sn17Kk12Fxbp+tTZ9RBpea7xRHv4mTszSrMQAUo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NoFU5hTtE+1EOybwsJg2EkGwwvXYJWsAWR4ee5cX5YkBWOk5P5Y0y1S9TulA0mqLAsDXWZoDHaSr15UNSSPresEF685408pL77clhg8Cwhich6LfrBeZCpl5F1pNXYCJFTOAMk22el3F7EstuM/jV6rKFYZof6iQsJS5jpT0Zzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etyY3ota; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C21C116D0;
	Thu, 15 Jan 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768471206;
	bh=Zv6Sn17Kk12Fxbp+tTZ9RBpea7xRHv4mTszSrMQAUo0=;
	h=Subject:From:Date:To:From;
	b=etyY3otas22ai8opQ+Qxgw4anP/jw8mM8Ply1HODP/aeo1NFBvrUm4MicO31xrj3N
	 MdJt3ueSO7pdvsvmvM54UBtmN8Ll32lYisnub3h/hH4ahjkAUwY4lRK8KauOqXK2G3
	 12hoamEDVEAtcfh0DOnKqb3ZONeNYbbQos6dVCFTgwtRWAhS6HXJeTRgcYkryiW/ud
	 /AyY8JO2JYNJpgcpYkEGEYoUz4Kiwi5EK0rjJ1Cw6a1ZAco86+lwZ8tBjKydnxtKnM
	 thRKl1r7mZso6NlqPRnNldDvkAO2p5UA4U6kwn1Gs4uLCGgIPF91vS+FZm4GDyjmxe
	 5Ac5Q8UemfP0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C007380A95F;
	Thu, 15 Jan 2026 09:56:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176847099895.3920084.2387210167591702426.git-patchwork-housekeeping@kernel.org>
Date: Thu, 15 Jan 2026 09:56:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cadence-qspi: Add Renesas RZ/N1 support (2026-01-15T09:24:51)
  Superseding: [v1] spi: cadence-qspi: Add Renesas RZ/N1 support (2025-12-19T19:22:02):
    [01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
    [02/13] spi: cadence-qspi: Align definitions
    [03/13] spi: cadence-qspi: Fix style and improve readability
    [04/13] spi: cadence-qspi: Fix ORing style and alignments
    [05/13] spi: cadence-qspi: Remove an useless operation
    [06/13] spi: cadence-qspi: Make sure we filter out unsupported ops
    [07/13] spi: cadence-qspi: Fix probe error path and remove
    [08/13] spi: cadence-qspi: Try hard to disable the clocks
    [09/13] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
    [10/13] spi: cadence-qspi: Add a flag for controllers without indirect access support
    [11/13] spi: cadence-qspi: Make sure write protection is disabled
    [12/13] spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
    [13/13] ARM: dts: r9a06g032: Describe the QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


