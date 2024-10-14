Return-Path: <linux-spi+bounces-5225-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63D99BE5F
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 05:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98049281DFE
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 03:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DE53368;
	Mon, 14 Oct 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBcPsVI3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5F231CB1
	for <linux-spi@vger.kernel.org>; Mon, 14 Oct 2024 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878190; cv=none; b=kA3HFyJEz4hCiBIf7DkRyqEOmhuV7kqkWOSs6iRwNE7qGqxJVOlxSEXV6qsh0FR2HJBJqMofg8iSoScm8poAbLQ7PXlvNkACvNBzTT0qg80XCC4gl/zmYGVlIgL5k0A9Fc7wmtxPRALEc7iFI5GrQ7IFKpMIqB95p+nvDD+BU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878190; c=relaxed/simple;
	bh=uhbb5Oh19csUpniLtqUecgx8l5+j407iA80c+DtAcJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=i8negVr9AXmXpGxm4qYla8e4THX1UC8fCycpNK1Vwxn0zi6FI+747JiP36OMf1PPvTgfnC6r90kqWKvwNO2k3j5fXHMkQP4F0s9BUSFJXXlttMhSz3RJExwOWpQ1CCy17lftGZGnepszeu/YAUwvU7oF9fP6TAUq+CoQTx1tvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBcPsVI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCD1C4CEC3;
	Mon, 14 Oct 2024 03:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878189;
	bh=uhbb5Oh19csUpniLtqUecgx8l5+j407iA80c+DtAcJs=;
	h=Subject:From:Date:To:From;
	b=qBcPsVI32PkOHZ03YWBt0+GIOvZSBk7J/9/Qoe7Zs79vp8FnOxEHWrh6iUe0Kuo9Q
	 tSK2IaxBXKVJAldykMTWm+ORvymHyCduwe+9zlpU0M2xiwvaxhlS5FrUasTAs66zG3
	 m/31dGkrNQxuODhQmfVKZ5cUHNUJrseceN4stO/NW0jBFXXofqOZ2ONS5AA4OAgR3r
	 6VEqvc7yP7+diOvMfAe9ziWFceI3KuLLwA6HJu7IyhvQH4TXuI+Nj1kMjfLOT5Ptqh
	 H0AdclyZSwAJvPe8DwrSyY9mf6GAFzWIBO2ZZ2YvpaX/zeVub8zSq67YcxccYA30Z1
	 tTfHfFeE5mfkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3CF3806656;
	Mon, 14 Oct 2024 03:56:35 +0000 (UTC)
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
 <172887819442.58893.14991466542399781961.git-patchwork-housekeeping@kernel.org>
Date: Mon, 14 Oct 2024 03:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Realtek SPI-NAND controller (2024-10-14T01:52:42)
  Superseding: [v2] Realtek SPI-NAND controller (2024-10-08T00:23:06):
    [v2,1/3] dt-bindings: spi: Add realtek,rtl9300-snand
    [v2,2/3] mips: dts: realtek: Add SPI NAND controller
    [v2,3/3] spi: spi-mem: Add Realtek SPI-NAND controller
  Superseding: [v3] Realtek SPI-NAND controller (2024-10-13T22:39:05):
    [v3,1/3] dt-bindings: spi: Add realtek,rtl9300-snand
    [v3,2/3] mips: dts: realtek: Add SPI NAND controller
    [v3,3/3] spi: spi-mem: Add Realtek SPI-NAND controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


