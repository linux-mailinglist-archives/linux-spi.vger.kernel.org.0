Return-Path: <linux-spi+bounces-152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C3805916
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B71C20D27
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D55F1F4;
	Tue,  5 Dec 2023 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/p8Wy6R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652535F1EE
	for <linux-spi@vger.kernel.org>; Tue,  5 Dec 2023 15:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC48AC433C7;
	Tue,  5 Dec 2023 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701791427;
	bh=T1RhjMKqXC1NsCAInbVCdnCfqvldvEnVxUK/2ZE943U=;
	h=Subject:From:Date:To:From;
	b=Z/p8Wy6RFElrTihdAHUYbd9ubcfmxS95kX0yu2WV5rAkE2VBpN/sM3YviCvoKS73F
	 Wq2y2o3eVJe0FdFzOiFC40Hnv8WkoayaOAgomq/YoGhb6SgVaRkFlMtA42sSlV4qHT
	 aTZEaMAxxhAvA0QD4dY9KKRYS68RRTyS3W1YWqg4e9CbyAEhxs5GuoEAAP8jejIzmO
	 e8dMbc8pjSbyKSRjNsxTttwRYO5Yw3TJ/gTQPhjakt8nhkHRSwllMBEpcGYoome5At
	 o64OzzSCaTq174Jz6vERnRghFNC07i1HfA0ovrQesaVYIqGtDMWuEqnffGaTOG6OLT
	 LWiCWZYj2DDKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8D17C41671;
	Tue,  5 Dec 2023 15:50:27 +0000 (UTC)
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
 <170179142761.9499.17716850925008749610.git-patchwork-summary@kernel.org>
Date: Tue, 05 Dec 2023 15:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atmel: Prevent spi transfers from being killed
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=806923
  Lore link: https://lore.kernel.org/r/20231205083102.16946-1-miquel.raynal@bootlin.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



