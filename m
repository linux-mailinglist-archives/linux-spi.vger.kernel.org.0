Return-Path: <linux-spi+bounces-4896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91497D314
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 10:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019F21F22685
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E613C683;
	Fri, 20 Sep 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP5WuddJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A061311AC
	for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822614; cv=none; b=dkwuXQP1kl+MqzN14bdWdwHAphgU3vGffAm+HTkL6lNa+20XdYaRR1DdeK2z461yp/uyuNTaqTv2FCSPBKEeRCgjYYtxSCvvFyDnQMIgQ1YddTc38KIlM5671KX9E4pNnXpI4J72n+ZfGw9haOtf7fr0q7DGULPCr1ZKslc+H/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822614; c=relaxed/simple;
	bh=YcXwX4nZ2HT0C0dYitOcEdc3eC6HVNWH+O8GySPev1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sMYXGprF/NyP0LVCzm0E54dZONHxs33alZf8E7lvTYfQJ8OKBovK1gb2MiFj1nHiCFh0iKKzG2gjwFORVjOYsw7e5ft4H8rO70D34SFvxnEtml61+FfxW8wUuTYfojglpcFoKhzxJT1YzeTmH6ieAXq8KDXyN8IYnAI9vu/zj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP5WuddJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A0BC4CEC3;
	Fri, 20 Sep 2024 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726822614;
	bh=YcXwX4nZ2HT0C0dYitOcEdc3eC6HVNWH+O8GySPev1E=;
	h=Subject:From:Date:To:From;
	b=IP5WuddJz4FFiRB2ClRPxbpR2nUSOObs5Ww4Qjd//T2LqqMRfgVWmjpDJprqwDr/K
	 IBJty9VLTlcps8K3RztHnpdbFpZgh2Wal9oHymskRSi/s3wpPsYp3NbH9dpPgT/WYY
	 CRFxoPklrxXZ39++B0vaM1Gl1hp59oOyzrF91BCse8tVyiELcsyqPGv8ELX6PGaNnx
	 be4ZiQYtBBZV/nMYkgtNZlfbFoOmf4Mr19/2nnwFPQqCQXZonM5rFviuesjkKK81eU
	 WsX6inL0aOSVeZzGw8+faklt5DW5EnBBicCmMXZ44p1iTJug9dqWdhUGJu1VHG8SaG
	 e0TLwh4ih8YPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343F33806644;
	Fri, 20 Sep 2024 08:56:57 +0000 (UTC)
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
 <172682261589.2125035.15296882656200322299.git-patchwork-housekeeping@kernel.org>
Date: Fri, 20 Sep 2024 08:56:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] dt-bindings: touchscreen: add ad7877 support (2024-09-20T08:24:43)
  Superseding: [v4] dt-bindings: touchscreen: add ad7877 support (2024-09-13T07:52:29):
    [v4,1/2] dt-bindings: touchscreen: add ad7877 support
    [v4,2/2] input: touchscreen: ad7877: add dt support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


