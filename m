Return-Path: <linux-spi+bounces-49-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F67FA6DD
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E887E2811D4
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB136B08;
	Mon, 27 Nov 2023 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz7lxK8N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370034195
	for <linux-spi@vger.kernel.org>; Mon, 27 Nov 2023 16:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27058C433C8;
	Mon, 27 Nov 2023 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701103825;
	bh=unc4ox53/lPFRSOfYQWRGs1s3Cbb99aHmoakeHfCKOs=;
	h=Subject:From:Date:To:From;
	b=Pz7lxK8NaXrQs8DTU/wCJOc/r5kPNdzirpH2WeoCbuXwjlMuGATEGP2ADTfhIRtSX
	 84cFy5vFPnZZGnQRAdiY5IssHH2+QkG0Rif/rBSC5UNW4QtctQOLi09cs17cS1oXe2
	 mNvPCA8df/+if8Nb2EFvsXwdRqSChl6BRquiuk3OdiBy0yebhDyuN9E92VEs1F9q00
	 n1oSDklkYEI4AF6KRpQlRY2CrsdoTo/fniw6DLe30QlKt1QP7QyBpviNcA9m1WRCbC
	 QYArbZb2luFNSJ9BRU3Qxu9jOA6x+xPTLjKwwFRMBfHtaMFUrjcsJWb7EQgE962r9Q
	 wA/tAj6TjKNUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFFA8C395DC;
	Mon, 27 Nov 2023 16:50:24 +0000 (UTC)
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
 <170110382491.5663.13763719160599690471.git-patchwork-summary@kernel.org>
Date: Mon, 27 Nov 2023 16:50:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Deprecate register_restart_handler()
  Submitter: Andrew Davis <afd@ti.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=801994
  Lore link: https://lore.kernel.org/r/20231117161006.87734-1-afd@ti.com
    Patches: [RFC,1/5] kernel/reboot: Deprecate register_restart_handler()
             [RFC,4/5] spi: sprd: adi: Use devm_register_restart_handler()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



