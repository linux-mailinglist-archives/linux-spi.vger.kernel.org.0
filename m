Return-Path: <linux-spi+bounces-3367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2765902AE7
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 23:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56991C20A61
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E98004A;
	Mon, 10 Jun 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd6QNqcm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D8757F3
	for <linux-spi@vger.kernel.org>; Mon, 10 Jun 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056230; cv=none; b=lCbwpu0x49d04OAa1v5pKyny+6x7hmi6ZXo3ACAVC61Y/UTnpy1oF7rGloHN6rNPzedrAEcutmob9yzJnW1cPyAfP6fg6fgFGI7ACWgfdNyh3rI6Ar+QP8vii5iIyjF+WruMqNJkJokmWw7325lUXp/5LuaH3KLldaW7cr9AclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056230; c=relaxed/simple;
	bh=4y2Nr0dvvVQVq+v+YKLgdYsEBFvcNyfBBYlZUmA88vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pLFG6yYXbcJ0nHq4ucsLIBK/JNrwXm/M7OMCMQrp5e8bQtki2pz0VJfQbLoKhE0+/0d0e/h3KhU98OU6Xg4Qah1a30a6Oym10Kt24VlHi29uS2InHIhHVBVXrfHzEUWu28vprla1cGtiSsQKZkEk+gYZfVaQZXY3fKJVjm8PFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd6QNqcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3793C2BBFC;
	Mon, 10 Jun 2024 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056230;
	bh=4y2Nr0dvvVQVq+v+YKLgdYsEBFvcNyfBBYlZUmA88vo=;
	h=Subject:From:Date:To:From;
	b=cd6QNqcmaOVVyD09+ikjnS90CPA/dyI5ysHyD/+I8Is4sJCYmRtfN79/ow7moJO3D
	 V0PWxTQka0F9EY3GwoA0SPc+1HcuJbxqq1S2UIXfPLg3RmpWgz0ic5LdjwTt7D5DDz
	 zjYYfwxbSBj/0AsOs/cW1wFU8QBEqLoZme9yYp0ESafXWlsCJt8llruPO7oVACddFS
	 q2YsphFwOfXMFZwh0K1d8G5AJ02intyLizAOu9f03uQO4sdekL2KAsnWRKr2t+TfZr
	 ByW2VA5Jekg4Y1LFX1FWmRA7ig+zsZlf6LlwVpupK5XtysrVtX7iCzozsQYdE9tvDw
	 iviOlTGZzNs7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB60AC54BB3;
	Mon, 10 Jun 2024 21:50:29 +0000 (UTC)
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
 <171805622984.25570.11330366439477839268.git-patchwork-summary@kernel.org>
Date: Mon, 10 Jun 2024 21:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: meson-spicc: set SPI clock flag CLK_SET_RATE_PARENT
  Submitter: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=855588
  Lore link: https://lore.kernel.org/r/20240524-spi_pclk_setparent-v1-1-99e0ce70b66f@amlogic.com

Patch: spi: add missing MODULE_DESCRIPTION() macros
  Submitter: Jeff Johnson <quic_jjohnson@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=860292
  Lore link: https://lore.kernel.org/r/20240609-md-drivers-spi-v1-1-1c7444f53cde@quicinc.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



