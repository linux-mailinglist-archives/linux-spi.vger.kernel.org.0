Return-Path: <linux-spi+bounces-2307-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556C8A1406
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EECB21C6D
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE014B071;
	Thu, 11 Apr 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvqJa7PG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118614A4D4
	for <linux-spi@vger.kernel.org>; Thu, 11 Apr 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837429; cv=none; b=ZAtjLIV7s+lb2i2jm7YtkIoRDqysDGO/3vqdLdX1orUWqt7mLCfU58BxWnw5nkO9A4PzJOTLiV+5JjQexn+MnDzykP9o4tvYiEwwIGJ8niXBWxGIwmYfba52vID52iBWQonI6lFmCJrclobUB8eXuanwjQ6Hqs7/Guyq4mwe64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837429; c=relaxed/simple;
	bh=xkLDCjHIwk1dHFDuYzsn2mI41ZlScjs1Oecq1tiKTF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pDE2SaMnEDBbIkgRKqi4tLry5LS3GeGpsyyXnAmaK+uswn9wuUQvKMmzNKDv+8lJIWklmdiTG9VeaXryBvCZJUBCL99YbEJzXyJd4bV4iMdQTY8ucdnWkQfuko2pn2nfubFut4ndDcbOtwbifbzMzJo60KoBrYfzsRS/6ADE+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvqJa7PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12DD4C433C7;
	Thu, 11 Apr 2024 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712837429;
	bh=xkLDCjHIwk1dHFDuYzsn2mI41ZlScjs1Oecq1tiKTF0=;
	h=Subject:From:Date:To:From;
	b=lvqJa7PGVQaO6Mq+OvBRTaSK+SoxJI5+5FCEmuWBRAwlOMuztVwY1EewBgBIEPJgU
	 RuJNs0PfsCaQwzv0BbKPho9kaZi2JESP+Zl4xM7kyWWJ060qzIGPN5OXm25e2z5aOi
	 eokEe/wkjuoM63jjpESMiKG5HHnbwkREkw1JSamBqJ3B8bPUQnwiM6T/Xb38HDSd/2
	 ImmZJNg19X40QwhZpdCTLvwj9AvdjBHks2W2y0Zb39qxR/02nFQenA0bdnlI+tmdSf
	 pQpPfn8couiWeMRbQ/1q81lw5wDVRxWS7WojwL2qRn01YxVcQaQMDucwNVq5BQP9ZQ
	 OKGMvf9zl6q8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0220EC395F6;
	Thu, 11 Apr 2024 12:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171283742894.10364.8480621754262335374.git-patchwork-summary@kernel.org>
Date: Thu, 11 Apr 2024 12:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-qspi: add Mobileye EyeQ5 support
  Submitter: Théo Lebrun <theo.lebrun@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=843157
  Lore link: https://lore.kernel.org/r/20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com
    Patches: [v3,1/9] spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
             [v3,2/9] spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
             [v3,3/9] spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



