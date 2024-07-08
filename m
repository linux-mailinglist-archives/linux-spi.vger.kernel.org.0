Return-Path: <linux-spi+bounces-3780-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE192A354
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981CB281946
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A4824B5;
	Mon,  8 Jul 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehYK4tZv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163581AD2
	for <linux-spi@vger.kernel.org>; Mon,  8 Jul 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443383; cv=none; b=hqCTdW4HoDsEU/GxjrsAkYxxu3xRbp2Kb849vbIWiGJLnl68LEGupicpRehRM8XRvUrcLXuXs1vNGj8he4YOfURM2SDWBhLqTTSZ4bzONVRPh7jMoFZBSyYW2/6Bk6KIjJwzqERMxjzhdEAjy/v5R+aAcZVJRKwva4DyLZNBryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443383; c=relaxed/simple;
	bh=YPnH3eBsRTkP40ZACC1tcte1r6IB7p9pmoI7MFvPsqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AfEuz+pDNFuah5Sg6khr0+Pxzx171K8nFSm5AsnsHO54s27KwxUCVwXOQuqv+K0tqRl4gV6NzMSLiKtxVSPy6xza0sRcwluMY5jvZ/dqvXu8Rzl5GEv1nHjToEHC8F+cgZk4x5RGxXhXmXEX0S7lOLkzzee0H+4CBhHAPoKbMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehYK4tZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D843EC116B1;
	Mon,  8 Jul 2024 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720443382;
	bh=YPnH3eBsRTkP40ZACC1tcte1r6IB7p9pmoI7MFvPsqI=;
	h=Subject:From:Date:To:From;
	b=ehYK4tZvF7FTHSLvVhe74z2g7mCRfz78RsQCOfheZPsu9SPCt8qOe9Rd++PXnGmZY
	 G5Px+8WBMn1ldE9jhErak8dkPnXiNoUg6eMVhX4gxUlCBH7itWHb2O29qyQblWM9j/
	 XtG4XJNFc4XsQWQgKb2Tu5bxVRjYZsmT+v/c2r9Pp/OkYa2to04IOZJUOXjcmunlL+
	 uNhAFPX651ieQk84IHiT1ljhYWsUmxApI29jhfDUCy9BTvo3/5eNCPg8w18cjXb7U3
	 cuKTJFbb9q/Jajg7+6bHepmcVeJEgEICOeAgTttIXbQAdDF61gZWEROPikxedrMw/r
	 T9xO5dWI6QqNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C591BDF370E;
	Mon,  8 Jul 2024 12:56:22 +0000 (UTC)
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
 <172044338280.30900.368894144481353656.git-patchwork-housekeeping@kernel.org>
Date: Mon, 08 Jul 2024 12:56:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: add ch341a usb2spi driver (2024-07-08T12:38:56)
  Superseding: [v1] spi: add ch341a usb2spi driver (2024-07-05T14:51:37):
    spi: add ch341a usb2spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


