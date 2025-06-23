Return-Path: <linux-spi+bounces-8716-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A2AE3923
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BAE188CD10
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9120298C;
	Mon, 23 Jun 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbrCZK9w"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E5201261
	for <linux-spi@vger.kernel.org>; Mon, 23 Jun 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668983; cv=none; b=ELmM0CwElD0OME6eN98EGbhvud1/b8T0//KbSKa2dXni41WLiIM/ObdcJhOEvkhrvb9aMof4iIjULsPN+Drs/7kKeKmRIa2w5hS/Uj41TDSVABBj42mn9L63dCfE6BXUsi4eQzWI8yDJ/Mdboz5i925osu0qF7sT1v2O6H1RzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668983; c=relaxed/simple;
	bh=fGfwEuf8rrG4tWCOszVxFThupuDrPLU5IAE99xxNtdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Wq4TfDKft7PtSdkejqze7ZU7jcBObokVpjpez+7/qXs+Yx6K+De1gp4ButJwr3uQpopg4CHvbQiPaKDY4yod8LRFjMYlAX2vDYC+pa0dzNDysoDcegw+loVK8Kp03u1D5pWiHRyNGWVHxDXbt0p5SZvaVumsuSt9w/OBmMoEsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbrCZK9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53309C4CEEA;
	Mon, 23 Jun 2025 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750668983;
	bh=fGfwEuf8rrG4tWCOszVxFThupuDrPLU5IAE99xxNtdo=;
	h=Subject:From:Date:To:From;
	b=WbrCZK9wny8KwUGrmar+mn09v677je4VYniwEKV46PGVZdRNevr9Y5Mh1oeWNPjso
	 I3ngmbXJJTDV4bQuGpUl94mP9udOzyAshIMYvLmnt/njSLljlDkbP3EJBS5h+LO2Hg
	 O1esuv94blGYR6yb1jclMmJ+D1nXYC5KkQEjYMIZlOJIhyYhBfc2oeVrVr3J98vxjY
	 TqBrGbameyjzh00GloL9YGI8MtiLiNq6K84HTodirlYYXLL9W9TthOdt4ocex8uodS
	 jzAf0SthiekSFv+icPiitB5dTqMBJ1v5CbbU8TbFuoKjUQTfbNSz9pNtFRn66zmJYe
	 qRaOKT0JdAn3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4D38111DD;
	Mon, 23 Jun 2025 08:56:51 +0000 (UTC)
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
 <175066901034.3040829.16243417963505848239.git-patchwork-housekeeping@kernel.org>
Date: Mon, 23 Jun 2025 08:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] support for amlogic the new SPI IP (2025-06-23T08:53:26)
  Superseding: [v2] support for amlogic the new SPI IP (2025-06-17T02:48:35):
    [v2,1/3] dt-bindings: spi: Add binding document of Amlogic SPISG controller
    [v2,2/3] spi: Add Amlogic SPISG driver
    [v2,3/3] MAINTAINERS: Add an entry for Amlogic spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


