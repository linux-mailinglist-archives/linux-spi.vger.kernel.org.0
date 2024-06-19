Return-Path: <linux-spi+bounces-3486-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB8890F16A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DF21F211AE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86325569;
	Wed, 19 Jun 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMaiDw4x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E71D54A
	for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809000; cv=none; b=m9hJJ1bcfDlAp2FPAuEa1s93yOq/+pn63NtRADfK9IGHhocgp+Kh3DDI2Bu76ss3O5BCi0zcBoRNyR4kR2zI27Du5o+HNc6mwXuQJYNKrpfrQr8oiDPLeIz+hhrI3lm71WuM30kDJjzIcfBNlQEzi5aEf9qf+ofTDa48ztjZffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809000; c=relaxed/simple;
	bh=aXv/PdWjHiiTWR1ay/G60D7XfExmJ9ITcv8+yKll7Gw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OsJcnWS61NdJXRfcewa58+tqkkWLlzp5KONXNYgs5xVd2E+T0STJtpUS7a3IQgccb4sy9tNTT3z19YxCVT0AmJUExV6hbMuEX2aJN8+5ktNoPaHwuWnzX6mwo8PQ1Rc8xYKaoLGoHCVlc0/vEufU/ZVtuXB8V34jOMgYvr/R4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMaiDw4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52588C2BBFC;
	Wed, 19 Jun 2024 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718809000;
	bh=aXv/PdWjHiiTWR1ay/G60D7XfExmJ9ITcv8+yKll7Gw=;
	h=Subject:From:Date:To:From;
	b=aMaiDw4xK5OsmdUDUP4BXFsUMKR/0aY+eXVbAglm+vH/rTBYctroYWxyiesFM6Gft
	 uPDQHl/fh1ef2mCGergHsFTm1fB21Y4WQko6BZuwFHF56/j8+Xb2rIWMehGIBkQ76B
	 /YkCYmhiL/5jsNnZa3DPadL0fj1rSLxIqqnRXmyo8e3DaramAOaG4n1AHFGiHDWfIM
	 zmnbeJX+IVdr6NQwGybAzagLTkiNvSgK62f3llhaHyMvk54+LVKzEG5Q/9xV+73+eP
	 06ClZ+vBplVIfgE5ZJNqHxP018G5MRcPcMks+3sc740ZI2FihqNz9UANhJNkwNbCDZ
	 z2XOZKKeQzZQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40F06C4361B;
	Wed, 19 Jun 2024 14:56:40 +0000 (UTC)
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
 <171880900025.18890.10075128024115509930.git-patchwork-housekeeping@kernel.org>
Date: Wed, 19 Jun 2024 14:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] Marvell HW overlay support for Cadence xSPI (2024-06-19T14:17:07)
  Superseding: [v8] Marvell HW overlay support for Cadence xSPI (2024-06-07T15:18:28):
    [v8,1/4] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
    [v8,2/4] spi: cadence: Add Marvell xSPI IP overlay changes
    [v8,3/4] spi: cadence: Allow to read basic xSPI configuration from ACPI
    [v8,4/4] spi: cadence: Add MRVL overlay xfer operation support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


