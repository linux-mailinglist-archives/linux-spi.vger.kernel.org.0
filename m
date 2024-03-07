Return-Path: <linux-spi+bounces-1708-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A38757AD
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 20:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03CD0B24CD1
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A9A1332B3;
	Thu,  7 Mar 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFtcTAaC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322E1EB56
	for <linux-spi@vger.kernel.org>; Thu,  7 Mar 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841398; cv=none; b=Qtq50BjMEjXBvb5Ar8NPJgWvt/xA26RAKe2xP6FCZpG0FMiB8aR4+nL6+EZohcHlyWn72CPwiOmn00pVYD8NHZKrDhtFFACu7E7ixL4QyUbw15QrjTm1wmnmtSs0iJSHaRfvy7BgjwFSiHAqTmlloKKHLvhWTRg3pbivkeCr02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841398; c=relaxed/simple;
	bh=F+LCkibjY7tMMZO6pxaDstjhlonVy4wxwxMKBRxnppg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PhthSzo8k6m0e6nODecFdqht56Ts/sw/bmpRHx298m8TyUpUwyqy4rWHQidrOr9gxuRE5H1PasMULKJKSVMEFomdi7Ns2FrLD6Z2V5Wwsco1yXOAVln3LQ6Cdgj0aa6i/qkayVLJdLuat1b8eLn+nsO8uy5jkWM/7BNWj+PUg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFtcTAaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF295C433C7;
	Thu,  7 Mar 2024 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841398;
	bh=F+LCkibjY7tMMZO6pxaDstjhlonVy4wxwxMKBRxnppg=;
	h=Subject:From:Date:To:From;
	b=RFtcTAaCSlHtV4qoUbRjNkmxLKA9Xvr7Zy0iXu631lu2CG+xuSgR32FQERBs9HZ4r
	 LxtlQldOcuA1UtwfI/ATMfX7MEZ8Lesk4oaov4fExKUxgfinny1LpmtI5RVbNYvLsm
	 EoZImWOAbZMKunpUk9eWpBV0sD0qocO9Wpfl/eJVu4zA8enB1yh9UuHYbWjPUTaVUv
	 5kWElU6GOXOZ3SAf9BvUqTvC1imn0wm7tyoZuYl4hAUsg/ml1hZb7vcMpUTLCkNle/
	 GxRkkCkYxvz3LdWtFk7YRDcrH6dK1G+2KRqmTTqzT8L7c5L3b2G0ascgX/EVNWW2GZ
	 ITk+UHVj98jyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C76FDC04D3F;
	Thu,  7 Mar 2024 19:56:37 +0000 (UTC)
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
 <170984139781.8207.5198026320265497533.git-patchwork-housekeeping@kernel.org>
Date: Thu, 07 Mar 2024 19:56:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h (2024-03-07T19:47:46)
  Superseding: [v2] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h (2024-03-07T17:03:15):
    [v2,1/3] spi: pxa2xx: Kill pxa2xx_set_spi_info()
    [v2,2/3] spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
    [v2,3/3] spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


