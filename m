Return-Path: <linux-spi+bounces-2446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980CE8ADD21
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 07:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1442FB22237
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 05:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C14208A5;
	Tue, 23 Apr 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwfLDPHY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095D208A0
	for <linux-spi@vger.kernel.org>; Tue, 23 Apr 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713850229; cv=none; b=UdRRCt6me9Crr0v02N737chi3LBMSZRz+lIPesiaxQWAY/6p6OMhRHQ7chOHF/xFoTJ2yw7a9AatTfJtaAypA42Fwaj43YqFJO1qYpXX0afH8QavzLsLdnmLzg3aG2VxXHGRpZ50uVIM5lxVcfjG2ymeN0b4soIr4qD/2lx+A1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713850229; c=relaxed/simple;
	bh=h8ddC87agCfaoJYPzEkoq8Go/oLE6EihSqfqlGOqZ/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fOlsrHjZ6gd+zV8yKN20t/KS2a9c5h1Nx/kL8agYkN5S4VdrxUeFe29J5cZNxv43VmCywy9R2l02EfEAribBFlmBgox3munaYWnWz/tIs0A7kg5NmUptQzOLLueWj8Otk+6yvbOhY+vWZqK4yERXuHKsKk255PVGH/fL4ROhEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwfLDPHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA43EC116B1;
	Tue, 23 Apr 2024 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713850228;
	bh=h8ddC87agCfaoJYPzEkoq8Go/oLE6EihSqfqlGOqZ/E=;
	h=Subject:From:Date:To:From;
	b=KwfLDPHY4y9CgnAonsOq9vHtCAqF/1159j8v9I9PZj1c+v4QJ/N5l82yvFrKt7N5Y
	 CVVxkUB5qXzMHwD1S7Rd9ffzqmiGJtlM8f1ZBTON6v6+Y09kREE198Kz6F07XKZFjI
	 uPnsiTSSIstvKIuJIWM4bwnFO90ZTf81oBhoYcpbXtmnRnAi+Kou0FO+In6RS3OKGn
	 BG6qGgDrD7RUk1MjPDf8ufBe0n/xI5jTr8ZZ50NSQWOCdoXkX3m9W9aTeprd3rbP40
	 Xd60U59CzrjYXlvNgjid35yF429JrSDjBVufHL4lOR5G9ubiQwMyUCXE710M8aknxj
	 mRxtWfkq8nNdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95F94C4339F;
	Tue, 23 Apr 2024 05:30:28 +0000 (UTC)
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
 <171385022855.13368.13776610370648749895.git-patchwork-summary@kernel.org>
Date: Tue, 23 Apr 2024 05:30:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mux: Fix master controller settings after mux select
  Submitter: Heikki Keranen <heikki.keranen@bittium.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=846647
  Lore link: https://lore.kernel.org/r/20240422114150.84426-1-heikki.keranen@bittium.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



