Return-Path: <linux-spi+bounces-6611-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA668A25F85
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 17:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A421D1885E0B
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6D209F4C;
	Mon,  3 Feb 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ/npHv3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D51D63DD
	for <linux-spi@vger.kernel.org>; Mon,  3 Feb 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599008; cv=none; b=tdLBRJ3hUv3/Wp0pGlgwrYGLvqO4WQJJvwL+ZLAw7E16iiTp6Ag3aghCOGHKuNLpHptvF1ApPAZXmqE2YzE+ElW7WsAmaC+jD995ufnrB6lpRh5jsRK6ul+VHqo31UgB9Z/CtSKXQ2b0SNxrHw6Ar/ThVcswkJ2alYHwFgDE0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599008; c=relaxed/simple;
	bh=nL89xJv4+kdjrB3WaK3wztbdCbiHnpzCqNr+q+kHHm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KipVa//Hd9ndAp7T77MN2wDT05NP0lZalGmNxwHlH8eCbaapD5bY60p7qmy77r/okYz1dgUscJog0qNf/Co0lZgB/LZOU+mVlOnKh8hO42OoPzsghbJbvRd/8Pc78IILiwUbM1mfiCcDZzhwG/8PTOwEfqdiOEVRRfexyItGajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ/npHv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E7C4CEE2;
	Mon,  3 Feb 2025 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738599008;
	bh=nL89xJv4+kdjrB3WaK3wztbdCbiHnpzCqNr+q+kHHm4=;
	h=Subject:From:Date:To:From;
	b=gQ/npHv33U05SYAY8I5CKlcJB79NY3w5yhv8FyyysslLGDoqVMEUYlXgn7ZDVSRIU
	 oFx72QIC2eKfKQeOXmhPLFpPC1MmTAvTFtnHKqbrqp4GL+6S1fLcFxwr7P+IHxx7Ro
	 fTpg6amLVSHGCjicoRXpiaNVNhhNQCTMsMXCYlbC4nT9IwQOjBoA7DN9mqcAR5bkOj
	 dKJdqkJWfH6oOTIHyewC1OUE1pAz7pCuss5YDeOL2xdYYSNEzXSLXWuCkSxLaJtedP
	 dcSo24273s5W1Vply0KmVQfPSR8LspfWDTNk9e2sc+xmdy42iPRfd2J0kXkGyimj8f
	 fu51REeiYXlcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38615380AA67;
	Mon,  3 Feb 2025 16:10:36 +0000 (UTC)
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
 <173859903470.3335326.10806204768119360178.git-patchwork-summary@kernel.org>
Date: Mon, 03 Feb 2025 16:10:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: zynqmp-gqspi: Clean up the driver a bit
  Submitter: Sean Anderson <sean.anderson@linux.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=926257
  Lore link: https://lore.kernel.org/r/20250116224130.2684544-1-sean.anderson@linux.dev
    Patches: [1/5] spi: zynqmp-gqspi: Reformat long line
             [2/5] spi: zynqmp-gqspi: Add some more debug prints
             [3/5] spi: zynqmp-gqspi: Add helpers for enabling/disabling DMA
             [4/5] spi: zynqmp-gqspi: Clean up fillgenfifo
             [5/5] spi: zynqmp-gqspi: Always acknowledge interrupts


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



