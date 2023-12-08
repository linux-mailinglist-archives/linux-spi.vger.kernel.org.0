Return-Path: <linux-spi+bounces-184-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FE80AB68
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 18:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5EB1F21216
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3807111BA;
	Fri,  8 Dec 2023 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnMr8XJ/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636E46B99
	for <linux-spi@vger.kernel.org>; Fri,  8 Dec 2023 17:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1597FC433C8;
	Fri,  8 Dec 2023 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702058210;
	bh=QO4B3A2hLkA+svUtV7YigXufrjONa9B8aF7bzbVeLzY=;
	h=Subject:From:Date:To:From;
	b=JnMr8XJ/HxQ1GMgD5idMXscJXzEuzafS2Z7YSldPIGlIO/rro9laDZe1WmlDe2GFy
	 kA4ITkaFgfmJ/eQfDWtOMX6rDUbdztpAc18naS4xSQxwBPCm58L2O249teii1aDnoY
	 Aa9ZXyLkHLQBzh4HRedniPnygZ7ueSv2+v8WYx4+mziy8/PzpOPXc/in99TDUA09iq
	 /VIeiXrEBbPdQaGXqsmla8Qmivf5D3QX5YTdPGA6IGpG/MlA5q9qb5Ar+TDFebIGAe
	 m6ceGqQ/GHNYzsPaNYWIEeZIwN5sFG6Wb875VIWA4+G04jQmgpNSa5XIP6IPSqYgEU
	 Y2gKhjt5vnubQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EED81DD4F1E;
	Fri,  8 Dec 2023 17:56:49 +0000 (UTC)
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
 <170205820997.6688.11905771010306860097.git-patchwork-housekeeping@kernel.org>
Date: Fri, 08 Dec 2023 17:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: pxa2xx: Update documentation (2023-12-08T17:02:55)
  Superseding: [v1] spi: pxa2xx: Update documentation (2023-12-07T22:13:38):
    [v1,1/2] spi: pxa2xx: Use inclusive language
    [v1,2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


