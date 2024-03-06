Return-Path: <linux-spi+bounces-1658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98C874250
	for <lists+linux-spi@lfdr.de>; Wed,  6 Mar 2024 23:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF39D286A54
	for <lists+linux-spi@lfdr.de>; Wed,  6 Mar 2024 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B771B80C;
	Wed,  6 Mar 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxAZ+QEY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913D1C290
	for <linux-spi@vger.kernel.org>; Wed,  6 Mar 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762430; cv=none; b=MWzxHJcBUPazU+qpwp2uYWyjrYmLnDkxvl5c0eFIn5apmeYFgwwSjKSDmwHkEH+d05mrOJrV+ERmeFV1nsbY29negLkcgdLR2/jMYCcwsMnKwZb3AichHs7ex54bwSq9JzAwynmJo9nDtaTl/f19mOlvEtUzEr7nJ6uRqeJB3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762430; c=relaxed/simple;
	bh=jnkYapiR2lpiCFJQgCpJv/+TPA83Z2dKolKtazwQAJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jet9FJo9PdNZxPWO0vo4fhqxFJf1n4NfFsoaEQXB5pgD3lpu6gePXd9L6T2/9q6nnc1a+G/Lhjq6RggGvkgi+gpgNp2Nh1OS7iRVrOulfTgNu1tQRdyjbjjhc3W1BGInm+nUwWU4RoR82hfzpWSTS+kgbJgJALaPsZd6fYENhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxAZ+QEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E34BC433F1;
	Wed,  6 Mar 2024 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709762430;
	bh=jnkYapiR2lpiCFJQgCpJv/+TPA83Z2dKolKtazwQAJ8=;
	h=Subject:From:Date:To:From;
	b=pxAZ+QEYbr4ZDih8sdl7ifXJdpA27vvln7D8mvMLDYMOw36MD9di4TjNNYVHG1mIT
	 k0s8pPx0+T5BnO8mvGumaVZRaBGoRvjzhlnomn8/wVG07kqRWqQ8Amx/V9R6HZB4u1
	 NZKLL12BTDoVjKHwt2nEvDIqoJLgLEXpak4mK5Cz3Sh9O0ee0Hgj9WbQyR3JeQ8Va7
	 XiB1bE7b65wGL4hZZfz3NkKt+aw+QIppE6nmVey46Rx8vwjcCn8K7ug49G1T7x6yjL
	 ljxhWrseDrpM61v7inF43+Q3XSAPj/TDcBvpQGmhqzEK/02TqMcS+sDWwLnLL4iCvH
	 emfWVNUxDDS/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2909ED9A4B6;
	Wed,  6 Mar 2024 22:00:30 +0000 (UTC)
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
 <170976243007.17043.17929623814328149724.git-patchwork-summary@kernel.org>
Date: Wed, 06 Mar 2024 22:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: CS code, variables and comments clarification
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=833046
  Lore link: https://lore.kernel.org/r/20240306160114.3471398-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/3] spi: Exctract spi_set_all_cs_unused() helper
             [v1,2/3] spi: Exctract spi_dev_check_cs() helper


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



