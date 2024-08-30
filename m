Return-Path: <linux-spi+bounces-4483-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C50966925
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 20:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B23C1C21AE4
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09851BAEF5;
	Fri, 30 Aug 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWNYo2Yi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A31BAED9
	for <linux-spi@vger.kernel.org>; Fri, 30 Aug 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043829; cv=none; b=N0xVZadsGIM+NGi3yPJBjSlmHks1/kOIiEYE9l+mcG4gC/H1p1gOYUACKq610n6nyeqFT5uNRGvEoSGN5Dm1JZw9x+cUFbsWojJDY3ERdsFYZt1p6MdHwBUthYWFkzRar7iSSenpjgkJ55LTTN2oW7gNfkR/zJ9upRJ82QOjeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043829; c=relaxed/simple;
	bh=0z5bSrBMSoawF/SKl3glhuPrKfzH6826deNqyrQlaBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gmsktvc5TDu3A5i1vDBvau3fXQog1qvsWvZ1P+jIPtatam6zDfSrg21INXIegacZVGhf3ZzByj26+zf6Ec3KcM7hKoJkiAUo6wzzeqLdql09EPVHBwW8txQM7nrlDRcLto2sYOUTkuFpJhs2wHzkpZVDTAz8atAU9BpRKjVWQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWNYo2Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176B9C4CEC2;
	Fri, 30 Aug 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043829;
	bh=0z5bSrBMSoawF/SKl3glhuPrKfzH6826deNqyrQlaBA=;
	h=Subject:From:Date:To:From;
	b=eWNYo2Yitr7u3PdHzFjSmzZlGICgo3rSeNJkEVIR+9mvEgPopsW0fDq+QOK6+Ut2Z
	 Bt65KzHp1/gME7PoGaRWNCGEvQ2N9C6s6x00g+pkeblmhY3cL/Tw1/0fVcbNb6PN5O
	 2TW+G5ljUepU8aLuLDc1EzV2yhPUwFnMtH9PnZKaqZDMqi2YAH6KXfVUSbneRfgW0J
	 PicnVYDjemT7d0YdrtOHVObNCxp9inN1UeQV386uqmS0Qru32h34gVUbs9ia3ygj04
	 SnedVL/UbH7WFXobzgKLThXDjosvnjGg5Xm/az+2gwoKIws0JPEyCKukcC26D9h1vD
	 nqJuss5zE3DtA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9EC073809A80;
	Fri, 30 Aug 2024 18:50:30 +0000 (UTC)
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
 <172504383057.2684850.5147986627049220916.git-patchwork-summary@kernel.org>
Date: Fri, 30 Aug 2024 18:50:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Use devm_spi_alloc_host() to simplfy code
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=883308
  Lore link: https://lore.kernel.org/r/20240826121421.3384792-1-ruanjinjie@huawei.com
    Patches: [-next,1/2] spi: zynqmp-gqspi: Use devm_spi_alloc_host()
             [-next,2/2] spi: zynqmp-gqspi: Simplify with dev_err_probe()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



