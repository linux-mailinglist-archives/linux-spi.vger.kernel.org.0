Return-Path: <linux-spi+bounces-10665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21926BDE054
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D083848069B
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C9F31D723;
	Wed, 15 Oct 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTDPnkkA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3031D375
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524281; cv=none; b=hkCjhtOSnD2lnhNFeYEvCv3eL0HXG1ZKcyYJnbY5wEfcFFD6kR5pMV8L7jvhQGJa8j65kq8Zrn1fPgel1MzX1ofX/IGT2554w/DPVq0kNnUQoyldnIgAmN/ZXNEFmxCLIaTiZorzjO5P7MKaAOTZjsRY0b4YzNfzZcQm0FcbErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524281; c=relaxed/simple;
	bh=2nI1qIF7Qn+GRr7CLTQPC8RaejahLQiqXYKcqOsmVyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TB3x/tqmERWqNA1AKR68vurLY8L9hZd/HZQ3sY6EtKnVS+xIrK3BeInjgEagcxfTV5vjC9reHQwvnXHdEVOKkB6JPWJ3priTYJYd28wsoYzKbycmdP1UK0TTUH7e0v8SiB6mXq5XRy6lTzwJcU7DT3DVFxNWwZaSvFDwJ2bD4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTDPnkkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26217C4CEFE;
	Wed, 15 Oct 2025 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760524281;
	bh=2nI1qIF7Qn+GRr7CLTQPC8RaejahLQiqXYKcqOsmVyY=;
	h=Subject:From:Date:To:From;
	b=aTDPnkkAVMBUbgQPTo1/rXfBr9VGN3W6lQBAT11wxE8skAwKKzIPSzQAsxjEjkOhf
	 bsqfnl030OzIcqsrpf7Mk/rwYHGY0MRr5lEtRX2Vwqk64IFpv8hXnz5RUdeh88OKoH
	 mQh27OU2Oi0uSYhcAQQpnzJqQThU84VMl2X1pc2zoUhiJUkK5cih+dwbRXWw+hTryy
	 BY+R/175+b26VJVBdcr61+B9SacWvxan7yjN41aMUCd3vEu38SRKihrsAaAZlnixdN
	 odttTaCLHmWDtMOjNOnCO4fEzkdj1aVxKuurb0k7WbQesocHRD5/BgKfMxedWeUgtc
	 82T/JskwJYkng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B461380CFDE;
	Wed, 15 Oct 2025 10:31:07 +0000 (UTC)
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
 <176052426605.282100.6120153564252385206.git-patchwork-summary@kernel.org>
Date: Wed, 15 Oct 2025 10:31:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms
  Submitter: Md Sadre Alam <quic_mdalam@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1011229
  Lore link: https://lore.kernel.org/r/20251014110534.480518-1-quic_mdalam@quicinc.com
    Patches: [v3,1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
             [v3,2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



