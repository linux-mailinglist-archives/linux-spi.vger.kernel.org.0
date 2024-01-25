Return-Path: <linux-spi+bounces-805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB45583CB20
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADAF1C22B33
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542F111AA;
	Thu, 25 Jan 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooRJLOSl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE331BDD3
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207427; cv=none; b=Xqjd/VFePVvHFSz3OIDbXwZK2FQJsi6MEqmqzo6HM6bG22XQ2GfNWZqMln8yAB/lR4VBXi6GH9c4FADcHkyMJIGZLd/PeVwghpSXgYO92cH7RHsDnECenJ/WQMs0R8aTLTMeeKS/6M2j7sVN2bEI15Ofhu15hOhd42KK9zP06jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207427; c=relaxed/simple;
	bh=JBzIoKRwheHfwef0HCpxCRUoy9MpDPFj+XDnMTjxHfU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LUBzTGLNEkTa8e3VPJjBODoMyyV2gwkabJv95zgibBlcX7Lj/7BpqNOapGncFSK+0j9lNlMlZYNbw7JBwtF4r0U3ADm63kvSBDys/mcZx5LGEdjAj4NSZtjfEB68SpQT0GAarjQ6e2mcilv/IG+41+jVgB75AkEfLRriMA8qfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooRJLOSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9A6C433C7;
	Thu, 25 Jan 2024 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706207426;
	bh=JBzIoKRwheHfwef0HCpxCRUoy9MpDPFj+XDnMTjxHfU=;
	h=Subject:From:Date:To:From;
	b=ooRJLOSlpoA+agrjpGR81Aztbi6CzDMwLTFKAOJrFzjxoqJ/ILkNuBkqxiWxwNHPn
	 0z+J+ZrKeFrYRPOK7to6snF3OI5Wv6i9FiCpleJWqXgI4JqIa9UqsVb3gPBpj4RFEn
	 bJ8OoLBfrshATo95fh0txSGhtluye3DreQBde68+WcBEw4gl2BzyXFL1GcmsNpx7jb
	 HYCpGqHHm2iFOEcJdb4e0QzIsVThwzD958hY4IyIrdqadDH4CvtUeO8hEDeVMFPINA
	 sS4scEWgFa2ow3UEKQRjOJ66kZm/yK7pDkLg3YeivcRNcrvz1kRAmino5k4QI/gK/2
	 gTH8+gb0mGVUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F94BDFF766;
	Thu, 25 Jan 2024 18:30:26 +0000 (UTC)
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
 <170620742649.32275.15870660893829133237.git-patchwork-summary@kernel.org>
Date: Thu, 25 Jan 2024 18:30:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cs42l43: Handle error from devm_pm_runtime_enable
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=819584
  Lore link: https://lore.kernel.org/r/20240124174101.2270249-1-ckeepax@opensource.cirrus.com

Patch: [v2] spi: cs42l43: Handle error from devm_pm_runtime_enable()
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=819809
  Lore link: https://lore.kernel.org/r/20240125103426.2622549-1-ckeepax@opensource.cirrus.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



