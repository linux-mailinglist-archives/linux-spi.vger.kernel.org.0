Return-Path: <linux-spi+bounces-905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5F840AA5
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jan 2024 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46276B20D60
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jan 2024 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F35D747;
	Mon, 29 Jan 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAmA97LA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05B154BEE
	for <linux-spi@vger.kernel.org>; Mon, 29 Jan 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543786; cv=none; b=vC7xuN7cTv8u43Otj7WzOAOF1xT0UHKN/MN5WZGr3nHqwQToc+SdMgA10FR23fRQzfVXNU11jHTCSH4z14/X/d/sPyxyTWj7BY/QXG9YYAO4xXQPb/LggrK0csWVV1wSEk/xVPCi8KkvvKtuU8uHzQKOrP5vKMvHcuzO1uH2PAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543786; c=relaxed/simple;
	bh=Hu11+AaocNOWnGTcH+NXzBwTn/cDXqsWCDddAnMFfjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uhVOY4d9e3Obqnw77B+IlIZkvq6v5gw2OOQsdlyZ2oboPViTsWOXGxeHSgcZ6IdhMM9C4Yfpssa8XCnwL5ubyF5V33p3OLzG/152QsxQmq+WLiYDIA65ACFOPexsayfgcOM07XQzEVvB4ozLasRppywEBgftNKPphahTRpj984s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAmA97LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13850C433F1;
	Mon, 29 Jan 2024 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706543786;
	bh=Hu11+AaocNOWnGTcH+NXzBwTn/cDXqsWCDddAnMFfjk=;
	h=Subject:From:Date:To:From;
	b=gAmA97LAZw54dE3F+jXHh3hWswKvaIcU6988UOkbxKPfx/MfyFKAX6jgkdxn0jfP3
	 BEvDyPH+8DfeYeIqSfIwYWNAO2Mwd04/cfkpBo5ljHFL3Dkmkz1u109zrPXGoKOElp
	 jjHIA/uUjYTBWCCPmXdtGCXXfBsF2cQUMvLdhm4vZ96nhqK3+oK4wxQsknGBLNnZ4c
	 gbOBuAE86Hs1VqfSU8a0tuir2TvijEa6005H4Z6wX0plRJ/FXGkZO360hRWu4TDyWS
	 qmaVXOAqQZwMrxB4F1PkwavEoQ7jVJj98k1fWHLDTN5IuysdIoC7MpowOWIRgodeu1
	 hm2ypy8sIU7VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E481EC43153;
	Mon, 29 Jan 2024 15:56:25 +0000 (UTC)
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
 <170654378585.19862.18067086862094771002.git-patchwork-housekeeping@kernel.org>
Date: Mon, 29 Jan 2024 15:56:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: cs42l43: Tidy up header includes (2024-01-29T15:25:52)
  Superseding: [v3] spi: cs42l43: Tidy up header includes (2024-01-25T10:25:50):
    [v3,1/6] spi: cs42l43: Tidy up header includes
    [v3,2/6] mfd: cs42l43: Tidy up header includes
    [v3,3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
    [v3,4/6] mfd: cs42l43: Add time postfixes on defines
    [v3,5/6] mfd: cs42l43: Add some missing dev_err_probe()s
    [v3,6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


