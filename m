Return-Path: <linux-spi+bounces-2712-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC5E8B9BEC
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918FC1C20EF5
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8934413C66C;
	Thu,  2 May 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2Jg9k2a"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AC219F6
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658202; cv=none; b=j23inO0F0ntXOxgH7CbyhLkN8H/JGoCuLnUIrvqT7RNiCcTLAmfnkm091NeAO2Cd3ly3f/KMoEMJChLMBAa+aA7rxF3/gS6Vhp0dM6SfiEyJTLS7srvnfpz8YF7BM0jE1ak7IT4/MN+vRYScu9gTbvliGUwrJkMZl72VK9GLQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658202; c=relaxed/simple;
	bh=R3Yh58oh8oBMQ08Hq2dxCZ1hYpFnord4Axm5qDSfoBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=g/s5SY57uejAe1wpj48HIlWJbzmdaw3pjUdPEBs5S/yTGTekIqxqrVNrr/1esjLvib0wxPTyetbwKuByEmtqDEhU4MR2jpRrhIRc619KntFsgqTvjf9kVrJ1AepP9DcVLc1Md0dysVVmCfRs0pp/bpZUlHcMPCAi8whGhtd8+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2Jg9k2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC6E2C113CC;
	Thu,  2 May 2024 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714658202;
	bh=R3Yh58oh8oBMQ08Hq2dxCZ1hYpFnord4Axm5qDSfoBg=;
	h=Subject:From:Date:To:From;
	b=H2Jg9k2amF6yxQNoDJRpKpJeiAL4k5S4yWEvhFzJ2ui8uMqmUA9e2Et/F/db37ETE
	 0S/I7XxhCOfb5hB+k7Y116McqUiGeK6QXob29+r2NFmyLeaeOiJN25zsY4GbXR83EA
	 ERiZDla/3Orwm4WcGeIAW9Z5vkWuIoNzWAzwEBD6pKqVGeWN0LbCWiRiDE1RX/0fn+
	 TtPV0lhHNLkq+cU3ULe5SaH7OUjY4znzUV+Y7ScLXiENRiut4MWOfjHqsgKOUzLwj5
	 WVT9WSQLyhTuxqIt9x86/dT4qu8QCfd01PpJzaSrjwrlQ//1+6NH+kyfpovDCKdO9C
	 6kKOjapA0DwEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA356C4333B;
	Thu,  2 May 2024 13:56:41 +0000 (UTC)
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
 <171465820188.13904.10957942979163114405.git-patchwork-housekeeping@kernel.org>
Date: Thu, 02 May 2024 13:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add optional reset control for Cadence SPI (2024-05-02T10:48:00)
  Superseding: [v1] Add optional reset control for Cadence SPI (2024-04-24T05:13:15):
    [v1,1/2] spi: spi-cadence: Add optional reset control support
    [v1,2/2] dt-bindings: spi: spi-cadence: Add optional reset control


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


