Return-Path: <linux-spi+bounces-8091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEACAB3B6E
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EAC7A3FA1
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A61C84D0;
	Mon, 12 May 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG7BDmwQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3CD134D4
	for <linux-spi@vger.kernel.org>; Mon, 12 May 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061805; cv=none; b=NipQ3amZt0BxW36hhi22OPZdAk5DdeciKkK2RTHRX0Qk1JhyE0dQqInAngJJBYFKifTV6GWRDdTYu9rp7EBYjN5fwob0/06kbfPOvxFqTN3QJqc+30jsp7Wp+pSeYGzM0+xT64Zgn207apoWz1Qa/JXWZHDDzLNFGzzetw2uH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061805; c=relaxed/simple;
	bh=scu3NtDAuGW+eyMxq5v9TfWhXeQB/OB7BfxJHSUPXVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YyJyGcizzdS6ZWYodO9ipChvWfIvi7xHuHYsaob15cS74Jx0E3e3eem1AZ+d8NuZr8wTnVbuY5Uq4seK0cQASYHdGNlbIJ580caRV1ZDr2AWbkemZC26mtbuxC2v9PeMEOPy987IrezVh1KVs1OUKwP82gIeF5p/suyYuKLQnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG7BDmwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE5C4CEE7;
	Mon, 12 May 2025 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747061804;
	bh=scu3NtDAuGW+eyMxq5v9TfWhXeQB/OB7BfxJHSUPXVg=;
	h=Subject:From:Date:To:From;
	b=tG7BDmwQ3Fe7rKR7jhUUd6VNdwTRbVIGYavSqBtLzKthXLjH5YwP3IxYg83Nfnpi3
	 ZXpYa/RR+lPsieoPv+5KEpnu9CgByLdXF2LzPPS53YP1L/gJ5juvdQRwJ4As2FXjKL
	 yLL9LpV298va+2sVeMfZO6cL4KyKr2kwuVC30YwaLdrml3j/B+bsPKT4qTVhjwUxX/
	 hmckEDdxfhOwsxskSmyFboRXmHA8ws817wpVT+qjT4tU5F37Qvv/RRMXV0fcSVuJoM
	 PFtQn/Razp/QOFgpAXT68MrYiYO/y/T+nuJu9VM10bcQlSf0SjtDs//yxDsNb6FrSz
	 eS4k/lCDwwIkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9B39D6555;
	Mon, 12 May 2025 14:57:23 +0000 (UTC)
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
 <174706184242.973130.14763755620328244451.git-patchwork-housekeeping@kernel.org>
Date: Mon, 12 May 2025 14:57:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] clk: clk-axi-clkgen: improvements and some fixes (2025-05-12T14:46:43)
  Superseding: [v4] clk: clk-axi-clkgen: improvements and some fixes (2025-05-05T16:41:35):
    [v4,1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
    [v4,2/7] clk: clk-axi-clkgen: make sure to include mod_devicetable.h
    [v4,3/7] include: linux: move adi-axi-common.h out of fpga
    [v4,4/7] include: fpga: adi-axi-common: add new helper macros
    [v4,5/7] clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
    [v4,6/7] clk: clk-axi-clkgen move to min/max()
    [v4,7/7] clk: clk-axi-clkgen: fix coding style issues


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


