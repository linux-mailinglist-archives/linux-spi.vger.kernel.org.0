Return-Path: <linux-spi+bounces-5005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F335598760D
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2471F2565C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8914884F;
	Thu, 26 Sep 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2d+cFgM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9E4D8AD
	for <linux-spi@vger.kernel.org>; Thu, 26 Sep 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362599; cv=none; b=l7LjkVdSE446AwjBTqGYed+grUxsOJ1g9MdmTJXED+Z+ecJ9CMDmOJ+laOxB7TYUU3y16ycysLaGVT0wCOHeW18hjNZ7v1NX8UY2R0e79MhhyIsDdwO4UhurKyIHQFbuF2e8zu0tdgJHFRcAeXVnaLrPH8d1pZD7PJfh+tjSXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362599; c=relaxed/simple;
	bh=uskemBtNTSGrT7MCFMbKE6FMq9NsnaUC8dkahOvPeb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gh/tI4SGqP3T6tdRbVzn7J1fDEv1Nhv+r987rw0NEXQtlBiRDDD1BMHlkbdxKmKmRcFZnNu5a6N6d5+QxyIAzYlobp4iKPMiyCR9Uua4oezOjtRkbQGboMBMjbm1BYyJJmKRJN2KLgZFOdA02h0aWUL47ESqbASQM0Hp2S1c/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2d+cFgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E74C4CECE;
	Thu, 26 Sep 2024 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727362598;
	bh=uskemBtNTSGrT7MCFMbKE6FMq9NsnaUC8dkahOvPeb4=;
	h=Subject:From:Date:To:From;
	b=g2d+cFgMLwBhL45oaZz6urHHlGbgtiTJfZOUjphXeFa5DsofrlPd3mvF3/l1p8Jt4
	 Hcil9KE43wOHxBeD2vZP9C7KaHoTHfBWKSz7j6U1idntsEgOLRQC1jtAOFEHIgutGP
	 UklSMI3BGD9Xqht3JpzjvpRhLvO5j0nFLVeqp1VDvRQAGkuU0a5yaUBQSToL9KUH2C
	 PTg/1Qq4F3dF3i/9z4D8A/RpLkNbUIL3pr/oldt0sMlMjKbvRw04XJA2Oc2nxsUEUy
	 pLSDJQszI3pY/HcUILhmM9xvWb18R/fuO4KrAroE2A+N4T8BDnWqdYA3FI4k0wvmpy
	 wFfuCP4VV9mmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E05380DBF5;
	Thu, 26 Sep 2024 14:56:42 +0000 (UTC)
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
 <172736260089.1281283.17638089121200164819.git-patchwork-housekeeping@kernel.org>
Date: Thu, 26 Sep 2024 14:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] Add octal DTR support for Macronix flash (2024-09-26T14:19:50)
  Superseding: [v9] Add octal DTR support for Macronix flash (2024-07-18T03:46:08):
    [v9,1/6] mtd: spi-nor: add Octal DTR support for Macronix flash
    [v9,2/6] spi: spi-mem: Allow specifying the byte order in Octal DTR mode
    [v9,3/6] mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
    [v9,4/6] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
    [v9,5/6] spi: mxic: Add support for swapping byte
    [v9,6/6] mtd: spi-nor: add support for Macronix Octal flash


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


