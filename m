Return-Path: <linux-spi+bounces-326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBA817AA7
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 20:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05A8B232F3
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F453BF;
	Mon, 18 Dec 2023 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDlVYKZi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176C72042
	for <linux-spi@vger.kernel.org>; Mon, 18 Dec 2023 19:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 243D7C433C8;
	Mon, 18 Dec 2023 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702926627;
	bh=2kiW5elEFKiqhFkf6pqpfK+7gAFqfPZ05PSkFzc2hRs=;
	h=Subject:From:Date:To:From;
	b=jDlVYKZi7g6cdzhZvsB/mnXUrxIojXsljsRJA8sBGZb4q/T/hVHOMczwhdaRJbY5f
	 3hO23BdSL1f1bhLIrdYK8i97o6z2AW3GNPNYdfcFyh5OsBnd0PQaSTInJS6qlLyZC+
	 XKxZWcbXKJ1sJAi/k/hhszncoWtG3lnG82b6xvOBb4/wanXXm0YJgl8yJ4++XRSe9V
	 UM0V3ykJqNWhCb+EMxJj0gO4PV9ltUn+RVaZnj21G1f+Y/YYYCpFt4CzUnMrrkOLv6
	 fif59Y3xvQFb85HyDAsq5vJcxo4YrakswzgScWWJB108NzXuGri8akuvtMWxy6OR8b
	 f7SkEKVrvyr/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BB55D8C98B;
	Mon, 18 Dec 2023 19:10:27 +0000 (UTC)
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
 <170292662698.22785.2186636680721736447.git-patchwork-summary@kernel.org>
Date: Mon, 18 Dec 2023 19:10:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: axi-spi-engine: fix struct member doc warnings
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=811073
  Lore link: https://lore.kernel.org/r/20231218145348.339470-1-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



