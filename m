Return-Path: <linux-spi+bounces-9483-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F271B27F9F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B13A3950
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FDE2798E1;
	Fri, 15 Aug 2025 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmBlotvc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AF26C38E
	for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259006; cv=none; b=pvlJHPpQudcAatQVLYLfgB7Hv22aXpmIfbpNsvGZVe4Dx4v0dL2LYK3N//Y7x/D4u3wS92SGCwXtdwNpFIigC7XXh0JoQMVCqzqU5Y8gEAfVqV321HuncNEESEfEOLhvdaVb7YEgk2aW71SKWkjZvDDKRLUClbcHOuZLT5KYgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259006; c=relaxed/simple;
	bh=n6dZyvCrligURCtdLcSFf42h2XzdlnhGWwrSjAhKR9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QHTr+q6X+NTBEvuSpHX51K7vfdCvaPo7tW6njkRLvoVY/gOtzuPChZo+oQaeGDfPJ3CZHAusuN24TbMpgndfBGi51Ixs9FYjHsF+Uog68jCnENGAYai86blFB1CAu8JEuxHoY2sQDI2GvRa0cCJI9cPvzTHdxV5Ac79FAaM4iPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmBlotvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207FBC4CEEB;
	Fri, 15 Aug 2025 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755259006;
	bh=n6dZyvCrligURCtdLcSFf42h2XzdlnhGWwrSjAhKR9I=;
	h=Subject:From:Date:To:From;
	b=FmBlotvcmvYMJ6qk6z8CANJCETa3Sju5HeYpXHrKOw01d0qakRo3BpUD12wqI7xpB
	 wtx9Fp4AuwS8Z86cr9Lk0JxUUJBG45TnktB2+aFx5RcC/hVJMmKREusQrHSHzFOSqB
	 PbSx+s5/x7J96tSoiCNc3isPX9IkhcPea9m5fQYWSuvdR3BtL6Ejft3WknX1VSmIxi
	 Zfg2l2dsXO44xM3stIKCc/sOMs2a9IAvEvOKRxRkB5il4oppiOPu6rNDQyjQ8Gqd/l
	 QU3CaLAthYnUC8go140h+dBalKBGUYL9X4sEQ3zv5lJgpg5udMyjaDIhYtTqhGZOb8
	 PL1hQoxvio3Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9939D0C3D;
	Fri, 15 Aug 2025 11:56:58 +0000 (UTC)
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
 <175525901697.1047030.9998085088874140901.git-patchwork-housekeeping@kernel.org>
Date: Fri, 15 Aug 2025 11:56:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: airoha: driver fixes & improvements (2025-08-15T11:16:06)
  Superseding: [v1] spi: airoha: driver fixes & improvements (2025-08-14T23:11:58):
    [01/13] spi: airoha: remove unnecessary restriction length
    [02/13] spi: airoha: add support of dual/quad wires spi modes
    [03/13] spi: airoha: remove unnecessary switch to non-dma mode
    [04/13] spi: airoha: unify dirmap read/write code
    [05/13] spi: airoha: switch back to non-dma mode in the case of error
    [06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [07/13] spi: airoha: support of dualio/quadio flash reading commands
    [08/13] spi: airoha: allow reading/writing of oob area
    [09/13] spi: airoha: buffer must be 0xff-ed before writing
    [10/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [11/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [12/13] spi: airoha: set custom sector size equal to flash page size
    [13/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


