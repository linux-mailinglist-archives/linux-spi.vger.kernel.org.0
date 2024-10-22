Return-Path: <linux-spi+bounces-5295-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80DF9AB9DA
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5468928437B
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54A5174EFC;
	Tue, 22 Oct 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMCSDyox"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022014B97E
	for <linux-spi@vger.kernel.org>; Tue, 22 Oct 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638625; cv=none; b=bgIix58tHc6ziitujMAbQ0kv7OcThWRztoJELwEZw55+4waC30A8YS/8Ix9SZfLDeM+ZK6JeJXspO5etb4Rm2FcES0Qaqwp5HwurU5dbz73APHF859Anjjh4krdwgGQAqWQypeJF1LH5iswJUDvI7cJZGtHJdnWGG6KT53HDloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638625; c=relaxed/simple;
	bh=om7LSs15XTeo2af03qGdrSRMAydjP82erDzPOYSt+5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=S5lZpfPA2M7eoaufYL6IvT/NSDOdRZaJI8/RdCLRz5KhVgho0ySCU39NLb2wiJzDIslp3H3qca/6BKYgXLdQ3m0p8O7fLGd9d27/VAPlDdbRJF0pddp0JO9XZbn2WSrPgdxT4ROi0vHjmrzFLokpoSYAtu2UDS3/EkXt7WHbQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMCSDyox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8C1C4CEC3;
	Tue, 22 Oct 2024 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729638625;
	bh=om7LSs15XTeo2af03qGdrSRMAydjP82erDzPOYSt+5A=;
	h=Subject:From:Date:To:From;
	b=aMCSDyox5gddZncba7bp2EMDjMkcib7AYJq85j56P4rSJeZakQBQLjL4MQ/xIcX5q
	 kxtZQPE+nLwjscGBxc1tK4QAwG60naA9fVE8A5Li7gUU2x43vXJ9jhjeX0ej1p2rUN
	 kUDKXbqiPDbp4olGVvRrQPdmBVX0Rtz1JpJPpjSNpNTiFFuRAs3jMvH6abLepADNq0
	 Pc34k8GOXayGHyxSdSMnXbAWTyidIP4T82DNkv4VIeAkjwxGPgAnmvER0vZQr5d52a
	 Jkr2XcZFLA19m2NftC5NEnULbLPYvLEKAtsDuQwmaV9dPOoB+Mc8npYMes7Bln6Slv
	 nvLtfKeAH9Tsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7515C3822D22;
	Tue, 22 Oct 2024 23:10:32 +0000 (UTC)
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
 <172963863088.1106081.3957122233937040219.git-patchwork-summary@kernel.org>
Date: Tue, 22 Oct 2024 23:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: geni-qcom: Fix boot warning related to pm_runtime and devres
  Submitter: Georgi Djakov <djakov@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=896912
  Lore link: https://lore.kernel.org/r/20241008231615.430073-1-djakov@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



