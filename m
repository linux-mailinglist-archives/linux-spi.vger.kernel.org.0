Return-Path: <linux-spi+bounces-8457-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0EAD5B0A
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C476D16139E
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957A1C84CE;
	Wed, 11 Jun 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/V9fRyD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409C198E75
	for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656998; cv=none; b=lFmo0/0rhDXyakcLbrdynG0pBJFOADuo7r7owaM4fWbWTO10l1I/Qz5YLwyrQPQRBoSyCw3bJJPSp+IXqykPpFaWNz0LSLX1nQg8v1+JL0se/x0DXeqoJ56T4DNNHFwpW5R43HE7A17ssxZKxJQfmQl0HolwftvMaUtPZ9zmWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656998; c=relaxed/simple;
	bh=+dQdih07I4IXxyHC367MK4H/p0ybxthtvZ19g+0TFIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uR929HkT8OMgrkhk229RrxsugAzAcEVwYZaU+sNOH07GbagrfIAAOt4gF8JIS+Xh7OCCcf2VrWJLuBvNC7MrZ7jAIqoAN8a9yH6Igu5NjKBDyBzQgNWnSKlyNRg++aWB6461IoPLsV0d5te/NQkf8PoHQLMb5uSqCNCF4UqTb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/V9fRyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC06C4CEE3;
	Wed, 11 Jun 2025 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656998;
	bh=+dQdih07I4IXxyHC367MK4H/p0ybxthtvZ19g+0TFIE=;
	h=Subject:From:Date:To:From;
	b=Y/V9fRyDZj1syGYZ5V3R0Z5cPCO1niz3aAiVKacGsyVhvpNJfCUhHxxfcqrk4/DuN
	 Y+pJhK4fUY48+5SVJJBM3P78cJ3iMKnVuFCm5uPMnKBISWrriHVQAwMNbhmFz7o2ho
	 LSmM4ozDGc2yFXAAT/Ls+kJk8+R/KGwLvEC4/Eai2SqluJULFtTqBfHIZyEdGZ475i
	 cLRTNo7QGK1bbpJAPTIYS/14TcGkCd0zlkPV6tP0bXQVUWlDsZ/Wqf2C2LCL/b6eAv
	 X6IqpeZkEe4vTShCsiGzzRwN4VlFiEqhe7MVm1ec7B0ijqm9S/Hxu3/mMxnmxqCHvF
	 JEScIwA2C3www==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37C0339EFFC5;
	Wed, 11 Jun 2025 15:50:29 +0000 (UTC)
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
 <174965702778.3379905.10530204446105074754.git-patchwork-summary@kernel.org>
Date: Wed, 11 Jun 2025 15:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: dt-bindings: mediatek,spi-mt65xx: Add support for MT6991/MT8196 SPI
  Submitter: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=970806
  Lore link: https://lore.kernel.org/r/20250611110747.458090-1-angelogioacchino.delregno@collabora.com
    Patches: [1/2] spi: dt-bindings: mediatek,spi-mt65xx: Add support for MT6991/MT8196 SPI
             [2/2] spi: spi-mt65xx: Add support for MT6991 Dimensity 9400 SPI IPM


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



