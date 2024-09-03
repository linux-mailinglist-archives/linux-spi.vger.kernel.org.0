Return-Path: <linux-spi+bounces-4551-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965196A9C9
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 23:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7A12819EF
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389D1EBFE2;
	Tue,  3 Sep 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQz3GcZb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E21F947
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725397828; cv=none; b=LktixbbyS+qA3MwIGJWOuFz/qVcPeRCSnfxuhEP31W6Q3FZRardeGWiiTs9mLSS3Oheo+QrRABYjk3mXtnFKLk9H0+HIFRXa+ItPMZwnuAPEgQmTbiijYuGeg2iJLntEgscAisw3Jd953OT+2y8WZfaUuu63NBhugfA6Xqgx8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725397828; c=relaxed/simple;
	bh=GG+LaYZLRuvAD44s15GHW1/BiMNGURFnJ/dpwxL7oww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=McqeLsSUwvj4dw9wr9hfWjeeE7UdK+f9UOseC6t2WSg6LnXgyixHpCl8qejfZQjHeBGUiEME5S+xqkaLYB5++mF3AbUC7225cLhmFUO0akTCaK7BYhV6KDgy2pjacV0qxc/JuSMnMcKq1ND93Ldia8FEPGXouUTuA8VrIXUxW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQz3GcZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50E1C4CEC5;
	Tue,  3 Sep 2024 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725397828;
	bh=GG+LaYZLRuvAD44s15GHW1/BiMNGURFnJ/dpwxL7oww=;
	h=Subject:From:Date:To:From;
	b=vQz3GcZbFNKUOQJelOvtiKOdoftIDkVPzdBW/bWF9HIvoLdMcd+HMD9HgPG0fD5mR
	 DCRDAbZ9NYa7LnNgANx/z+edEDjOYwM+cDX5qTWRZbA+mWlsSxxlydYSYdwg1WaIsJ
	 lV7UYbWRXbHPeoL5K9JJMvBNbKZHk5vLRnI3iIRYX183amWQrRBjR6Pb8RWfJh1OnM
	 bLghaxVSKgjuf2DwZtHcqPwqnbO0sH2CCdZGMpPnyI0MwauEECYgZZiIW6nMYdsK8R
	 oS3eqriY6GZEp7adnUbpXijgE+7RHE+vD0ioVdbJlxAxMm2MA8UB/NWTvPZ7nJU/VQ
	 f0cSLircJOskw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 758243806651;
	Tue,  3 Sep 2024 21:10:30 +0000 (UTC)
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
 <172539782901.443928.4556493272402183150.git-patchwork-summary@kernel.org>
Date: Tue, 03 Sep 2024 21:10:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Revert "spi: Insert the missing pci_dev_put()before return"
  Submitter: Nathan Chancellor <nathan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886023
  Lore link: https://lore.kernel.org/r/20240902-spi-revert-8a0ec8c2d736-v1-1-928b829fed2b@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



