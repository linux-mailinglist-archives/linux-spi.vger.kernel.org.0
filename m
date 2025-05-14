Return-Path: <linux-spi+bounces-8117-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E807AB6EA0
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA57F1BA001C
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A731A4F2F;
	Wed, 14 May 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5mcIhSy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804381624EA
	for <linux-spi@vger.kernel.org>; Wed, 14 May 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234631; cv=none; b=jQYsIPw/9l0wcKmnZRxPXG8M4CRxrlhYgm+Xy7ZWBPK3D4TulfEezeC3lP5i5feG3kwsJ2/BkLAaQauudukeFidHvTXJcxwqs2jqN2CfdnSh+NSIykkJBvFJjFC4Ge2f+44I2wak7xxK+/KFA1yB+ZCUZMnDo1rhfgkmKkGmi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234631; c=relaxed/simple;
	bh=1+SDrO5u+PLv3Ck57Zy4eu8GpS58DBF3ZkMbGXDEClg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dREg9pg8X34s0YteZAdn75NMurWm3vWbUZWnLaxGfHX0kXnqZz1kDjC64Ba3236hnYt8IovpNDS6QAPm7SnyoybGKxMN1QUeHqahisR14CR+uN0LiSaVu9JXPOo2oBNiQJln90rw0KJswwU2RUWfz7y7Ebfi4EZt6ZJ7DTL/2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5mcIhSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39C3C4CEE3;
	Wed, 14 May 2025 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234630;
	bh=1+SDrO5u+PLv3Ck57Zy4eu8GpS58DBF3ZkMbGXDEClg=;
	h=Subject:From:Date:To:From;
	b=o5mcIhSyLq8m47FNuVILFLEvqP+9A4yvJ51r2eIT5Vg85zS6LqEfmZMox95BSeTY+
	 KWWTwHuaJk5/HZfVW+Djg2lJ8ycf0Tkri2IMABxWxqRT/puPUtJlLkyrCPYfHoNO6Y
	 2dAQOrm6MuP01t2SW/taQdcmBPxsfDh2FctDJN44F2D6MJlet5XvB47oeAAQk5Feyx
	 jOiNzunNZgAjt9mpv2YK28wcrGqwHheqpk9HQWIaCmYzS4zaK9zwqH1KdfR3wkM7mN
	 MUFu0/2/aA/YBF2y1MTSdzGgKongz7YTD00AVEE2oMs1hmTRp5PwErXAzEDP9LLcs+
	 D/e2OY6Z728ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D83380AA66;
	Wed, 14 May 2025 14:57:49 +0000 (UTC)
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
 <174723466793.2395908.18073327626211361407.git-patchwork-housekeeping@kernel.org>
Date: Wed, 14 May 2025 14:57:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: stm32-ospi: Make usage of reset_control_acquire/release() API (2025-05-14T13:56:01)
  Superseding: [v4] spi: stm32-ospi: Make usage of reset_control_acquire/release() API (2025-05-12T07:01:04):
    [v4] spi: stm32-ospi: Make usage of reset_control_acquire/release() API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


