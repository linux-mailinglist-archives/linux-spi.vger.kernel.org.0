Return-Path: <linux-spi+bounces-6822-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04832A355FB
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 05:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B9E188C4DE
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 04:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412522071;
	Fri, 14 Feb 2025 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmbNbwz9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19522092
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509004; cv=none; b=axrSO+W8FgUeYhocb5YydZTC/soQJt7DNL5Ne3j+/JfDsD587OO1bTmDtq9U2un51j9YGBKR6jPxmKI5ke/9qrIOYNQQvlcu8howXD4eDNr6IICcUpuMyjgOtoY/vzzNfCjGX5W1QYJJXW2ZUOsrPrTvUxkJXpPfUSuDYhLhbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509004; c=relaxed/simple;
	bh=htWh4fal1l0wcSCuUvpscmExIGbrbplUbvvgbg/MinU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kto2bd3Ki5Kx2jy7PnDQPeRl5FfRjS3ylSMg1lo+Tisph4GQ+OJAKshH17M5XW4yAwuh9rs3hzfM/ZSw/xSkf90e/o3Y3adNxkloPu8sFCc1+Y3tgnv5Jg7k+gjcJ/b+6/qhKSNlFBr/wHabF2KyBfn9oEKVSpXCRDXZKYvUAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmbNbwz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D0C4CED1;
	Fri, 14 Feb 2025 04:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739509003;
	bh=htWh4fal1l0wcSCuUvpscmExIGbrbplUbvvgbg/MinU=;
	h=Subject:From:Date:To:From;
	b=hmbNbwz9WvFdLasP8q0WL5U0wFLxB1Tdqh2L9vu0rAXkM/c4KurwAdFn1MrAfUY1k
	 aFSQB+b/pwJX+s0zjXSy3it8Q+wpj7Yd/81Eb8dMvdQBvF9iwKt8a0OxlxPSR9Nku8
	 D9CyNi19CSpHvPX7Act6v8IlEhOsOa4ZRtmsJ3rkeuz0p3Xomu4U3rObCcC9IWAfXj
	 McJfXa1xsoC63jy99u+1OtPLWMv7/K9zOWUmYY/LT2lkZ12sp43i4v06HMTkSx7PHt
	 AATUEgTHDekJklBsngmGCIy8nsgp2WYM7mBuxZX6P0r54GFz6xtJn6bwYf8o4d9KvM
	 LcyP08XquGbGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4E380CEF8;
	Fri, 14 Feb 2025 04:57:14 +0000 (UTC)
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
 <173950903289.1501452.2096182427852829847.git-patchwork-housekeeping@kernel.org>
Date: Fri, 14 Feb 2025 04:57:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: s3c64xx: add support exynos990-spi to new port config data (2025-02-14T04:33:40)
  Superseding: [v2] spi: s3c64xx: add support exynos990-spi to new port config data (2025-02-13T20:40:42):
    [v2,1/2] spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
    [v2,2/2] spi: s3c64xx: add support exynos990-spi to new port config data


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


