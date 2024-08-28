Return-Path: <linux-spi+bounces-4363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E5963082
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 20:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC68C1C21093
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAD91A3BDE;
	Wed, 28 Aug 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAp54B8Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA18C328DB
	for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871392; cv=none; b=fJZLvdC4cHPTImZzEthGywgXXv+MHNO9834GmLTnw3eBbnZrNup2QsllxsmFUtJxE6V2XKN4iccbKCUwIKLeC5JAE98QJ45WTxK6Uwy/wDZxrHhphLF5FxUudoyGLDJtql4HG18agS26W0Q4Z2IrV25V3PEn4HgqXb49RqYqbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871392; c=relaxed/simple;
	bh=PIJ93SmvfsLJCsupH7/3ProlSwJeeJlYeuCCTW81x9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CjHtQI38P+Aiugp7xipnJpE/cW7bA1TkPq2VjsXU5oLQU1PMCHCxwf4koIbuNoETgT9cqnib8hZyhWB4shrbU3jGgOl2qxP4Y+75wIwCfDM5ak7Szkv1kbG4o39B9sTIcQSp6+7OmAxTZ00oj81Wn1zcNMdkdCvgX/A5XrHA49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAp54B8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46304C4CEC1;
	Wed, 28 Aug 2024 18:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724871391;
	bh=PIJ93SmvfsLJCsupH7/3ProlSwJeeJlYeuCCTW81x9w=;
	h=Subject:From:Date:To:From;
	b=IAp54B8QOi0x6B7nqoeHTChfvdIvU+64uEm5p+0NbHT6UmbHBsYuTO/7EMUeLSCBw
	 Q5o1m8yplOY7+gWSY0Z3vAXzlgByZA1/cggkDoZ4AR3Kb+fu6gadNrcZ1anDXwGYqM
	 FGj3Fs9q/FUDdgBbysJz4gnudGBFhN2sPOVIbn2DJeTLqoUlJCVzF/xVE5cVFPVYYZ
	 1unMyUWhAiT6tejRVwmo1fLLxT/KJnbiNn+pBHpgUQjkYBVx1t5ZWXmPZdII6YGK6c
	 9KQiGtfob1+t6oUiwu5l+nk7NBC7WCF1+ESpA56IuHQ6/TPRsw7SwJPw0l/By3s3cY
	 2J5hPRjnl5iaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFA33809A80;
	Wed, 28 Aug 2024 18:56:32 +0000 (UTC)
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
 <172487139133.1395578.16865231974305806089.git-patchwork-housekeeping@kernel.org>
Date: Wed, 28 Aug 2024 18:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] dt-bindings: trivial-devices: Document elgin,jg10309-01 (2024-08-28T18:00:55)
  Superseding: [v2] dt-bindings: trivial-devices: Document elgin,jg10309-01 (2024-07-19T11:12:08):
    [v2,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
    [v2,2/3] spi: spidev: Add an entry for elgin,jg10309-01
    [v2,3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


