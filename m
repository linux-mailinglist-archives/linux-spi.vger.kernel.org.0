Return-Path: <linux-spi+bounces-5081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E979E98C57C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 20:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922BC1F20EF3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3B1CB321;
	Tue,  1 Oct 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmXIc0Ab"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84D1DFCB
	for <linux-spi@vger.kernel.org>; Tue,  1 Oct 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807999; cv=none; b=R0XrSeNrboMMvpvcE6GkOEysd/zDNcFiEW4+IPR2YwIn5SJJKJSijP777dLOtVAY+UsEivxVuhKl5BPA5qAOOVGn2rXK0QgUEmKIf4dXeZuZQsSKq0A2gTmqYkqdhQLoqX7LCkqK2J4TDOSihbYqyKZJ7+Uobk/ZF0UAQznqtGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807999; c=relaxed/simple;
	bh=M8XuOi5lvG2usN5UaGkDw4ikqBtz76XEXHVEoaRcqAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nsj93tIliuxHFTasc5op18u49FmEltFQxIYIeXIz9E4N/p+01N7+Hb1DwE833oaR5PAD0mycPG6S/Dcw7pCkip+9PfXSdKR7xUoCwDs+cPKJ89G8ohBDGYNshh2DIcO0pyuKryUeQ6MkXzTHLCL8qrIkv8DNez/4Cjd7GYbl+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmXIc0Ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318AFC4CEC6;
	Tue,  1 Oct 2024 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727807999;
	bh=M8XuOi5lvG2usN5UaGkDw4ikqBtz76XEXHVEoaRcqAE=;
	h=Subject:From:Date:To:From;
	b=bmXIc0AbvDZJVsVrRiNQy6sBlWrStE8lmy73E5vT57zGRyGgDdlPgledwI3J6jodt
	 5i81oS7hIjSszwVakCiTearsPYMYmXIxFW3SyA+/I2Zxo4AGkvEQ+O2BDugFKzuhvk
	 JN42A28fGFL7L4fOqfcdnl93kUiTrlwk0ZrOD5r8U/FXhmJOqsDAEyXtD9RtZdbrie
	 YYtX03Sw23aBrJ4TpIbeOxvcXKxVmg51q691Ibum1LXwZvuLVCnSnj/RoAxW7YGDIW
	 /wU7YLEl5yM+a599rIuzDOD42FVAxeCN+CZqTgZZOYTuBW7NJdblXz+Y2DlfcHFTw9
	 tVq2F+DFjS/2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74DF4380DBF7;
	Tue,  1 Oct 2024 18:40:03 +0000 (UTC)
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
 <172780800206.474912.16576863756378004838.git-patchwork-summary@kernel.org>
Date: Tue, 01 Oct 2024 18:40:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atmel-quadspi: Fix wrong register value written to MR
  Submitter: Alexander Dahl <ada@thorsis.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=893062
  Lore link: https://lore.kernel.org/r/20240926090356.105789-1-ada@thorsis.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



