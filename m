Return-Path: <linux-spi+bounces-4633-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9A96C577
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F8F1F25559
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F783CA0;
	Wed,  4 Sep 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPSakLkG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A145464E
	for <linux-spi@vger.kernel.org>; Wed,  4 Sep 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471034; cv=none; b=bdmQiWM4VL9D4WeWZUrKopL2s87e7iRogxSIB4cfIrRd2BWRbg9Kt9dIR4RK1IVaJz2JtyRFv6DvG1j7uHXsRyKB972NPtg1XkcWwZs47p6XqsSqFps1rwI6V0zz/t+tOm+Xt2ceYp+bAjEqLNbF9lZCXvdQwft0OqqbyGmicAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471034; c=relaxed/simple;
	bh=WCoU8k83EUjinki40JCNNiRFpLkE8kZkckub0dnXSQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qK8B8rgqyVl1f9dy7L48nr8BTxPZ+Wa4QqLutK83MYYX+CofdSM7wiHBj7rQNSVq9TTMf8G/a/x5HebkelRoVY6BIA57A+BfqQYz0oeWheyU9AX4VQ0bjY7JyNsrXlojRFe2hBP01HqNzXtKM356yYHa6Pp3eweH0Z57WM6DTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPSakLkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A130C4CEC2;
	Wed,  4 Sep 2024 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725471034;
	bh=WCoU8k83EUjinki40JCNNiRFpLkE8kZkckub0dnXSQ4=;
	h=Subject:From:Date:To:From;
	b=lPSakLkGsvHTVO2/xcSB5/c1hYbaTn3rQRs1O02fu+DM5ij2ffCR7WwI6mzo6ebJx
	 /JflXYqZGTyfR+Sap+AhOTXjObgiSm87xy+0sgUVKpb6eucryC4Hqb6mYKXjSxPlvt
	 5c6BOMkbkPk7oPzhdNKrJ2thrpMLGit0fUeXOmbwCNJ9dXt6Qi/UV3xsARmSwUgp85
	 BxRXejgFSNevdhyKsplvan73jTLheOTb8yA8DoqZ4G6sTkRPTXbeEPu8yBVVxipEkZ
	 Uq+9fwgPL/pSB9YvAg2YVun5J/wiwe55g5/8SSsXnCYpI6HCYUts3m+2xIJXnWTcR5
	 siMOMlAtvY6Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F30293822D30;
	Wed,  4 Sep 2024 17:30:35 +0000 (UTC)
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
 <172547103457.1108939.10054061726752837971.git-patchwork-summary@kernel.org>
Date: Wed, 04 Sep 2024 17:30:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spidev_fdx: Fix the wrong format specifier
  Submitter: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886678
  Lore link: https://lore.kernel.org/r/20240904073550.103618-1-zhangjiao2@cmss.chinamobile.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



