Return-Path: <linux-spi+bounces-3574-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B31B91665C
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DD4B2433A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12014B091;
	Tue, 25 Jun 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6W1pRny"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC114B078
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315656; cv=none; b=gPvuzKAOa9ZhFyNO5p+aIUQvHkYdTo2jxaVSf5GNm+HtuxdERtqRNMqHBUKShQKfphjdYDnljanulFhdK4JxEkWfRH5+F5TrhhHlqMVFqyVZ/u+5VFcPvZEEY8kpvO8R8r43p8l7JDi0mEYvLZYn59TjeH/KyhxDolWHS6uhzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315656; c=relaxed/simple;
	bh=h0g9AXjMMUAXyuYZsFyHL++tRMU1HeRMLwMaHhcJjQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j2JMdQ257/1piYWYfIEU65TTXDFGegQmUxbfuLNG+pSMRZwK6G56uIEkMyM5JOkLv3j95pyxWozWHXpOsjFN3KT2lUhw67EZ/1glb1ee1Kf6wNKafy4oNfQY0UI+M8yzwO+WACvXbQSv/bTQg5VydfGW2BiIcETfmdtbj26Qf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6W1pRny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D40EC32789;
	Tue, 25 Jun 2024 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719315656;
	bh=h0g9AXjMMUAXyuYZsFyHL++tRMU1HeRMLwMaHhcJjQs=;
	h=Subject:From:Date:To:From;
	b=B6W1pRnyfi7rTPuhUNJECT5qt9q8SIqFfNCD/epyRh4GGmIUinTw/BBcx4fPI1LeX
	 vdUBOstdrgpti8/Ar4eXQp492sfSU3vDv+2y5FiFb4b+jKi9pZKf3EyBN5Lum5638A
	 0o+kqfKRORJf8NdecsEuiKb204EQ7actXXiRA8ay30+ytbsD1ziEbL5CtpRk5YsgWm
	 GNnNmRu356DobF3AV1QmcHPWlaBaI5eERKTHJGObzc462b9pee4+g3MegOleHOxjb7
	 RFwfCFubzrdo7ILx27ZHyx6BcJOI9GzsQTfaGtUv4JPz1mnPQl/tCkI0G2ZfU2dnuy
	 Y6O9Qo4Mo4auA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32D9EC43638;
	Tue, 25 Jun 2024 11:40:56 +0000 (UTC)
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
 <171931565611.19385.17164500672164528789.git-patchwork-summary@kernel.org>
Date: Tue, 25 Jun 2024 11:40:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: axi-spi-engine: fix sleep calculation
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=863935
  Lore link: https://lore.kernel.org/r/20240620-spi-axi-spi-engine-fix-sleep-time-v1-1-b20b527924a0@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



