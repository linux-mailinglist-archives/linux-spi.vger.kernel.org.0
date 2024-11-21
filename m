Return-Path: <linux-spi+bounces-5797-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F30E9D4FF0
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2024 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 040B5B297D6
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94B14F9E2;
	Thu, 21 Nov 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnN97Mqy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887614F12F
	for <linux-spi@vger.kernel.org>; Thu, 21 Nov 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203619; cv=none; b=jAb9YeznHeP5jV1aR80arTstCO3mMEaN+YCXDW2TI6hQlxADttqIUYqgm6cHLhlwa1rqyWxxwEOOOWJPBE85YPcG4PHtBMoHniTBp0tZSdDf75Wslb0QnJ+E6Y+9Bv7QtSpT0eZwliUtHxOH8AcBR1CSP9sWTpJf/m3tYIqt3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203619; c=relaxed/simple;
	bh=m/IpAHgFTcU6rX6EYB72XPoEBlqQ31urAhWbf1N94y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZgDAHmxPP4vIZ6LlcsmWYuvFPDQygYH1Jgoynw47loPj6uN/PLZ0+juySQwZFDNP82cv8svtX4iJPh4FT8VPixOEXIDMRQEd2Ekn99EBU6noLZiFSjLDAdlKSmUxfy2o1ksCQsEMv/BOQXJPTyk0DyyQq3OJqytTsp19F7CUhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnN97Mqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB73C4CECC;
	Thu, 21 Nov 2024 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732203619;
	bh=m/IpAHgFTcU6rX6EYB72XPoEBlqQ31urAhWbf1N94y0=;
	h=Subject:From:Date:To:From;
	b=FnN97MqyvJWoItGr5wkxeZY3Vzz5pfCi5Onfwo2Z32sFbr43wWj2kT0IKSb13hu/f
	 Oy6TK10RJ2ip54eoho2RJ3+7e3BsgcU2iDYgBLA5pJvFYi1Lrtq/hQ8ZV8oCCzFKI/
	 sNIMXq0XyM0OIggEh3MRRlLJVJs6Qi9Cg9PornyPi+qH0IUU8kzmkXqRFrdG7CMoag
	 U72Yutr03nV7CpwE+NgkGH2MgwpWiTflBSt5pVtvu1EEWzRYl2xX+frxzUuuuPjJqD
	 7ZRmTv3MU0r0OZjir1ak9Vdbdc/MMNXWMqNPl1du2TajBjSwfKntRV8yAPxCspZiDJ
	 /9MhGnwXtNgzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 392793809A00;
	Thu, 21 Nov 2024 15:40:32 +0000 (UTC)
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
 <173220363067.1964272.6908200672236211828.git-patchwork-summary@kernel.org>
Date: Thu, 21 Nov 2024 15:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi-imx: prevent overflow when estimating transfer time
  Submitter: Antonio Quartulli <antonio@mandelbit.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=910186
  Lore link: https://lore.kernel.org/r/20241115220202.31086-1-antonio@mandelbit.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



