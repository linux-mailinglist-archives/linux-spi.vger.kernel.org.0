Return-Path: <linux-spi+bounces-2845-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B018C5134
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC392B214DE
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFB7F48C;
	Tue, 14 May 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi7JDAio"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC8D531
	for <linux-spi@vger.kernel.org>; Tue, 14 May 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684193; cv=none; b=HbYEGpHEfvCwXWQ8nRKNcltmRLm2nuAsDKi+K7TypdouZ6uR318ytjI9Uehk4WAf8GzEiubUPC/JNDRKDBrcc6BAhqk4bWxmvbXeAeRKn0ZB76LHh9KF/hbn8aAdtBTMIR+rLISsoY/7xedK64s6mwKyan91zwXEIqjqMHxYs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684193; c=relaxed/simple;
	bh=ToTRdijbCp2MKqvnQeRU92Y/YKWEE0yh4hncedAPin4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=P2V8EdTUQRUy34MNQJ9En+1BNNdrz4niSfg9vEeJjYly/lNcB8uihMgDS9OOcrISTsF20L8UxdDyyjw0og0B5yZK2RdgUDQCGw2bGStPgcJ4xuppIhIdKqoUBBr6RKYJ08LRej6MK70zBpPANIOwLB+6bQVvCun+hrsa6IzvXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi7JDAio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27095C2BD10;
	Tue, 14 May 2024 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715684193;
	bh=ToTRdijbCp2MKqvnQeRU92Y/YKWEE0yh4hncedAPin4=;
	h=Subject:From:Date:To:From;
	b=qi7JDAiotgbFx8fdeeCUHgi6QEdWRw1GAkl2aa8enkVuxrZrnS3TOejkVRZR1ka3w
	 Bzh0JVlp9tAp04QxjGW2yPdk8MgBc9kg65tjARcF1aBBRM4HzCDYF7IK4Y9+1XPFv/
	 MKBOKMkxJDqw9wGrf1HUa4Lic9pKg1gDRHm8aq/3Gej8rJF5Iiqv35tjdktFerkdo9
	 LAKhG2rQ8XnyWXlOz5KWHRXzek1G2PFW9QVRwOrJwbOzP45axF1YfB0maJrwbrMuZ7
	 6zvjQmdoAVZoH4610CnraMcFUe/l+jNl7Shzrnx9IwgkJOgErmT9LkDXJZA33hKkjd
	 2RCbL2Mf+ZmMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B2CFC43336;
	Tue, 14 May 2024 10:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171568419310.28649.17837175452731424428.git-patchwork-housekeeping@kernel.org>
Date: Tue, 14 May 2024 10:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add support for GPIO based CS (2024-05-14T10:45:05)
  Superseding: [v1] Add support for GPIO based CS (2024-05-02T14:34:08):
    [1/3] spi: spi-microchip-core: Add support for GPIO based CS
    [2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
    [3/3] spi: spi-microchip-core: Fix the number of chip selects supported


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


