Return-Path: <linux-spi+bounces-3771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB5928DEE
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 21:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692BC1F21FA7
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1A12FF96;
	Fri,  5 Jul 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao9fP2Vm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FD81E
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209033; cv=none; b=H16y2t9Yl/AGuZC+L3KpZrqgBLOfsKXS6mAQUnZ8CXlxIvl4Mgm3fw/c/U2ymZhOFbW62PzZZyI5kgLc9oEF2aUNd2A/JEEIW/jxpi4Rrq+dhhvxX5cUlXRJ5d8Irjh+EFHo8dtmfCvJpnL8jsbcbtSwGLqnSqWjVC92n5xb6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209033; c=relaxed/simple;
	bh=5ZL4hR4E546yANjl6LDKbgwNJ4ootmiQlqfvFh99D7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=U4mjzHRm+5OhwUKDsutU0dYk4FN3BBejnfOeaAatEoHIkgTV84ic6j+JrF23gYiytN7VQndHUSuKpe5cFJovjk9WxipDIcQa0jtK07NTEZ6ytLpvy5tnhiDUdHBm6ptqcUnpUPB/INkOGZcvzCv9KC/Zc7KHbJBkSIuIBBZFRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao9fP2Vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E686C116B1;
	Fri,  5 Jul 2024 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720209033;
	bh=5ZL4hR4E546yANjl6LDKbgwNJ4ootmiQlqfvFh99D7Q=;
	h=Subject:From:Date:To:From;
	b=ao9fP2Vmv9teIr4Dyo8nejqJ7mHRdY4QrPyAGg9qAOkoFa9ds4RBG/nq2/g9qMgjm
	 xG4Y8JJB56A8Ud58UZZKC5x3r6oYOFS3nVXZPkKC50EuCQgF+3Yk53FFVmWR2m87xi
	 pfkULMb2Bk9UlUru2T2bkRWKfJ/v6jezOT5i6ySIHuDVDvfMosSh4I7+9NWk9C9mST
	 psWvVgJRA3yIlFxE5Hz+W2/Vpe52Z07oFrO4in2WtFphWjLBLgr6hZBe7JiNhmr/yd
	 /0SD9nm/ZekSv4RIQ2BvE+7ORs2mYcJNWPv9sXoty+bRWL/udMPJ/swOXxq23RixvW
	 MYa9qUrsjFiKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 211E7C433A2;
	Fri,  5 Jul 2024 19:50:33 +0000 (UTC)
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
 <172020903306.16903.164642534091258005.git-patchwork-summary@kernel.org>
Date: Fri, 05 Jul 2024 19:50:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: xcomm: support GPO pin
  Submitter: Nuno Sa <nuno.sa@analog.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=868463
  Lore link: https://lore.kernel.org/r/20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com
    Patches: [1/4] spi: xcomm: add gpiochip support
             [2/4] spi: xcomm: make use of devm_spi_alloc_host()
             [3/4] spi: xcomm: remove i2c_set_clientdata()

Series: spi: xcomm: support GPO pin
  Submitter: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=868859
  Lore link: https://lore.kernel.org/r/20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com
    Patches: [v2,1/4] spi: xcomm: add gpiochip support
             [v2,2/4] spi: xcomm: make use of devm_spi_alloc_host()
             [v2,3/4] spi: xcomm: remove i2c_set_clientdata()
             [v2,4/4] spi: xcomm: fix coding style


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



