Return-Path: <linux-spi+bounces-4423-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEFE96439E
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 13:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9E0281E43
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05118FDB2;
	Thu, 29 Aug 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzMtUic0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7E18DF99
	for <linux-spi@vger.kernel.org>; Thu, 29 Aug 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932580; cv=none; b=hN9nwRe6BMaubcLlEQFMCbaq+gYpolCFLtE4aiQKIMmp5SAi3wTSfouqQ8u+AURHDC2G58ZL+ZrS4fD2XVxK4NSeBMbxkQYhZNO9ZNkBGziC217u2+dPA5T6sA/Ny9GM2EsO7u7vJyZJ0Su7xcBkkOzgt8D9yM11a++KhgXkZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932580; c=relaxed/simple;
	bh=OguQRcIQvzmR/sVS1Qiv+M2Szb15WuyX4e46Smzo1/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qZHNL+Az9Yo6K7TPqhhre9pu17S0v07TucF0mT6fRACzYNskCFs6gaU7/paRVqzSPSw02FcTHjklDJ4K/JdGSYv8PdAj1Fl6z9sfAjdyXBjPCD7A7pzPwbjaNpbACNzjU5wDLHNIw7Yop26YKx2+DSI+Y298tXYNwmRvwIniNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzMtUic0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B279C4CEC1;
	Thu, 29 Aug 2024 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724932579;
	bh=OguQRcIQvzmR/sVS1Qiv+M2Szb15WuyX4e46Smzo1/A=;
	h=Subject:From:Date:To:From;
	b=PzMtUic0ZMX/hKmuRxn5Ay/Ig+i0J0NOg7bRxVUymbn7fowOqcKIHAglKAZIcdJk3
	 IRLxMyaCJgeyuh0YALtmNhMC7noC9bFv+GBk9w9MFLpPyC+jGcuulPUrj3HW22uFU9
	 4Tx3lTM0KxE6kA4Nm2wNWUOBm5PSWlR0PhQIZKfGQrXTVmKUyDz0JqF4n0e9UVcV+0
	 I1fWWaOTO2V/glOiET/z35/sd8TUwhXmg34c25JM4pqWY8PCQzQvMRTV0N6Vb+ke+g
	 imUw5UHSIEBqa6KZrkshrICdcahRFlDao9KK2yHAK0yUvPIH/1EBIlKoCzzjKxZGyH
	 Szp7JFdtt/RKg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CCB9F3809A80;
	Thu, 29 Aug 2024 11:56:20 +0000 (UTC)
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
 <172493258082.1922414.2775926760790912328.git-patchwork-housekeeping@kernel.org>
Date: Thu, 29 Aug 2024 11:56:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] dt-bindings: trivial-devices: Document elgin,jg10309-01 (2024-08-29T11:31:56)
  Superseding: [v2] dt-bindings: trivial-devices: Document elgin,jg10309-01 (2024-08-28T18:00:55):
    [RESEND,v2,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
    [RESEND,v3,2/3] spi: spidev: Add an entry for elgin,jg10309-01
    [RESEND,v3,3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


