Return-Path: <linux-spi+bounces-3736-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C6926780
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DD51F22AD1
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64C17F511;
	Wed,  3 Jul 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnU/RrQO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A91C68D
	for <linux-spi@vger.kernel.org>; Wed,  3 Jul 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029395; cv=none; b=E2Q14mdCByF8VSPiLL4dlExkwhYVHz3BDY5v/u9BBVkorf/waldNU1IqzBowclOR9vvHE16pyJGUet+aTyB5FrYN/9sPZ9EMoUVEFoaInzXF9DMUsx32xAQfBab5xE9rtLygPGmkZouao2WmoVNINYYC7D+shmlhLmhGsBgJqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029395; c=relaxed/simple;
	bh=gvRAd3KBR+Hoi5mGlfFPRBenJo2tWukR3Jkg21Rneik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h5rljiWagV2rU2CM6T7LR+0HSFqIaleYCyWUhh8QEF7wdiWN4Hy9J1rtrZqdtvHBa5EDVZNb3VPP+txTct3dsIo5HAVGbey3M9uwD0k7rWUtB15qW1pLJlDNefdLNsGRR8TIJfAO0nVFfdW9ve6qFoVr6fk0BK54/TRTrHDEe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnU/RrQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB8EFC2BD10;
	Wed,  3 Jul 2024 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720029394;
	bh=gvRAd3KBR+Hoi5mGlfFPRBenJo2tWukR3Jkg21Rneik=;
	h=Subject:From:Date:To:From;
	b=nnU/RrQOfk+jJEkkOTd3O2Ei3pajv0JDns8feNWRCNb94gJwCFeeb0m7NeBttXYdJ
	 lSr2lTMQeAgs+47afbo+61PKsnx9As9oAPUG3LiAfhWkWqV+LQsWJBALKPx3IMAIz1
	 WTjV+WTEHFbwTa9ud3Mu8kP/Sku5a0x6ujI96azI7Z7qSjv2NLnzww/Fuzh7G68Tam
	 2Xhk++/Fq6EoWaZrNELpM2u9Ee3GNuKnoXN0uA5ubDtbANWTX1BKYVzhS+kRbPaMyT
	 NLSP6ddbLYlRfr4M+tXtrCVkNPAblG+B5lhXv5CwKrsVZ+ofixXiiWM2kQSXFv5K0k
	 QnoGbqIEc+wow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9298CC433A2;
	Wed,  3 Jul 2024 17:56:34 +0000 (UTC)
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
 <172002939454.22795.674418561138657331.git-patchwork-housekeeping@kernel.org>
Date: Wed, 03 Jul 2024 17:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties (2024-07-03T16:59:30)
  Superseding: [v1] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties (2024-06-27T20:33:08):
    [1/1] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


