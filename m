Return-Path: <linux-spi+bounces-1817-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974F87D2A7
	for <lists+linux-spi@lfdr.de>; Fri, 15 Mar 2024 18:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412FA284731
	for <lists+linux-spi@lfdr.de>; Fri, 15 Mar 2024 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BDB482D3;
	Fri, 15 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO7BDwcF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C946433
	for <linux-spi@vger.kernel.org>; Fri, 15 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523231; cv=none; b=qAffQip518hzbCuJlbWklDP/TErV9cSqPEhwYWPBvPqEL1qnRC+F4rf+x7gJjwnsEbPzdWvOkH+CAsT95hFyVilj6KhQm1Xc8rskd0t6B83MngARlv4VpNESKkk6BP8Y218MUxW6Hp71Yj+Rj50WBCFx2zXGJh6Nbwr0O29GB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523231; c=relaxed/simple;
	bh=SsJrjVU/uy41CrPCHiSIB+3ZI1ThfgdgsZSjaI+yGxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kRy4lVvkevliK/yk8tpvU1k3GsMRuVj8K0rTr6rfy3L5LGlsPdcJELqGbEEFtn/6ujcxnznm422mxZfnKwKwVHaC1lLt7LwDQa04HcblId+n6F+bPige8r/ib1+wCMZVhfglbqDCrkh6oxjQw3Y4b3rmfkLJWJAPLPeutKEL+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO7BDwcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7B4AC433C7;
	Fri, 15 Mar 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523231;
	bh=SsJrjVU/uy41CrPCHiSIB+3ZI1ThfgdgsZSjaI+yGxs=;
	h=Subject:From:Date:To:From;
	b=vO7BDwcFYZRi5G7F0cOk59K6IYwvb6ZaGY5vBAmFQXbsA8pTtNSVgl8b7m7Od8V4E
	 5RPh6ceG/YFRWaA/ZLJtc38AUsfYvigz77sznsozvQu9r+8XVmr+pYRxfg3bhT7CEI
	 uIc4kN4bev974KwYloHwqLooz/haCw5PhzQIYXua51VGPyu9zI6/g7fHss5xKP+vb4
	 DvSmin0qzSiWkny5EcKi5T82DT96eeOr9qLc6pRIk6hpDsoMhpiA5P9MzkwChE7IvE
	 B7HhfcU2sk1F+juAhzGwcLXDY1/9upn/VV3tGTmnxVwSBsCIOQUubarz9rPBlbAfmM
	 sNSr1CXyhtDHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 905C4D95060;
	Fri, 15 Mar 2024 17:20:31 +0000 (UTC)
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
 <171052323158.31679.3547169234305530077.git-patchwork-summary@kernel.org>
Date: Fri, 15 Mar 2024 17:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: Fix error code checking in spi_mem_exec_op()
  Submitter: Florian Fainelli <florian.fainelli@broadcom.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=835085
  Lore link: https://lore.kernel.org/r/20240313194530.3150446-1-florian.fainelli@broadcom.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



