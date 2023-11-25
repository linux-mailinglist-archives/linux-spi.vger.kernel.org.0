Return-Path: <linux-spi+bounces-39-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150E7F89CB
	for <lists+linux-spi@lfdr.de>; Sat, 25 Nov 2023 10:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00C3B20E18
	for <lists+linux-spi@lfdr.de>; Sat, 25 Nov 2023 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163DC147;
	Sat, 25 Nov 2023 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFpVowMR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF7C146
	for <linux-spi@vger.kernel.org>; Sat, 25 Nov 2023 09:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89696C433C7;
	Sat, 25 Nov 2023 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700906182;
	bh=4q1dKuctE0TAXJuAdFWos/x2TjNn7iCWqPe5DZM88Ho=;
	h=Subject:From:Date:To:From;
	b=XFpVowMRLicreAUHWdqR5FdA/28fw0qNwLZ0+nlDAtQTExzJgUN/2vpNJ3xEf0tpQ
	 FJLrFbLMWyEbSIBxhiJ02avjrhs8JmNla+bUAWeFMgRoDK189p7X7rhPPp/gRNZBEX
	 e/ddu8eqQs9xITyN8kcm3x5toJLQeV1Vh6gDZ7iqmrpYF2hFjrZUMMk3FF8SNJi2pl
	 eCvd8EIwSjf3KfgrDrADSA3L9Fx/ugpRdGh9ryVQFNa+lN4c9Hato/CQ+c8cp/LMkW
	 I8oDh5fcBOpE7EpkPEMPZJQWxk7L5lL5EZhNfbnLG9jm+r4V26T6dCozb8YKgK1DxA
	 T9XcbQ7khgVQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AE22EAA95E;
	Sat, 25 Nov 2023 09:56:22 +0000 (UTC)
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
 <170090618228.31371.3597954159077010110.git-patchwork-housekeeping@kernel.org>
Date: Sat, 25 Nov 2023 09:56:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v11] spi: Add support for stacked/parallel memories (2023-11-25T09:21:27)
  Superseding: [v10] spi: Add support for stacked/parallel memories (2023-11-18T13:54:38):
    [v10,1/8] spi: Add multi-cs memories support in SPI core
    [v10,2/8] mtd: spi-nor: Convert macros with inline functions
    [v10,3/8] mtd: spi-nor: Add APIs to set/get nor->params
    [v10,4/8] mtd: spi-nor: Move write enable inside specific write & erase APIs
    [v10,5/8] mtd: spi-nor: Add stacked memories support in spi-nor
    [v10,6/8] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
    [v10,7/8] mtd: spi-nor: Add parallel memories support in spi-nor
    [v10,8/8] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


