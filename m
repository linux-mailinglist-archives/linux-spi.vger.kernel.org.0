Return-Path: <linux-spi+bounces-4583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971196AD10
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E72CB207E5
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DC51EBFFC;
	Tue,  3 Sep 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdOeM/6s"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77841EBFFA
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725407427; cv=none; b=Cq1/1Ncp83zhdKh/eG1GZDVxN0TwiI0szDFM4zoKhwrCG54AVfiePpfi89hHWXj7xGkd/wo7TwOnzZ9UGDwfujocgCoqWZ+IvcFjbUACqbRujDnhW/ZFZC567JJdOyycnLU2AyK5pEIIQePIc4Nfh6a0DcHrujbn+EBN/f/INtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725407427; c=relaxed/simple;
	bh=QbblyNYvl8mIxYrYJ7qvlDxljV2vQYiF57T5wPMRljA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nmFaAOwJPSw8rhufxoww7AIs4GenkBk7nYkWaYhFO6HocXd+15dfC6iltOvAwH2BqO6n0DxBk34RP1AGAArXyf+ePcF2npL0U/SZUnyKa/G+lAjKJ50ppSofNXF/BnR1Eo141jtl9OdXvmeE5kXXtPD9bSOIGw5ZByD+K10r6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdOeM/6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6142AC4CEC4;
	Tue,  3 Sep 2024 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725407427;
	bh=QbblyNYvl8mIxYrYJ7qvlDxljV2vQYiF57T5wPMRljA=;
	h=Subject:From:Date:To:From;
	b=XdOeM/6s6bDl3ZbNheuVgUDxrWNRxU/vvhFuZztWHv3K+sfPm0arq8fFFPVef34H5
	 Vos8zcZHnr6c9g6Jkng2as5I+GO2CO9phY6RO0zjEAMn4fXqimgA05bb3VRjjldwQ8
	 4rPhvnGJ2kc9k/7ZQJNH1pO3AheCgPhj1PLu9rfDuYEW2SziQOltP9srCeV4sQynKx
	 kZgJDsfuYsBFAinMq0U3Mt0+6wDTWks5mFPfIeVCb/+OERM+MvWI0eN46Oh3fuNeNb
	 Mb1cS3frHE3IbYFO1BYK8pF4tNOE4yb4iKFVSrbwZ16MSwd6QYdh3i3bKL5bOdpJCr
	 nSpbYq+0k4NHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39A143806651;
	Tue,  3 Sep 2024 23:50:29 +0000 (UTC)
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
 <172540742781.514994.17570272530293533409.git-patchwork-summary@kernel.org>
Date: Tue, 03 Sep 2024 23:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add device tree for ArmSoM Sige 5 board
  Submitter: Detlev Casanova <detlev.casanova@collabora.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886371
  Lore link: https://lore.kernel.org/r/20240903152308.13565-1-detlev.casanova@collabora.com
    Patches: [v4,1/9] dt-bindings: arm: rockchip: Add ArmSoM Sige 5
             [v4,7/9] spi: dt-bindings: Add rockchip,rk3576-spi compatible


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



