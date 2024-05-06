Return-Path: <linux-spi+bounces-2754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2498BD0D6
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49390283355
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDABB13CFA5;
	Mon,  6 May 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO8U9u07"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2013CF86
	for <linux-spi@vger.kernel.org>; Mon,  6 May 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007392; cv=none; b=DyqwXMb/uhCrz2DpMrrs/3mrgNr3oQDBMwrDvFURFt6UBadi65MPnbzMZm49g0WEhc4yGu35asnkI9KuU+3mWO4iJvsBUnhWnbM+XkFujGGRPWI1ij1n2JKjkU3h9eoJPM/XqjWmUn7YwucyF44b6wZHGhO/Ne0slZWRZi0A3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007392; c=relaxed/simple;
	bh=YYR01L8nDfFGbmao7NEdKMSSMMzdGNLp81JRwzk5luE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=U02BXrTCGOvAyUT+tCuYa9Z3KNbxQigxquK05ZMjbgDwzfQm6m0M3gYHklA+rkt5gkLofAMmCRzYhmHyPLrNOvTsm3IOQufcaszUM+hH3uZ2LYL1htKApbXrjEPTSf9jsxhN5FK15obp2UcNjdXmi5xEiC1e0kYA2WDQ3vJHJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO8U9u07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 991DFC116B1;
	Mon,  6 May 2024 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007391;
	bh=YYR01L8nDfFGbmao7NEdKMSSMMzdGNLp81JRwzk5luE=;
	h=Subject:From:Date:To:From;
	b=EO8U9u07ncjvshLChw8x2ANu83gUYWoVXpqK4cv5hhvVEzh9aHBOda/M6WC4++P0r
	 uSGHekqNPvjtbvVYjiguvhuvT4XN1AFPb7n+/t90pclIRbxrgxpqBpNvSoS/YurvQY
	 YctQC2ie9lTnqLR7XN/CZm65XFEWDW/F++2EQJDN9mXXZgpAJKIY8ZZI7WdNG8C4XI
	 D0D/ElJk8FKBlyNoNnGe4qaBFbU2gIg5vsqWxF3UftR7nQZQplrZWVArNGTQ3eWHD0
	 83b4wTydbnUu/tMVt/opS0fTtR/u+rZwdRFWe4xX1hpf2ZP6Lee9j+aOoPDDG2oOgw
	 bno5HjmaOFDMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87993C43334;
	Mon,  6 May 2024 14:56:31 +0000 (UTC)
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
 <171500739154.1863.17864586866046219181.git-patchwork-housekeeping@kernel.org>
Date: Mon, 06 May 2024 14:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: omap2-mcspi: Ensure that CS is correctly asserted when switching from MULTI mode to SINGLE mode (2024-05-06T14:27:59)
  Superseding: [v1] spi: omap2-mcspi: Ensure that CS is correctly asserted when switching from MULTI mode to SINGLE mode (2024-04-09T17:25:33):
    spi: omap2-mcspi: Ensure that CS is correctly asserted when switching from MULTI mode to SINGLE mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


