Return-Path: <linux-spi+bounces-1468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5322F85F643
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 11:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0ADCB2777A
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC738F88;
	Thu, 22 Feb 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLpLlwOn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CA3FB1B
	for <linux-spi@vger.kernel.org>; Thu, 22 Feb 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599393; cv=none; b=GYJCPdnFF/AW8IbxvG8vZeeD6AmhjxjOf7+1QZUlf7vnW+Lj8hH5ccsi0wNxn0p/uZr+cD4DGyAqbmCnbQfv3u3Gv98FsCFdb02YFnemnrWSKJxc62IXfS/rgfBmvyvBSvhewr9Q8ezyWdE6BFdtQRMUJcdCB5ra2PddlFXXOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599393; c=relaxed/simple;
	bh=+d7wAlTFXxN+zfAlQOBbauGN8Pz85AWMCTBiOycwbnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SZ+ZRJWwotW4nbVzLwmXQ9HeOLX+ZtWqNz61BVaq7tBAq3CE3mO5sz2ZWpRlsr4DC1dCimm1/dlmQvecH2urqasI25uqeGwOCkiAaSngmcwnAy0gbEDFmslMXfbvbqxzFmFvioxdTL8Dve4GKQN+4mj8KrdHVtMYJIoLd9UepbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLpLlwOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BA8DC433C7;
	Thu, 22 Feb 2024 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708599392;
	bh=+d7wAlTFXxN+zfAlQOBbauGN8Pz85AWMCTBiOycwbnU=;
	h=Subject:From:Date:To:From;
	b=pLpLlwOnrnFUZ9N/ZhGBlgzLInfHChFHZ0eHuTDDHB6CxSw79lawmAVWGo5TVkb3P
	 sTaGQsuHmJ1CwKIqUwkt051v7AsTiG8kxrDf7iG1hM3Oa61S0+BpnQ0mPH5N5mGaNb
	 G4ZUXUutFu0G7R31GgbF2quuD46MHMuNd56nagnXuo/eQckcsYBM1rAphYIhilOqz+
	 4/skckTBoYQgB0uc+qJtIjWNYE9edK4HoShZYLBde3dMrYxDQIxTQgedrqX1ghjlMZ
	 vwMTH2UcnGYsYS8zzvwRnz0zd6zu38EbjR54wMCelEwnSmOYBc9afEIF8K2IB1R6DK
	 93InDvQ6+X0Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30D0CD84BBB;
	Thu, 22 Feb 2024 10:56:32 +0000 (UTC)
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
 <170859939219.9487.13134364096485754639.git-patchwork-housekeeping@kernel.org>
Date: Thu, 22 Feb 2024 10:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: cadence-qspi: Fix runtime PM and system-wide suspend (2024-02-22T10:12:32)
  Superseding: [v3] spi: cadence-qspi: Fix runtime PM and system-wide suspend (2024-02-09T13:55:49):
    [v3,1/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
    [v3,2/4] spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
    [v3,3/4] spi: cadence-qspi: put runtime in runtime PM hooks names
    [v3,4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


